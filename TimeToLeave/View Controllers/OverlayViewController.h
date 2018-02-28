//
//  OverlayViewController.h
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/21/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModernView.h"

@interface OverlayViewController : UIViewController

@property (strong, nonatomic) IBOutlet ModernView *activityModal;
@property (strong, nonatomic) IBOutlet UIView *shadeView;

@end
