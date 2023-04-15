package com.rtnmycamera

import android.Manifest
import android.os.Build
import androidx.core.app.ActivityCompat
import com.facebook.react.bridge.ReactApplicationContext


class MyCameraModule(val context: ReactApplicationContext?): NativeMyCameraSpec(context) {

    private val REQUEST_CODE_PERMISSIONS = 10
    private val REQUIRED_PERMISSIONS = mutableListOf(Manifest.permission.CAMERA).apply {
        if (Build.VERSION.SDK_INT <= Build.VERSION_CODES.P) {
            add(Manifest.permission.WRITE_EXTERNAL_STORAGE)
        }
    }.toTypedArray()

    override fun getName(): String {
        return NAME
    }

    override fun takePhoto() {
        ActivityCompat.requestPermissions(
            context?.currentActivity!!,
            REQUIRED_PERMISSIONS,
            REQUEST_CODE_PERMISSIONS
        )
    }


    companion object {
        const val NAME = "RTNMyCamera"
    }







}