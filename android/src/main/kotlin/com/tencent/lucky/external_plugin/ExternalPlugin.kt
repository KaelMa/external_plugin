package com.tencent.lucky.external_plugin

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.view.TextureRegistry

/** ExternalPlugin */
class ExternalPlugin: FlutterPlugin, MethodCallHandler {

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "external_plugin")
      channel.setMethodCallHandler(ExternalPlugin())
    }
  }

  private lateinit var channel : MethodChannel
  private lateinit var textureRegistry: TextureRegistry
  private lateinit var surfaceEntry: TextureRegistry.SurfaceTextureEntry
  private lateinit var externalGLThread: ExternalGLThread

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.flutterEngine.dartExecutor, "external_plugin")
    channel.setMethodCallHandler(this)
    textureRegistry = flutterPluginBinding.textureRegistry
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    val arguments = call.arguments<Map<String,Int>>()
    when (call.method) {
      "create" -> {
        val width = arguments["width"]
        val height = arguments["height"]

        surfaceEntry = textureRegistry.createSurfaceTexture()
        val surfaceTexture = surfaceEntry.surfaceTexture().apply {
          setDefaultBufferSize(width!!, height!!)
        }

        externalGLThread = ExternalGLThread(surfaceTexture, SimpleRenderer())
        externalGLThread.start()

        result.success(surfaceEntry.id())
      }
      "dispose" -> {
        externalGLThread.dispose()
        surfaceEntry.release()
      }
      else -> result.notImplemented()
    }
  }
}
