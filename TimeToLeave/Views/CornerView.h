//
//  CornerView.h
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/16/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface CornerView : UIView

@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property IBInspectable BOOL topLeft;
@property IBInspectable BOOL topRight;
@property IBInspectable BOOL bottomLeft;
@property IBInspectable BOOL bottomRight;

@end
