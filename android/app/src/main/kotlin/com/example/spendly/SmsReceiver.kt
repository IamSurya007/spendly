package com.example.spendly

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.telephony.SmsMessage
import androidx.core.app.NotificationCompat
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import java.util.regex.Pattern

class SmsReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == "android.provider.Telephony.SMS_RECEIVED") {
            val bundle = intent.extras
            if (bundle != null) {
                try {
                    val pdus = bundle.get("pdus") as Array<*>?
                    if (pdus != null) {
                        for (i in pdus.indices) {
                            val format = bundle.getString("format")
                            val message = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                                SmsMessage.createFromPdu(pdus[i] as ByteArray, format)
                            } else {
                                SmsMessage.createFromPdu(pdus[i] as ByteArray)
                            }
                            val sender = message.originatingAddress ?: ""
                            val body = message.messageBody ?: ""

                            if (!isLikelyTransactionalSender(sender)) continue

                            val parsed = parseSms(body)
                            if (parsed != null) {
                                showNotification(context, parsed, sender)
                            }
                        }
                    }
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        }
    }

    // Known bank/UPI sender headers (without the region prefix, e.g. "HDFCBK" from "VM-HDFCBK")
    private val knownBankSenders = setOf(
        "HDFCBK", "ICICIB", "SBIINB", "SBIPSG", "AXISBK", "KOTAKB",
        "PAYTM", "PYTM", "GPAY", "PHONPE", "AMAZONP", "YESBNK",
        "CENTBK", "PNBSMS", "BOIIND", "UNIONB", "CANBNK", "IDFCFB"
    )

    // DLT-style header pattern: 2-letter telecom prefix + hyphen + 6-char alphanumeric code
    private val dltHeaderPattern = Regex("^[A-Z]{2}-[A-Z0-9]{6}$")

    private fun isLikelyTransactionalSender(sender: String): Boolean {
        val upperSender = sender.uppercase(Locale.ROOT)

        // Plain phone numbers (10+ digits) are never bank transactional senders
        if (upperSender.matches(Regex("^\\+?\\d{7,}$"))) return false

        // Check against known bank/UPI headers (match the code part, ignore prefix)
        val codePart = upperSender.substringAfter("-", upperSender)
        return (knownBankSenders.any { codePart.contains(it) })

//        // Fallback: does it look like a DLT transactional header at all?
//        // (still passes through to content filters — this is permissive, not authoritative)
//        return dltHeaderPattern.matches(upperSender) || upperSender.length in 6..8
    }

    private class ParsedTxn(
        val amount: Double,
        val merchant: String,
        val isDebit: Boolean,
        val date: String,
        val body: String
    )

    private fun parseSms(body: String): ParsedTxn? {
        val cleanBody = body.lowercase(Locale.ROOT)

        // 1. Hard exclude promotional/marketing/offer language first
        val promoKeywords = arrayOf(
            "sale", "offer", "cashback offer", "% off", "discount", "free",
            "win", "buy now", "shop now", "voucher", "coupon", "deal",
            "subscribe", "download the app", "click here", "t&c apply",
            "limited period", "extension", "gift card", "reward points expir",
            "pre-approved", "preapproved", "pre approved", "eligib",
            "instant loan", "apply now", "interest rate", "emi starts",
            "emi at", "loan offer", "credit limit enhance", "insurance",
            "policy", "invest now", "mutual fund", "trade now",
            "install", "http://", "https://", "bit.ly", "unsubscribe",
            "promo", "flat ", "starting at", "hurry", "last chance",
            "exclusive offer", "congratulations", "you have won", "claim now"
        )
        if (promoKeywords.any { cleanBody.contains(it) }) return null

        // 2. Require SPECIFIC transaction evidence — a masked account/card number
        //    or a real reference/txn id — not just the bare word "account"/"card"
        val hasMaskedAccountOrCard = Regex(
            "(?:a/c|acc(?:t|ount)?|card)\\s*(?:no\\.?|number)?\\s*[x*]{2,}\\d{2,}",
            RegexOption.IGNORE_CASE
        ).containsMatchIn(cleanBody)

        val hasTxnRef = Regex(
            "(?:ref|txn|transaction)\\s*(?:no|id)?[:.]?\\s*\\w{4,}",
            RegexOption.IGNORE_CASE
        ).containsMatchIn(cleanBody)

        val hasBalanceMention = cleanBody.contains("avl bal") ||
                cleanBody.contains("available balance") ||
                cleanBody.contains("bal:") ||
                cleanBody.contains("upi")

        val hasAccountEvidence = hasMaskedAccountOrCard || hasTxnRef || hasBalanceMention

        val isDebit = cleanBody.contains("debited") ||
                cleanBody.contains("sent") ||
                cleanBody.contains("paid") ||
                cleanBody.contains("spent") ||
                cleanBody.contains("charged") ||
                cleanBody.contains("withdrawn")

        val isCredit = cleanBody.contains("credited") ||
                cleanBody.contains("received") ||
                cleanBody.contains("deposited") ||
                cleanBody.contains("refunded")

        if (!isDebit && !isCredit) return null
        if (!hasAccountEvidence) return null

        // Amount parsing regex: Matches Rs. 100, Rs. 1,000, INR 500, etc.
        val amountPattern = Pattern.compile(
            "(?:rs\\.?|inr|rupees?)\\s*([0-9,]+\\.?[0-9]*)",
            Pattern.CASE_INSENSITIVE
        )
        val amountMatcher = amountPattern.matcher(body)
        if (!amountMatcher.find()) return null

        val amountStr = amountMatcher.group(1)?.replace(",", "") ?: return null
        val amount = amountStr.toDoubleOrNull() ?: return null
        if (amount <= 0) return null

        val debit = isDebit || !isCredit


        // Extract merchant name
        var merchant = "Unknown Merchant"
        val merchantPatterns = arrayOf(
            Pattern.compile(
                "(?:to|at|towards)\\s+([a-zA-Z0-9\\s\\.\\-\\*]+?)(?:\\s+on|\\s+ref|\\s+via|\\s+from|\\s+balance|\\.|\\n|$)",
                Pattern.CASE_INSENSITIVE
            ),
            Pattern.compile(
                "(?:info:?|vpa:?)\\s*([a-zA-Z0-9\\s\\.\\-\\*@]+?)(?:\\s+on|\\s+ref|\\.|\\n|$)",
                Pattern.CASE_INSENSITIVE
            )
        )

        for (pattern in merchantPatterns) {
            val matcher = pattern.matcher(body)
            if (matcher.find()) {
                val match = matcher.group(1)?.trim() ?: ""
                if (match.isNotEmpty() && match.length < 30) {
                    merchant = cleanMerchantName(match)
                    break
                }
            }
        }

        val df = SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ROOT)
        val dateStr = df.format(Date())

        return ParsedTxn(amount, merchant, debit, dateStr, body)
    }

    private fun cleanMerchantName(name: String): String {
        var cleaned = name.replace(Regex("\\s+"), " ").trim()
        if (cleaned.contains("@")) {
            cleaned = cleaned.split("@")[0]
        }

        // Capitalize words
        val words = cleaned.split(" ")
        val capitalized = StringBuilder()
        for (w in words) {
            if (w.isNotEmpty()) {
                capitalized.append(w.substring(0, 1).uppercase(Locale.ROOT))
                if (w.length > 1) {
                    capitalized.append(w.substring(1).lowercase(Locale.ROOT))
                }
                capitalized.append(" ")
            }
        }
        return capitalized.toString().trim()
    }

    private fun showNotification(context: Context, txn: ParsedTxn, sender: String) {
        val channelId = "spendly_sms_capture"
        val notificationId = System.currentTimeMillis().toInt()

        val manager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                channelId,
                "Spendly Auto-Capture",
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Alerts for incoming transaction SMS"
            }
            manager.createNotificationChannel(channel)
        }

        // Tap opens MainActivity and forwards details
        val intent = Intent(context, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
            putExtra("amount", txn.amount)
            putExtra("merchant", txn.merchant)
            putExtra("isDebit", txn.isDebit)
            putExtra("date", txn.date)
            putExtra("body", txn.body)
            putExtra("source", "sms")
        }

        val pendingIntentFlags = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        } else {
            PendingIntent.FLAG_UPDATE_CURRENT
        }

        val pendingIntent = PendingIntent.getActivity(
            context,
            notificationId,
            intent,
            pendingIntentFlags
        )

        val direction = if (txn.isDebit) "debited" else "credited"
        val message = String.format(
            Locale.ROOT,
            "₹%.2f %s at %s. Tap to confirm.",
            txn.amount,
            direction,
            txn.merchant
        )

        val builder = NotificationCompat.Builder(context, channelId)
            .setSmallIcon(android.R.drawable.ic_menu_my_calendar) // Simple native calendar icon as fallback
            .setContentTitle("New Transaction Detected")
            .setContentText(message)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setAutoCancel(true)
            .setContentIntent(pendingIntent)

        manager.notify(notificationId, builder.build())
    }
}
