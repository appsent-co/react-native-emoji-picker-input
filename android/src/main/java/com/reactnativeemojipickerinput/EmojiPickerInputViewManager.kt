package com.reactnativeemojipickerinput

import android.R
import android.app.Activity
import android.content.Context
import android.graphics.Color
import android.view.Gravity
import android.view.View
import android.view.View.OnFocusChangeListener
import android.view.inputmethod.EditorInfo
import android.view.inputmethod.InputMethodManager
import android.widget.TextView
import com.facebook.react.common.MapBuilder
import com.facebook.react.uimanager.SimpleViewManager
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.UIManagerHelper
import com.facebook.react.uimanager.UIManagerModule
import com.facebook.react.uimanager.annotations.ReactProp
import com.vanniktech.emoji.EmojiEditText
import com.vanniktech.emoji.EmojiPopup
import com.vanniktech.emoji.installDisableKeyboardInput
import com.vanniktech.emoji.installForceSingleEmoji


class EmojiPickerInputViewManager : SimpleViewManager<View>() {
  override fun getName() = "EmojiPickerInputView"
  private var editText: EmojiEditText? = null

  override fun createViewInstance(reactContext: ThemedReactContext): View {
    val rootView: View = reactContext.currentActivity?.findViewById(R.id.content)
            ?: return View(reactContext)

    val editText = EmojiEditText(reactContext)
    this.editText = editText
    editText.gravity = Gravity.CENTER
    editText.imeOptions = EditorInfo.IME_ACTION_DONE
    editText.background.clearColorFilter()
    editText.onFocusChangeListener = OnFocusChangeListener { view, focused ->
      if (!focused) {
        hideKeyboard(reactContext, editText)
      }
    }

    val emojiPopup = EmojiPopup(rootView, editText, onEmojiClickListener = {
      val event = EmojiSelectedEvent(UIManagerHelper.getSurfaceId(reactContext), editText.id)
      event.emoji = it.unicode
      reactContext.getNativeModule(UIManagerModule::class.java)?.eventDispatcher?.dispatchEvent(event)
      editText.clearFocus()
    })

    editText.installForceSingleEmoji()
    editText.installDisableKeyboardInput(emojiPopup)

    return editText
  }

  fun hideKeyboard(reactContext: ThemedReactContext, view: View) {
    val inputMethodManager: InputMethodManager = reactContext.getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
    inputMethodManager.hideSoftInputFromWindow(view.windowToken, 0)
  }

  @ReactProp(name = "selectedEmoji")
  fun setSelectedEmoji(view: View, emoji: String) {
    editText?.setText(emoji, TextView.BufferType.EDITABLE)
  }

  @ReactProp(name = "fontSize")
  fun setFontSize(view: View, value: Int) {
    editText?.textSize = value.toFloat()
  }

  override fun getExportedCustomDirectEventTypeConstants(): MutableMap<String, Any> {
    return MapBuilder.builder<String, Any>()
      .put(EmojiSelectedEvent.EVENT_NAME, MapBuilder.of(
        "registrationName", "onEmojiSelected"
      )).build()
  }
}
