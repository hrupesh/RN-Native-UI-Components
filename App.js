import React, {useRef} from 'react';
import {
  findNodeHandle,
  Platform,
  Pressable,
  StyleSheet,
  UIManager,
  View,
} from 'react-native';
import {CameraView} from './CameraView';

const App = () => {
  const componentRef = useRef(null);

  const dispatchCaptureCommand = () => {
    Platform.OS === 'android'
      ? UIManager?.dispatchViewManagerCommand(
          findNodeHandle(componentRef?.current),
          UIManager?.RNCSTMCamera?.Commands?.captureImage?.toString(),
          [findNodeHandle(componentRef?.current)],
        )
      : UIManager.dispatchViewManagerCommand(
          findNodeHandle(componentRef?.current),
          UIManager.getViewManagerConfig('RNCSTMCamera').Commands.captureImage,
          [],
        );
  };

  return (
    <View style={styles.container}>
      <CameraView ref={componentRef} style={styles.cameraView} />
      <View style={styles.captureBtnContainer}>
        <Pressable style={styles.captureBtn} onPress={dispatchCaptureCommand} />
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'white',
  },
  cameraView: {
    flex: 1,
  },
  captureBtnContainer: {
    backgroundColor: '#0006',
    position: 'absolute',
    bottom: 60,
    alignSelf: 'center',
    alignItems: 'center',
    justifyContent: 'center',
    height: 100,
    width: 100,
    borderRadius: 60,
  },
  captureBtn: {
    height: 75,
    width: 75,
    borderRadius: 37.5,
    backgroundColor: '#fff',
  },
});

export default App;
