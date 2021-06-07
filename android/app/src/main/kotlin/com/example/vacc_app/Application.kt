package com.example.vacc_app

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry


class Application : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()
    }

    override fun registerWith(registry: PluginRegistry?) {
        TODO("Not yet implemented")
    }
}