//
//  FavoriteView.m
//  Jitter
//
//  Created by Punya Chatterjee on 2/13/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import "ModernView.h"

@interface ModernView ()

@property (nonatomic) IBInspectable UIColor *startColor;
@property (nonatomic) IBInspectable UIColor *midColor;
@property (nonatomic) IBInspectable UIColor *endColor;

@property (nonatomic) IBInspectable UIColor *shadowColor;

@end

@implementation ModernView

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (id)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    if (self) {
        _cornerRadius = 0.0;
        _startColor     = [UIColor redColor];
        _midColor       = [UIColor greenColor];
        _endColor       = [UIColor blueColor];
        _shadowRadius = 0.0;
        _shadowX = 0.0;
        _shadowY = 0.0;
        _shadowOpacity = 0.0;
        _shadowColor = [UIColor blackColor];
        [self updateLayer];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [super initWithCoder:coder];
    if (self) {
        [self updateLayer];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self updateLayer];
}

- (void)setNeedsLayout {
    [super setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)prepareForInterfaceBuilder {
    [super prepareForInterfaceBuilder];
    [self updateLayer];
}

- (void)updateLayer {

    // Set shadow
    [self setBackgroundColor:[UIColor clearColor]];
    [self.layer setShadowOffset:CGSizeMake(self.shadowX, self.shadowY)];
    [self.layer setShadowOpacity:self.shadowOpacity];
    [self.layer setShadowRadius:self.shadowRadius];
    [self.layer setShadowColor:self.shadowColor.CGColor];
    [self.layer setShouldRasterize:YES];
    
    // Set rounded corners
    
    [self.layer setCornerRadius:self.cornerRadius];
    [self.layer setShadowPath:
     [[UIBezierPath bezierPathWithRoundedRect:[self bounds]
                                 cornerRadius:self.cornerRadius] CGPath]];
    
    // Generate gradient
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 1);
    gradient.colors = [NSArray arrayWithObjects:(id)[self.startColor CGColor], (id)[self.endColor CGColor], nil];
    gradient.cornerRadius = self.cornerRadius;
    [self.layer insertSublayer:gradient atIndex:0];
    
}

@end
