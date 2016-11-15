//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "JSQMessagesToolbarContentView.h"

#import "UIView+JSQMessages.h"

const CGFloat kJSQMessagesToolbarContentViewHorizontalSpacingDefault = 8.0f;


@interface JSQMessagesToolbarContentView ()

@property (weak, nonatomic) IBOutlet JSQMessagesComposerTextView *textView;

@property (weak, nonatomic) IBOutlet UIView *leftBarButtonContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBarButtonContainerViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UIView *rightBarButtonContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBarButtonContainerViewWidthConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftHorizontalSpacingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightHorizontalSpacingConstraint;
@property (weak, nonatomic) IBOutlet UIView *likeMidBarButtonContainerView;
@property (weak, nonatomic) IBOutlet UIView *codeMidBarButtonContainerView;
@property (weak, nonatomic) IBOutlet UIView *cameraMidBarButtonContainerView;

@end



@implementation JSQMessagesToolbarContentView

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JSQMessagesToolbarContentView class])
                          bundle:[NSBundle bundleForClass:[JSQMessagesToolbarContentView class]]];
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self setTranslatesAutoresizingMaskIntoConstraints:NO];

    self.leftHorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.rightHorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;

    self.backgroundColor = [UIColor yellowColor];
}

#pragma mark - Setters

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.leftBarButtonContainerView.backgroundColor = backgroundColor;
    self.rightBarButtonContainerView.backgroundColor = backgroundColor;
    self.likeMidBarButtonContainerView.backgroundColor = backgroundColor;
    self.cameraMidBarButtonContainerView.backgroundColor = backgroundColor;
    self.codeMidBarButtonContainerView.backgroundColor = backgroundColor;
}

- (void)setLeftBarButtonItem:(UIButton *)leftBarButtonItem
{
    if (_leftBarButtonItem) {
        [_leftBarButtonItem removeFromSuperview];
    }

    if (!leftBarButtonItem) {
        _leftBarButtonItem = nil;
        self.leftHorizontalSpacingConstraint.constant = 0.0f;
        self.leftBarButtonItemWidth = 0.0f;
        self.leftBarButtonContainerView.hidden = YES;
        return;
    }

    if (CGRectEqualToRect(leftBarButtonItem.frame, CGRectZero)) {
        leftBarButtonItem.frame = self.leftBarButtonContainerView.bounds;
    }

    self.leftBarButtonContainerView.hidden = NO;
    self.leftHorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.leftBarButtonItemWidth = CGRectGetWidth(leftBarButtonItem.frame);
    self.midBarButtonItemWidth = self.leftBarButtonItemWidth;

    [leftBarButtonItem setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.leftBarButtonContainerView addSubview:leftBarButtonItem];
    [self.leftBarButtonContainerView jsq_pinAllEdgesOfSubview:leftBarButtonItem];
    [self setNeedsUpdateConstraints];

    _leftBarButtonItem = leftBarButtonItem;
}
////DXL-likeMidbar
- (void)setLikeMidBarButtonItem:(UIButton *)likeMidBarButtonItem
{
    
    if (_likeMidBarButtonItem) {
        [_likeMidBarButtonItem removeFromSuperview];
    }
    
    if (!likeMidBarButtonItem) {
        _likeMidBarButtonItem = nil;
        return;
    }
    
    if (CGRectEqualToRect(likeMidBarButtonItem.frame, CGRectZero)) {
        likeMidBarButtonItem.frame = self.likeMidBarButtonContainerView.bounds;
    }
    
    [likeMidBarButtonItem setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.likeMidBarButtonContainerView addSubview:likeMidBarButtonItem];
    [self.likeMidBarButtonContainerView jsq_pinAllEdgesOfSubview:likeMidBarButtonItem];
    [self setNeedsUpdateConstraints];
    
    _likeMidBarButtonItem = likeMidBarButtonItem;
}

////DXL-likeMidbar

