//
//  RNCSTMCamera.m
//  NativeComponentsDemo
//
//  Created by Rupesh Chaudhary on 17/10/21.
//
#import "RNCTSTMCamera.h"
#import "AVFoundation/AVFoundation.h"

@implementation RNCSTMCamera

- (instancetype)initWithFrame:(CGRect)frame
{
  _photoOutput = [[AVCapturePhotoOutput alloc] init];
  self = [super initWithFrame:frame];
  if (self) {
    NSLog(@"RNCSTMCamera was initialized in init with Frame");
    [self initializeCamera];
  }
  return self;
}

- (void) initializeCamera {
  AVCaptureSession *session = [[AVCaptureSession alloc] init];
  session.sessionPreset = AVCaptureSessionPresetHigh;
  CALayer *viewLayer = self.layer;
  NSLog(@"viewLayer = %@", viewLayer);
  AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
  captureVideoPreviewLayer.frame = CGRectMake(UIScreen.mainScreen.bounds.origin.x,UIScreen.mainScreen.bounds.origin.y,UIScreen.mainScreen.bounds.size.width,UIScreen.mainScreen.bounds.size.height);
  [captureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
  [self.layer addSublayer:captureVideoPreviewLayer];
  AVCaptureDevice *device = nil;
  NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
  for(AVCaptureDevice *camera in devices) {
      if([camera position] == AVCaptureDevicePositionFront) {
          device = camera;
          break;
      }
  }
  NSError *error = nil;
  AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
  if (!input) NSLog(@"ERROR: trying to open camera: %@", error);
  [session addInput:input];
  [session addOutput:_photoOutput];
  [session startRunning];
  [self setClipsToBounds:true];
}

@end
