import * as React from 'react';
import { useState } from 'react';

import { StyleSheet, View } from 'react-native';
import { EmojiPickerInputView } from 'react-native-emoji-picker-input';

export default function App() {
  const [selectedEmoji, setSelectedEmoji] = useState('🐛');

  return (
    <View style={styles.container}>
      <EmojiPickerInputView
        style={styles.box}
        fontSize={22}
        selectedEmoji={selectedEmoji}
        onEmojiSelected={(event) => {
          const {
            nativeEvent: { emoji },
          } = event;

          setSelectedEmoji(emoji);
        }}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 90,
    marginVertical: 20,
    backgroundColor: 'red',
  },
});