////DXL-cameraMidbar
- (void)setCameraMidBarButtonItem:(UIButton *)cameraMidBarButtonItem
{
    
    if (_cameraMidBarButtonItem) {
        [_cameraMidBarButtonItem removeFromSuperview];
    }
    
    if (!cameraMidBarButtonItem) {
        _cameraMidBarButtonItem = nil;
        return;
    }
    
    if (CGRectEqualToRect(cameraMidBarButtonItem.frame, CGRectZero)) {
        cameraMidBarButtonItem.frame = self.cameraMidBarButtonContainerView.bounds;
    }
    
    [cameraMidBarButtonItem setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.cameraMidBarButtonContainerView addSubview:cameraMidBarButtonItem];
    [self.cameraMidBarButtonContainerView jsq_pinAllEdgesOfSubview:cameraMidBarButtonItem];
    [self setNeedsUpdateConstraints];
    
    _cameraMidBarButtonItem = cameraMidBarButtonItem;
}

////DXL-cameraMidbar


////DXL-codeMidbar
- (void)setCodeMidBarButtonItem:(UIButton *)codeMidBarButtonItem
{
    
    if (_codeMidBarButtonItem) {
        [_codeMidBarButtonItem removeFromSuperview];
    }
    
    if (!codeMidBarButtonItem) {
        _codeMidBarButtonItem = nil;
        return;
    }
    
    if (CGRectEqualToRect(codeMidBarButtonItem.frame, CGRectZero)) {
        codeMidBarButtonItem.frame = self.codeMidBarButtonContainerView.bounds;
    }
    
    [codeMidBarButtonItem setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.codeMidBarButtonContainerView addSubview:codeMidBarButtonItem];
    [self.codeMidBarButtonContainerView jsq_pinAllEdgesOfSubview:codeMidBarButtonItem];
    [self setNeedsUpdateConstraints];
    
    _codeMidBarButtonItem = codeMidBarButtonItem;
}

////DXL-codeaMidbar

- (void)setLeftBarButtonItemWidth:(CGFloat)leftBarButtonItemWidth
{
    self.leftBarButtonContainerViewWidthConstraint.constant = leftBarButtonItemWidth;
    [self setNeedsUpdateConstraints];
}

- (void)setRightBarButtonItem:(UIButton *)rightBarButtonItem
{
    if (_rightBarButtonItem) {
        [_rightBarButtonItem removeFromSuperview];
    }

    if (!rightBarButtonItem) {
        _rightBarButtonItem = nil;
        self.rightHorizontalSpacingConstraint.constant = 0.0f;
        self.rightBarButtonItemWidth = 0.0f;
        self.rightBarButtonContainerView.hidden = YES;
        return;
    }

    if (CGRectEqualToRect(rightBarButtonItem.frame, CGRectZero)) {
        rightBarButtonItem.frame = self.rightBarButtonContainerView.bounds;
    }

    self.rightBarButtonContainerView.hidden = NO;
    self.rightHorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.rightBarButtonItemWidth = CGRectGetWidth(rightBarButtonItem.frame);

    [rightBarButtonItem setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.rightBarButtonContainerView addSubview:rightBarButtonItem];
    [self.rightBarButtonContainerView jsq_pinAllEdgesOfSubview:rightBarButtonItem];
    [self setNeedsUpdateConstraints];

    _rightBarButtonItem = rightBarButtonItem;
}

- (void)setRightBarButtonItemWidth:(CGFloat)rightBarButtonItemWidth
{
    self.rightBarButtonContainerViewWidthConstraint.constant = rightBarButtonItemWidth;
    [self setNeedsUpdateConstraints];
}

- (void)setRightContentPadding:(CGFloat)rightContentPadding
{
    self.rightHorizontalSpacingConstraint.constant = rightContentPadding;
    [self setNeedsUpdateConstraints];
}

- (void)setLeftContentPadding:(CGFloat)leftContentPadding
{
    self.leftHorizontalSpacingConstraint.constant = leftContentPadding;
    [self setNeedsUpdateConstraints];
}

#pragma mark - Getters

- (CGFloat)leftBarButtonItemWidth
{
    return self.leftBarButtonContainerViewWidthConstraint.constant;
}

- (CGFloat)rightBarButtonItemWidth
{
    return self.rightBarButtonContainerViewWidthConstraint.constant;
}

- (CGFloat)rightContentPadding
{
    return self.rightHorizontalSpacingConstraint.constant;
}

- (CGFloat)leftContentPadding
{
    return self.leftHorizontalSpacingConstraint.constant;
}

#pragma mark - UIView overrides

- (void)setNeedsDisplay
{
    [super setNeedsDisplay];
    [self.textView setNeedsDisplay];
}

@end
