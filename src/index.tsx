import type { SyntheticEvent } from 'react';
import {
  requireNativeComponent,
  UIManager,
  Platform,
  ViewStyle,
} from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-emoji-picker-input' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

type EmojiPickerInputProps = {
  style: ViewStyle;
  selectedEmoji: String;
  onEmojiSelected: (
    event: SyntheticEvent<undefined, { emoji: string }>
  ) => void;
  fontSize?: Number;
  inputAccessoryViewID?: String;
  missingEmojiKeyboardTitle?: String;
  missingEmojiKeyboardBody?: String;
  missingEmojiKeyboardButton?: String;
};

const ComponentName = 'EmojiPickerInputView';

export const EmojiPickerInputView =
  UIManager.getViewManagerConfig(ComponentName) != null
    ? requireNativeComponent<EmojiPickerInputProps>(ComponentName)
    : () => {
        throw new Error(LINKING_ERROR);
      };
