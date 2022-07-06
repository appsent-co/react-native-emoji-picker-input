import UIKit
import Foundation

@objc(EmojiPickerInputViewManager)
class EmojiPickerInputViewManager: RCTViewManager {

  override func view() -> (EmojiPickerInputView) {
    return EmojiPickerInputView(self.bridge)
  }

  @objc override static func requiresMainQueueSetup() -> Bool {
    return false
  }
}

class EmojiPickerInputView : UIView, EmojiTextFieldDelegate {
  private let bridge: RCTBridge
  private let emojiButton = EmojiTextField()
  
  @objc var fontSize: Int = 14 {
    didSet {
      self.emojiButton.font = self.emojiButton.font?.withSize(CGFloat(fontSize))
    }
  }
  
  @objc var missingEmojiKeyboardTitle: String? {
    didSet {
      if let title = missingEmojiKeyboardTitle {
        self.emojiButton.missingEmojiKeyboardTitle = title
      }
    }
  }
  
  @objc var missingEmojiKeyboardBody: String? {
    didSet {
      if let body = missingEmojiKeyboardBody {
        self.emojiButton.missingEmojiKeyboardBody = body
      }
    }
  }
  
  @objc var missingEmojiKeyboardButton: String? {
    didSet {
      if let button = missingEmojiKeyboardButton {
        self.emojiButton.missingEmojiKeyboardButton = button
      }
    }
  }
  
  @objc var selectedEmoji: String = "🇺🇦" {
    didSet {
      self.emojiButton.text = selectedEmoji
    }
  }
  
  @objc var inputAccessoryViewID: String = "" {
    didSet {
      self.setCustomAccessoryView(inputAccessoryViewID)
    }
  }
    
  @objc var onEmojiSelected: RCTDirectEventBlock?
  
  required init(_ bridge: RCTBridge) {
    self.bridge = bridge
    super.init(frame: .zero)
    
    // Setting up the view can be done here
    emojiButton.translatesAutoresizingMaskIntoConstraints = false
    addSubview(emojiButton)
    
    emojiButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    emojiButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    emojiButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    emojiButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    
    emojiButton.textAlignment = .center
    emojiButton.emojiDelegate = self
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
  private func setCustomAccessoryView(_ id: String) {
    guard let uimanager = bridge.uiManager else {
      return print("[EmojiPickerInput] Unable to get reference to bridge/UIManager")
    }
    
    uimanager.rootView(forReactTag: self.reactTag) { [weak self] rootView  in
      guard let rootView = rootView else {
        return
      }
      
      let accessoryView = self?.bridge.uiManager.view(forNativeID: id, withRootTag: rootView.reactTag)
      guard let accessoryView = accessoryView, accessoryView is RCTInputAccessoryView else {
        return
      }
      
      self?.emojiButton.inputAccessoryView = accessoryView.inputAccessoryView
      
      // Reload the input if it is currently active.
      if (self?.emojiButton.isFirstResponder == true) {
        self?.emojiButton.reloadInputViews()
      }
    }
  }
  
  func emojiSelected(emoji: String) {
    guard let onEmojiSelected = onEmojiSelected else {
      return
    }
    
    let event = [
      "emoji" : emoji,
    ]

    onEmojiSelected(event)
  }
}
