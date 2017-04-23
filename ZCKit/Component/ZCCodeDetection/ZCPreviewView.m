//
//  ZCPreviewView.m
//  ZCKit
//
//  Created by Cusen on 2017/4/22.
//  Copyright © 2017年 Zcoder. All rights reserved.
//

#import "ZCPreviewView.h"

@interface ZCPreviewView ()
@property (strong, nonatomic) NSMutableDictionary *codeLayers;
@property (nonatomic, readonly) AVCaptureVideoPreviewLayer *previewLayer;
@end

@implementation ZCPreviewView

+ (Class)layerClass {
	return [AVCaptureVideoPreviewLayer class];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    _codeLayers = [NSMutableDictionary dictionary];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
}

- (AVCaptureSession*)session {
	return self.previewLayer.session;
}

- (void)setSession:(AVCaptureSession *)session {
    self.previewLayer.session = session;
}

- (AVCaptureVideoPreviewLayer *)previewLayer {
    return (AVCaptureVideoPreviewLayer *)self.layer;
}

#pragma mark - 

- (void)handelDetectCodes:(NSArray *)transformedCodes {

    //NSArray *transformedCodes = [self transformedCodesFromCodes:codes];

    NSMutableArray *lostCodes = [self.codeLayers.allKeys mutableCopy];

    for (AVMetadataMachineReadableCodeObject *code in transformedCodes) {

        NSString *stringValue = code.stringValue;
        if (stringValue) {
            [lostCodes removeObject:stringValue];
        } else {
            continue;
        }

        NSArray *layers = self.codeLayers[stringValue];

        if (!layers) {
            // no layers for stringValue, create new code layers
            layers = @[[self makeBoundsLayer], [self makeCornersLayer]];

            self.codeLayers[stringValue] = layers;
            [self.previewLayer addSublayer:layers[0]];
            [self.previewLayer addSublayer:layers[1]];
        }

        CAShapeLayer *boundsLayer  = layers[0];
        boundsLayer.path  = [self bezierPathForBounds:code.bounds].CGPath;
        boundsLayer.hidden = NO;

        CAShapeLayer *cornersLayer = layers[1];
        cornersLayer.path = [self bezierPathForCorners:code.corners].CGPath;
        cornersLayer.hidden = NO;

        NSLog(@"String: %@", stringValue);
    }

    for (NSString *stringValue in lostCodes) {
        for (CALayer *layer in self.codeLayers[stringValue]) {
            [layer removeFromSuperlayer];
        }
        [self.codeLayers removeObjectForKey:stringValue];
    }
}
    
- (NSArray *)transformedCodesFromCodes:(NSArray *)codes {
    NSMutableArray *transformedCodes = [NSMutableArray array];
    for (AVMetadataObject *code in codes) {
        AVMetadataObject *transformedCode =
        [self.previewLayer transformedMetadataObjectForMetadataObject:code];
        [transformedCodes addObject:transformedCode];
    }
    return transformedCodes;
}
    
#pragma mark - private

- (UIBezierPath *)bezierPathForBounds:(CGRect)bounds {
    return [UIBezierPath bezierPathWithRect:bounds];
}

- (UIBezierPath *)bezierPathForCorners:(NSArray *)corners {
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i < corners.count; i++) {
        CGPoint point = [self pointForCorner:corners[i]];
        if (i == 0) {
            [path moveToPoint:point];
        } else {
            [path addLineToPoint:point];
        }
    }
    [path closePath];
    return path;
}

- (CGPoint)pointForCorner:(NSDictionary *)corner {
    NSLog(@"%@", corner);
    CGPoint point;
    CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)corner, &point);
    return point;
}

- (CAShapeLayer *)makeBoundsLayer {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor =
        [UIColor colorWithRed:0.95f green:0.75f blue:0.06f alpha:1.0f].CGColor;
    shapeLayer.fillColor = nil;
    shapeLayer.lineWidth = 4.0f;
    return shapeLayer;
}

- (CAShapeLayer *)makeCornersLayer {
    CAShapeLayer *cornersLayer = [CAShapeLayer layer];
    cornersLayer.lineWidth = 2.0f;
    cornersLayer.strokeColor =
        [UIColor colorWithRed:0.172 green:0.671 blue:0.428 alpha:1.000].CGColor;
    cornersLayer.fillColor =
        [UIColor colorWithRed:0.190 green:0.753 blue:0.489 alpha:0.500].CGColor;
    
    return cornersLayer;
}

@end
