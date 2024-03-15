package com.myorg.mynotes

import android.os.Build
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        Log.d("MainActivity", "SDK_INT: ${Build.VERSION.SDK_INT}")
        // Dynamically set splash screen theme based on Android version
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            Log.d("MainActivity", "Using SplashTheme_S for Android 12 or higher")
            setTheme(R.style.SplashTheme_S)
            Log.d("MainActivity", "After setTheme function")
        } else{
            Log.d("MainActivity", "Using SplashTheme for Android versions below 12")
            setTheme(R.style.SplashTheme)
            Log.d("MainActivity", "After setTheme function")
        }
        super.onCreate(savedInstanceState)
    }
}
