//
//  FavoriteView.h
//  Jitter
//
//  Created by Punya Chatterjee on 2/13/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface ModernView : UIView

@property (nonatomic) IBInspectable CGFloat cornerRadius;

@property (nonatomic) IBInspectable float shadowX;
@property (nonatomic) IBInspectable float shadowY;
@property (nonatomic) IBInspectable float shadowRadius;
@property (nonatomic) IBInspectable float shadowOpacity;

@end
