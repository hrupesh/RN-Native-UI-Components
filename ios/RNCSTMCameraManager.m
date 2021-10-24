//
//  RNCSTMCameraManager.m
//  NativeComponentsDemo
//
//  Created by Rupesh Chaudhari on 15/10/21.
//
#import "RNCSTMCameraManager.h"
#import "RNCTSTMCamera.h"
#import "React/RCTUIManager.h"
#import "React/RCTLog.h"

@implementation RNCSTMCameraManager

RCT_EXPORT_MODULE(RNCSTMCamera)

- (UIView *)view
{
  return [[RNCSTMCamera alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.origin.x,
    UIScreen.mainScreen.bounds.origin.y,
    UIScreen.mainScreen.bounds.size.width,
    UIScreen.mainScreen.bounds.size.height)];
}

RCT_EXPORT_METHOD(captureImage: (nonnull NSNumber *)viewTag)
{
  [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry) {
    RNCSTMCamera *view = viewRegistry[viewTag];
    
    if ([view isKindOfClass:[UIView class]]) {
      NSLog(@"Capture Command was called");
      [self capturePhoto:view];
    } else {
      RCTLogError(@"view type must be UIView");
    }
  }];
}

-(void) capturePhoto:(RNCSTMCamera*) view{
  AVCapturePhotoSettings *settings = [AVCapturePhotoSettings photoSettingsWithFormat:@{AVVideoCodecKey: AVVideoCodecTypeJPEG}];
  [view.photoOutput capturePhotoWithSettings:settings delegate:self];
}


#pragma mark - AVCapturePhotoCaptureDelegate
- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(nullable NSError *)error
{
  NSData *imageData = [photo fileDataRepresentation];
  UIImage *image = [UIImage imageWithData:imageData];
  NSLog(@"image is: %@",image);
  UIImageWriteToSavedPhotosAlbum(image, NULL, NULL, NULL);
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Photo Saved!" message:@"The Photo has been successfully saved in your photo library." delegate:self cancelButtonTitle:NULL otherButtonTitles:@"👍", nil];
  [alert show];
}

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

@end
