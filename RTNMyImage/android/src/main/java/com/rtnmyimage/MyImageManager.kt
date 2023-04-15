package com.rtnmyimage

import coil.load
import coil.size.Scale
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.uimanager.SimpleViewManager
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.ViewManagerDelegate
import com.facebook.react.uimanager.annotations.ReactProp
import com.facebook.react.viewmanagers.RTNMyImageManagerDelegate
import com.facebook.react.viewmanagers.RTNMyImageManagerInterface

class MyImageManager(private val context: ReactApplicationContext) :
    SimpleViewManager<MyImage>(),
    RTNMyImageManagerInterface<MyImage> {

    private val mDelegate: ViewManagerDelegate<MyImage>

    init {
        mDelegate = RTNMyImageManagerDelegate(this)
    }

    override fun getDelegate(): ViewManagerDelegate<MyImage> {
        return mDelegate
    }

    override fun getName(): String {
        return NAME
    }

    companion object {
        const val NAME = "RTNMyImage"
    }

    override fun createViewInstance(p0: ThemedReactContext): MyImage {
        return MyImage(context)
    }

    @ReactProp(name = "imageUrl")
    override fun setImageUrl(view: MyImage?, value: String?) {
        view!!.load(value){
            scale(Scale.FILL)
        }
    }

}