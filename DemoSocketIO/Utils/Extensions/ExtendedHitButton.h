//
//  ExtendedHitButton.h
//  DemoSocketIO
//
//  Created by Loc.dx-KeizuDev on 11/11/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExtendedHitButton: UIButton

+ (instancetype) extendedHitButton;

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event;

@end

@implementation ExtendedHitButton

+ (instancetype) extendedHitButton {
    return (ExtendedHitButton *) [ExtendedHitButton buttonWithType:UIButtonTypeCustom];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect relativeFrame = self.bounds;
    UIEdgeInsets hitTestEdgeInsets = UIEdgeInsetsMake(-44, -44, -44, -44);
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, hitTestEdgeInsets);
    return CGRectContainsPoint(hitFrame, point);
}

@end
