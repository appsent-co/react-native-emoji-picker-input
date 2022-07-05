import UIKit

@objc(EmojiPickerInputViewManager)
class EmojiPickerInputViewManager: RCTViewManager {

  override func view() -> (EmojiPickerInputView) {
    return EmojiPickerInputView()
  }

  @objc override static func requiresMainQueueSetup() -> Bool {
    return false
  }
}

class EmojiPickerInputView : UIView, EmojiTextFieldDelegate {
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
  
  @objc var onEmojiSelected: RCTDirectEventBlock?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
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
    super.init(coder: coder)
  }
    
  func emojiSelected(emoji: String) {
    emojiButton.resignFirstResponder()
    
    guard let onEmojiSelected = onEmojiSelected else {
      return
    }
    
    let event = [
      "emoji" : emoji,
    ]

    onEmojiSelected(event)
  }
}
