//
//  RCTMGLShapeSource.m
//  RCTMGL
//
//  Created by Nick Italiano on 9/19/17.
//  Copyright © 2017 Mapbox Inc. All rights reserved.
//

#import "RCTMGLShapeSource.h"
#import "RCTMGLUtils.h"
#import "RCTMGLMapView.h"

@implementation RCTMGLShapeSource

static UIImage * _placeHolderImage;

- (void)setUrl: (NSString*) url
{
    _url = url;
    if (self.source != nil) {
        MGLShapeSource *source = (MGLShapeSource *)self.source;
        [source setURL: url == nil ? nil : [NSURL URLWithString:url]];
    }
}

- (void)setShape:(NSString *)shape
{
    _shape = shape;

    if (self.source != nil) {
        MGLShapeSource *source = (MGLShapeSource *)self.source;
        [source setShape: shape == nil ? nil : [RCTMGLUtils shapeFromGeoJSON:_shape]];
    }
}

- (void)addToMap
{
    if (self.map.style == nil) {
        return;
    }
    [super addToMap];
}

- (void)removeFromMap
{
    if (self.map.style == nil) {
        return;
    }

    [super removeFromMap];
}

- (nullable MGLSource*)makeSource
{
    NSDictionary<MGLShapeSourceOption, id> *options = [self _getOptions];

    if (_shape != nil) {
        MGLShape *shape = [RCTMGLUtils shapeFromGeoJSON:_shape];
        return [[MGLShapeSource alloc] initWithIdentifier:self.id shape:shape options:options];
    }

    if (_url != nil) {
        NSURL *url = [[NSURL alloc] initWithString:_url];
        return [[MGLShapeSource alloc] initWithIdentifier:self.id URL:url options:options];
    }
    return nil;
}

- (NSDictionary<MGLShapeSourceOption, id>*)_getOptions
{
    NSMutableDictionary<MGLShapeSourceOption, id> *options = [[NSMutableDictionary alloc] init];

    if (_cluster != nil) {
        options[MGLShapeSourceOptionClustered] = [NSNumber numberWithBool:[_cluster intValue] == 1];
    }

    if (_clusterRadius != nil) {
        options[MGLShapeSourceOptionClusterRadius] = _clusterRadius;
    }

    if (_clusterMaxZoomLevel != nil) {
        options[MGLShapeSourceOptionMaximumZoomLevelForClustering] = _clusterMaxZoomLevel;
    }
    if (_clusterProperties != nil) {
        NSMutableDictionary *properties = [NSMutableDictionary new];

        for (NSString *propertyName in _clusterProperties.allKeys) {
            NSArray<NSExpression *> *expressions = [_clusterProperties objectForKey: propertyName];
            NSExpression *firstExpression = [NSExpression expressionWithMGLJSONObject:[expressions objectAtIndex: 0]];
            NSExpression *secondExpression = [NSExpression expressionWithMGLJSONObject:[expressions objectAtIndex: 1]];

            [properties setObject:@[firstExpression, secondExpression] forKey:propertyName];
        }

        options[MGLShapeSourceOptionClusterProperties] = properties;
    }


    if (_maxZoomLevel != nil) {
        options[MGLShapeSourceOptionMaximumZoomLevel] = _maxZoomLevel;
    }

    if (_buffer != nil) {
        options[MGLShapeSourceOptionBuffer] = _buffer;
    }

    if (_tolerance != nil) {
        options[MGLShapeSourceOptionSimplificationTolerance] = _tolerance;
    }

    return options;
}

- (nonnull NSArray<id <MGLFeature>> *)featuresMatchingPredicate:(nullable NSPredicate *)predicate
{
    MGLShapeSource *shapeSource = (MGLShapeSource *)self.source;

    return [shapeSource featuresMatchingPredicate:predicate];
}

@end
