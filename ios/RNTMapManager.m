//
//  RNTMapManager.m
//  NativeComponentsDemo
//
//  Created by Rupesh Chaudhari on 15/10/21.
//
#import <MapKit/MapKit.h>

#import <React/RCTViewManager.h>


@interface RNTMapManager : RCTViewManager
@end

@implementation RNTMapManager

RCT_EXPORT_MODULE(RNTMap)

- (UIView *)view
{
  return [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
}

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

@end
