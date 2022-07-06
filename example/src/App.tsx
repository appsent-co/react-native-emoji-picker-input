import * as React from 'react';
import { useState } from 'react';

import { Button, InputAccessoryView, StyleSheet, View } from 'react-native';
import { EmojiPickerInputView } from '@appsent-co/react-native-emoji-picker-input';

const INPUT_ACCESSORY_VIEW_ID = 'explode';

export default function App() {
  const [selectedEmoji, setSelectedEmoji] = useState('🐛');

  return (
    <View style={styles.container}>
      <EmojiPickerInputView
        style={styles.box}
        fontSize={22}
        inputAccessoryViewID={INPUT_ACCESSORY_VIEW_ID}
        selectedEmoji={selectedEmoji}
        onEmojiSelected={(event) => {
          const {
            nativeEvent: { emoji },
          } = event;

          setSelectedEmoji(emoji);
        }}
      />

      <InputAccessoryView nativeID={INPUT_ACCESSORY_VIEW_ID}>
        <Button
          onPress={() => setSelectedEmoji('🧨')}
          title="русский военный корабль иди"
        />
      </InputAccessoryView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
  },
  box: {
    width: 60,
    height: 90,
    marginVertical: 20,
    // backgroundColor: 'red',
  },
});
