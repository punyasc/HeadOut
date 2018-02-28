//
//  CornerView.m
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/16/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import "CornerView.h"

@implementation CornerView

- (id)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    if (self) {
        _cornerRadius = 0.0;
        _topLeft = true;
        _topRight = true;
        _bottomLeft = true;
        _bottomRight = true;
        [self customInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [super initWithCoder:coder];
    if (self) {
        _cornerRadius = 0.0;
        _topLeft = YES;
        _topRight = YES;
        _bottomLeft = YES;
        _bottomRight = YES;
        [self customInit];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self customInit];
}


- (void)setNeedsLayout {
    [super setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)prepareForInterfaceBuilder {
    [super prepareForInterfaceBuilder];
    [self customInit];
}

- (void)customInit {
    UIRectCorner corners = UIRectCornerAllCorners;
    
    if (!self.topLeft) {
        corners -= UIRectCornerTopLeft;
    }
    if (!self.topRight) {
        corners -= UIRectCornerTopRight;
    }
    if (!self.bottomLeft) {
        corners -= UIRectCornerBottomLeft;
    }
    if (!self.bottomRight) {
        corners -= UIRectCornerBottomRight;
    }
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path  = maskPath.CGPath;
    self.layer.mask = maskLayer;
    self.backgroundColor = [UIColor whiteColor];
}

@end
