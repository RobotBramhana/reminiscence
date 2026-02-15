package com.robotbramhana.reminiscence

import android.net.ConnectivityManager
import android.os.Bundle
import android.view.View
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    private lateinit var webView: WebView
    private val url = "http://tiny.local:8080" // <-- your Pi server URL

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Full-screen kiosk mode
        window.decorView.systemUiVisibility =
            View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY or
            View.SYSTEM_UI_FLAG_FULLSCREEN or
            View.SYSTEM_UI_FLAG_HIDE_NAVIGATION

        webView = findViewById(R.id.webview)
        webView.webViewClient = WebViewClient() // open links inside the WebView
        webView.settings.javaScriptEnabled = true

        if (isOnline()) {
            webView.loadUrl(url)
        } else {
            // TODO: show offline UI
        }
    }

    private fun isOnline(): Boolean {
        val cm = getSystemService(CONNECTIVITY_SERVICE) as ConnectivityManager
        return cm.activeNetworkInfo?.isConnected == true
    }
}
