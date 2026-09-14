package com.example.spendly

import android.content.Context
import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONArray

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.spendly/sms_channel"
    private var pendingIntentTransaction: HashMap<String, Any>? = null

    companion object {
        private var instance: MainActivity? = null

        fun onLiveTransactionCaptured(txnMap: HashMap<String, Any>) {
            instance?.let { activity ->
                activity.runOnUiThread {
                    activity.flutterEngine?.let { engine ->
                        MethodChannel(engine.dartExecutor.binaryMessenger, "com.example.spendly/sms_channel")
                            .invokeMethod("onTransactionCaptured", txnMap)
                    }
                }
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        instance = this
        handleIntent(intent)
    }

    override fun onDestroy() {
        if (instance == this) {
            instance = null
        }
        super.onDestroy()
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleIntent(intent)
        sendPendingTransactionToFlutter()
    }

    private fun handleIntent(intent: Intent?) {
        if (intent != null && intent.hasExtra("amount")) {
            val amount = intent.getDoubleExtra("amount", 0.0)
            val merchant = intent.getStringExtra("merchant") ?: "Unknown"
            val isDebit = intent.getBooleanExtra("isDebit", true)
            val date = intent.getStringExtra("date") ?: ""
            val body = intent.getStringExtra("body") ?: ""
            val source = intent.getStringExtra("source") ?: "sms"

            pendingIntentTransaction = hashMapOf(
                "amount" to amount,
                "merchant" to merchant,
                "isDebit" to isDebit,
                "date" to date,
                "body" to body,
                "source" to source
            )
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getPendingTransactions" -> {
                    val list = getPendingTransactionsList()
                    result.success(list)
                }
                "getPendingTransaction" -> {
                    val list = getPendingTransactionsList()
                    if (list.isNotEmpty()) {
                        result.success(list.first())
                    } else {
                        result.success(null)
                    }
                }
                "clearPendingTransactions" -> {
                    clearPendingTransactions()
                    result.success(true)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun getPendingTransactionsList(): List<HashMap<String, Any>> {
        val resultList = ArrayList<HashMap<String, Any>>()

        // 1. Read from SharedPreferences
        val prefs = getSharedPreferences("spendly_sms_prefs", Context.MODE_PRIVATE)
        val jsonStr = prefs.getString("pending_transactions", "[]") ?: "[]"
        try {
            val jsonArray = JSONArray(jsonStr)
            for (i in 0 until jsonArray.length()) {
                val obj = jsonArray.getJSONObject(i)
                val map = HashMap<String, Any>()
                val keys = obj.keys()
                while (keys.hasNext()) {
                    val key = keys.next()
                    when (val value = obj.get(key)) {
                        is Double -> map[key] = value
                        is Int -> map[key] = value.toDouble()
                        is Boolean -> map[key] = value
                        else -> map[key] = value.toString()
                    }
                }
                resultList.add(map)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }

        // 2. Add single intent pending transaction if present
        pendingIntentTransaction?.let { intentTxn ->
            val exists = resultList.any {
                it["amount"] == intentTxn["amount"] &&
                it["merchant"] == intentTxn["merchant"] &&
                it["date"] == intentTxn["date"]
            }
            if (!exists) {
                resultList.add(intentTxn)
            }
        }

        return resultList
    }

    private fun clearPendingTransactions() {
        val prefs = getSharedPreferences("spendly_sms_prefs", Context.MODE_PRIVATE)
        prefs.edit().remove("pending_transactions").apply()
        pendingIntentTransaction = null
    }

    private fun sendPendingTransactionToFlutter() {
        flutterEngine?.let { engine ->
            val list = getPendingTransactionsList()
            if (list.isNotEmpty()) {
                for (txn in list) {
                    MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL)
                        .invokeMethod("onTransactionCaptured", txn)
                }
                clearPendingTransactions()
            }
        }
    }
}
