package com.reactnativeemojipickerinput

import androidx.emoji.bundled.BundledEmojiCompatConfig
import androidx.emoji.text.EmojiCompat
import com.facebook.react.ReactPackage
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.uimanager.ViewManager
import com.vanniktech.emoji.EmojiManager.install
import com.vanniktech.emoji.googlecompat.GoogleCompatEmojiProvider

class EmojiPickerInputPackage : ReactPackage {
    override fun createNativeModules(reactContext: ReactApplicationContext): List<NativeModule> {
        return emptyList()
    }

    override fun createViewManagers(reactContext: ReactApplicationContext): List<ViewManager<*, *>> {
      val config: EmojiCompat.Config = BundledEmojiCompatConfig(reactContext)
      config.setReplaceAll(true)
      val emojiCompat = EmojiCompat.init(config)
      install(GoogleCompatEmojiProvider(emojiCompat))

      return listOf(EmojiPickerInputViewManager())
    }
}
