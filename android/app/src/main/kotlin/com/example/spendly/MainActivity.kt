package com.example.spendly

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.spendly/sms_channel"
    private var pendingTransaction: HashMap<String, Any>? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        handleIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleIntent(intent)
        // If the app is already running, send the pending transaction to Flutter immediately
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

            pendingTransaction = hashMapOf(
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
                "getPendingTransaction" -> {
                    result.success(pendingTransaction)
                    pendingTransaction = null // Clear once consumed
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun sendPendingTransactionToFlutter() {
        flutterEngine?.let { engine ->
            pendingTransaction?.let { txn ->
                MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL)
                    .invokeMethod("onTransactionCaptured", txn)
                pendingTransaction = null // Clear once sent
            }
        }
    }
}
