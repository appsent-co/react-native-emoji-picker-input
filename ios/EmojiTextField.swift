//
//  EmojiTextField.swift
//  react-native-emoji-picker-input
//
//  Created by Maxence Henneron on 6/30/22.
//
import Foundation
import UIKit


protocol EmojiTextFieldDelegate : NSObjectProtocol {
  func emojiSelected(emoji: String)
}

class EmojiTextField: UITextField {
  weak open var emojiDelegate: EmojiTextFieldDelegate? = nil

  var missingEmojiKeyboardTitle: String = "Missing Emoji Keyboard"
  var missingEmojiKeyboardBody: String = "Please go to your iPhone Settings \n-> General \n-> Keyboard \nand add the emoji keyboard."
  var missingEmojiKeyboardButton: String = "Ok"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.delegate = self
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.delegate = self
  }

  
  override weak open var delegate : UITextFieldDelegate? {
    willSet {
      assert(delegate == nil || delegate is EmojiTextField, "Do not override the delegate.")
    }
  }

    
  // required for iOS 13
  override var textInputContextIdentifier: String? { "emoji-text-field" } // return non-nil to show the Emoji keyboard ¯\_(ツ)_/¯
  
  override var textInputMode: UITextInputMode? {
    for mode in UITextInputMode.activeInputModes {
      if mode.primaryLanguage == "emoji" {
        return mode
      }
    }
    return super.textInputMode
  }
  
  @objc func reloadInputViewsAsync() {
    guard isFirstResponder else {
      return
    }
    
    DispatchQueue.main.async { [weak self] in
      self?.reloadInputViews()
    }
  }
}

extension EmojiTextField : UITextFieldDelegate {
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    if textField.textInputMode?.primaryLanguage != "emoji" {
      // Try to alert
      let alertController = UIAlertController(title: missingEmojiKeyboardTitle, message: missingEmojiKeyboardBody, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: missingEmojiKeyboardButton, style: UIAlertAction.Style.default, handler: nil))
      UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
      
      return false
    }
      
    return true
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    // Fixes a bug where sometimes the keyboard opens instead of the emoji picker
    // Especially when coming from a "number pad" text input
    self.reloadInputViewsAsync()
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString: String) -> Bool {
    let newString = replacementString
    if (newString.containsSingleEmoji(newString)) {
      textField.text = newString
      emojiDelegate?.emojiSelected(emoji: newString)
        
      return false
    }
    
    return false
  }
}

extension String {
  func containsSingleEmoji(_ text: String) -> Bool {
    guard text.count == 1 else {
      return false
    }
      
    let isCombinedIntoEmoji = unicodeScalars.count > 1 && unicodeScalars.contains { $0.properties.isJoinControl || $0.properties.isVariationSelector }
    if (isCombinedIntoEmoji) {
      return true
    }
    
    return text.unicodeScalars.first?.properties.isEmoji ?? false
  }
}
