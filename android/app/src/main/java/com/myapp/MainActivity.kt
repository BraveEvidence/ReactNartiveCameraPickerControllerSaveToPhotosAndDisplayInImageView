package com.myapp

import android.Manifest
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.widget.ImageView
import android.widget.Toast
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.content.ContextCompat
import androidx.core.content.FileProvider
import com.facebook.react.ReactActivity
import com.facebook.react.ReactActivityDelegate
import com.facebook.react.defaults.DefaultNewArchitectureEntryPoint.concurrentReactEnabled
import com.facebook.react.defaults.DefaultNewArchitectureEntryPoint.fabricEnabled
import com.facebook.react.defaults.DefaultReactActivityDelegate
import com.facebook.react.modules.core.DeviceEventManagerModule
import java.io.File

class MainActivity : ReactActivity() {
    /**
     * Returns the name of the main component registered from JavaScript. This is used to schedule
     * rendering of the component.
     */

    private val REQUEST_CODE_PERMISSIONS = 10
    private val REQUIRED_PERMISSIONS = mutableListOf(Manifest.permission.CAMERA).apply {
        if (Build.VERSION.SDK_INT <= Build.VERSION_CODES.P) {
            add(Manifest.permission.WRITE_EXTERNAL_STORAGE)
        }
    }.toTypedArray()

    override fun getMainComponentName(): String? {
        return "myapp"
    }

    /**
     * Returns the instance of the [ReactActivityDelegate]. Here we use a util class [ ] which allows you to easily enable Fabric and Concurrent React
     * (aka React 18) with two boolean flags.
     */
    override fun createReactActivityDelegate(): ReactActivityDelegate {
        return DefaultReactActivityDelegate(
            this,
            mainComponentName!!,  // If you opted-in for the New Architecture, we enable the Fabric Renderer.
            fabricEnabled,  // fabricEnabled
            // If you opted-in for the New Architecture, we enable Concurrent React (i.e. React 18).
            concurrentReactEnabled // concurrentRootEnabled
        )
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == REQUEST_CODE_PERMISSIONS) {

            if (allPermissionsGranted()) {
                openCamera()
            } else {
                Toast.makeText(this,"Fail",Toast.LENGTH_LONG).show()
//                context
//                    ?.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter::class.java)
//                    ?.emit("result", false)
            }
        }
    }

    private fun allPermissionsGranted() = REQUIRED_PERMISSIONS.all {
        ContextCompat.checkSelfPermission(
            this, it
        ) == PackageManager.PERMISSION_GRANTED
    }

    private lateinit var uri: Uri

    private val takePicture = registerForActivityResult(ActivityResultContracts.TakePicture()) { isSaved ->
        if (isSaved)
        {
            val context = this.reactNativeHost.reactInstanceManager.currentReactContext
            context
                    ?.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter::class.java)
                    ?.emit("result", uri.toString())
        }
    }

    private fun openCamera(){
        val photoFile = File.createTempFile(
            "IMG_",
            ".jpg",
            getExternalFilesDir(Environment.DIRECTORY_PICTURES)
        )

        uri = FileProvider.getUriForFile(
            this,
            "${packageName}.provider",
            photoFile
        )

        takePicture.launch(uri)
    }
}