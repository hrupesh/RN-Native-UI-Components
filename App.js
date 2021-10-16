import React, {useRef} from 'react';
import {
  findNodeHandle,
  Platform,
  Pressable,
  requireNativeComponent,
  StyleSheet,
  UIManager,
  View,
} from 'react-native';

const MapView = requireNativeComponent('RNTMap');
const CameraView = requireNativeComponent('RNCSTMCamera');

const App = () => {
  const componentRef = useRef(null);

  const dispatchCaptureCommand = () => {
    UIManager.dispatchViewManagerCommand(
      findNodeHandle(componentRef.current),
      UIManager.RNCSTMCamera.Commands.captureImage.toString(),
      [findNodeHandle(componentRef.current)],
    );
  };

  return (
    <View style={styles.container}>
      {Platform.select({
        ios: <MapView style={styles.cameraView} />,
        android: <CameraView ref={componentRef} style={styles.cameraView} />,
      })}
      <Pressable style={styles.captureBtn} onPress={dispatchCaptureCommand} />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'white',
  },
  cameraView: {flex: 1},
  captureBtn: {
    position: 'absolute',
    bottom: 40,
    alignSelf: 'center',
    height: 75,
    width: 75,
    borderRadius: 40,
    backgroundColor: '#fff',
    borderColor: '#fff4',
    borderWidth: 6,
  },
});

export default App;
