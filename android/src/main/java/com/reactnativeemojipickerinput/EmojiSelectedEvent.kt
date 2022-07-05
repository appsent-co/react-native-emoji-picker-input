package com.reactnativeemojipickerinput

import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.WritableMap
import com.facebook.react.uimanager.events.Event

class EmojiSelectedEvent(surfaceId: Int, viewId: Int): Event<EmojiSelectedEvent>(surfaceId, viewId) {
  companion object {
    const val EVENT_NAME = "onEmojiSelected"
  }

  lateinit var emoji: String

  override fun getEventName(): String {
    return EVENT_NAME
  }

  override fun getCoalescingKey(): Short {
    return  0
  }

  override fun canCoalesce(): Boolean {
    return false
  }

  override fun getEventData(): WritableMap? {
    val eventData = Arguments.createMap()
    eventData.putString("emoji", emoji)
    return eventData
  }
}
