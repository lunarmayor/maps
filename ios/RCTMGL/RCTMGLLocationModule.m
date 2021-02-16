#import "React/RCTBridgeModule.h"

@class RCTMGLLocation;

typedef void (^RCTMGLLocationBlock)(RCTMGLLocation *location);

@interface RCT_EXTERN_MODULE(RCTMGLLocationModule, NSObject)

// RCT_EXTERN_METHOD(addListener: (RCTMGLLocationBlock)listener)

- (void)addListener:(RCTMGLLocationBlock)listener
{
    NSLog(@"addListener");
}

RCT_EXTERN_METHOD(start:(CLLocationDistance)minDisplacement)
RCT_EXTERN_METHOD(getLastKnownLocation)

RCT_EXTERN_METHOD(setMinDisplacement:(CLLocationDistance)minDisplacement)


@end
