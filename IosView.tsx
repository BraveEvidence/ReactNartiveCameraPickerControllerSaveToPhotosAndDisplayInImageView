import React from 'react';
import {
  NativeEventEmitter,
  NativeModules,
  Text,
  TouchableOpacity,
  View,
} from 'react-native';
import RTNMyCamera from 'rtn-my-camera/js/NativeMyCamera';
import RTNMyImage from 'rtn-my-image/js/RTNMyImageNativeComponent';

const IosView = () => {
  const eventEmitter = new NativeEventEmitter(NativeModules.EventEmitter);
  const [imageUri, setImageUri] = React.useState('');

  React.useEffect(() => {
    let eventsSubscription = eventEmitter.addListener('onMyEvent', event => {
      setImageUri(event); // Prints "Hello Emitter!"
    });

    return () => {
      eventsSubscription.remove();
    };
  }, []);

  return (
    <View>
      <TouchableOpacity
        onPress={() => {
          RTNMyCamera?.takePhoto();
        }}>
        <Text>Capture Photo</Text>
      </TouchableOpacity>
      {imageUri !== '' && (
        <RTNMyImage imageUrl={imageUri} style={{width: 100, height: 100}} />
      )}
    </View>
  );
};

export default IosView;
