//
//  RNCSTMCameraManager.m
//  NativeComponentsDemo
//
//  Created by Rupesh Chaudhari on 15/10/21.
//
#import "RNCSTMCameraManager.h"
#import "RNCTSTMCamera.h"

@implementation RNCSTMCameraManager

RCT_EXPORT_MODULE(RNCSTMCamera)

- (UIView *)view
{
  return [[RNCSTMCamera alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.origin.x,
    UIScreen.mainScreen.bounds.origin.y,
    UIScreen.mainScreen.bounds.size.width,
    UIScreen.mainScreen.bounds.size.height)];
}

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

@end
