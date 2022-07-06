#import <React/RCTViewManager.h>


@interface RCT_EXTERN_MODULE(EmojiPickerInputViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(onEmojiSelected, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(fontSize, NSInteger)
RCT_EXPORT_VIEW_PROPERTY(selectedEmoji, NSString)
RCT_EXPORT_VIEW_PROPERTY(inputAccessoryViewID, NSString)
RCT_EXPORT_VIEW_PROPERTY(missingEmojiKeyboardTitle, NSString)
RCT_EXPORT_VIEW_PROPERTY(missingEmojiKeyboardBody, NSString)
RCT_EXPORT_VIEW_PROPERTY(missingEmojiKeyboardButton, NSString)

@end
