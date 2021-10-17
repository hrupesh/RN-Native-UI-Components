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
  self = [super initWithFrame:frame];
  if (self) {
    NSLog(@"RNCSTMCamera was initialized in Init with Frame");
    [self initializeCamera];
  }
  return self;
}


- (void) initializeCamera {

  AVCaptureSession *session = [[AVCaptureSession alloc] init];
  session.sessionPreset = AVCaptureSessionPreset3840x2160;

  CALayer *viewLayer = self.layer;
  NSLog(@"viewLayer = %@", viewLayer);

  AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];

  captureVideoPreviewLayer.frame = CGRectMake(UIScreen.mainScreen.bounds.origin.x,
                                              UIScreen.mainScreen.bounds.origin.y,
                                              UIScreen.mainScreen.bounds.size.width,
                                              UIScreen.mainScreen.bounds.size.height);
  [captureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
  [self.layer addSublayer:captureVideoPreviewLayer];
//  AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
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
  if (!input) {
    // Handle the error appropriately.
    NSLog(@"ERROR: trying to open camera: %@", error);
  }
  [session addInput:input];
  [session startRunning];
  [self setClipsToBounds:true];
  NSLog(@"startedRunnung and viewLayer = %@ and \n session: %@ \n self: %@ \n subviews: %@",
        viewLayer, session, self, self.subviews.description);
}

@end
