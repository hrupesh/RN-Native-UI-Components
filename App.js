import React, {useRef} from 'react';
import {
  findNodeHandle,
  Pressable,
  requireNativeComponent,
  StyleSheet,
  UIManager,
  View,
} from 'react-native';

const CameraView = requireNativeComponent('RNCSTMCamera');

const App = () => {
  const componentRef = useRef(null);

  const dispatchCaptureCommand = () => {
    UIManager?.dispatchViewManagerCommand(
      findNodeHandle(componentRef?.current),
      UIManager?.RNCSTMCamera?.Commands?.captureImage?.toString(),
      [findNodeHandle(componentRef?.current)],
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
    backgroundColor: '#0004',
    position: 'absolute',
    bottom: 60,
    alignSelf: 'center',
    alignItems: 'center',
    justifyContent: 'center',
    height: 90,
    width: 90,
    borderRadius: 60,
  },
  captureBtn: {
    height: 70,
    width: 70,
    borderRadius: 60,
    backgroundColor: '#fff',
  },
});

export default App;
