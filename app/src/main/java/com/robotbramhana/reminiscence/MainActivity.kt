package com.robotbramhana.reminiscence

import android.annotation.SuppressLint
import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.view.View
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    lateinit var webView: WebView
    lateinit var offlineText: TextView

    val url = "http://tiny.local:8080"

    override fun onCreate(savedInstanceState: Bundle?) {

        super.onCreate(savedInstanceState)

        webView = WebView(this)

        offlineText = TextView(this)

        offlineText.text = getString(R.string.offline)

        offlineText.textSize = 24f

        offlineText.visibility = View.GONE

        setContentView(webView)

        configureWebView()

        enableKioskMode()

        monitorConnection()
    }

    @SuppressLint("SetJavaScriptEnabled")
    fun configureWebView() {

        webView.settings.javaScriptEnabled = true

        webView.settings.domStorageEnabled = true

        webView.webViewClient = WebViewClient()
    }

    fun monitorConnection() {

        Handler(Looper.getMainLooper()).postDelayed(object : Runnable {

            override fun run() {

                if (isOnline()) {

                    webView.loadUrl(url)

                }

                Handler(Looper.getMainLooper()).postDelayed(this, 5000)
            }

        }, 0)
    }

    fun isOnline(): Boolean {

        val cm = getSystemService(Context.CONNECTIVITY_SERVICE)
                as ConnectivityManager

        val network = cm.activeNetwork ?: return false

        val capabilities =
            cm.getNetworkCapabilities(network) ?: return false

        return capabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
    }

    fun enableKioskMode() {

        window.decorView.systemUiVisibility =
            View.SYSTEM_UI_FLAG_FULLSCREEN or
            View.SYSTEM_UI_FLAG_HIDE_NAVIGATION or
            View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
    }
}
