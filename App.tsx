/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React from 'react';
import type {PropsWithChildren} from 'react';
import {
  Platform,
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  useColorScheme,
  View,
} from 'react-native';

import {
  Colors,
  DebugInstructions,
  Header,
  LearnMoreLinks,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';
import AndroidView from './AndroidView';
import IosView from './IosView';

function App(): JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  return (
    <SafeAreaView style={backgroundStyle}>
      <StatusBar
        barStyle={isDarkMode ? 'light-content' : 'dark-content'}
        backgroundColor={backgroundStyle.backgroundColor}
      />
      {Platform.OS === 'android' ? <AndroidView /> : <IosView />}
    </SafeAreaView>
  );
}

//yarn add ./RTNMyImage
//yarn add ./RTNMyCamera

// node myapp/node_modules/react-native/scripts/generate-codegen-artifacts.js \
//  --path myapp/ \
//  --outputPath myapp/RTNMyImage/generated/

//  node myapp/node_modules/react-native/scripts/generate-codegen-artifacts.js \
//  --path myapp/ \
//  --outputPath myapp/RTNMyCamera/generated/

export default App;
