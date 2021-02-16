#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>

@class RCTMGLMapView;

@interface RCT_EXTERN_MODULE(RCTMGLMapViewManager, RCTViewManager)

RCT_EXTERN_METHOD(addEvent:(NSString *)name location:(NSString *)location date:(nonnull NSNumber *)date)

@end
