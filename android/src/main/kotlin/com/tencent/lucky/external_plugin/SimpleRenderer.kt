package com.tencent.lucky.external_plugin

import android.opengl.GLES20
import kotlin.math.sin

/**
 * Copyright (C), 2019-2020, 腾讯科技（上海）有限公司
 * FileName: CustomRenderer
 * Author: kaelma
 * Date: 2020/8/6 8:45 PM
 * Description: one simplest gl render
 */
class SimpleRenderer: ExternalGLThread.Renderer {

    private var tick = 0.0

    override fun onCreate() {
    }

    override fun onDraw(): Boolean {
        tick += Math.PI / 60

        val green = ((sin(tick) + 1) / 2).toFloat()

        GLES20.glClearColor(0f, green, 0f, 1f)

        GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT)

        return true
    }

    override fun onDispose() {

    }
}