package com.rtnmyimage

import com.facebook.react.ReactPackage
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.uimanager.ViewManager
import java.util.Collections

class MyImagePackage : ReactPackage {
    override fun createViewManagers(reactContext: ReactApplicationContext): List<ViewManager<*, *>> {
        return Collections.singletonList(MyImageManager(reactContext))
    }

    override fun createNativeModules(reactContext: ReactApplicationContext): List<NativeModule> {
        return emptyList()
    }
}