//
//  TWTCarouselScrollView.m
//  CaroselScrollView
//
//  Created by Duncan Lewis on 5/30/13.
//  Copyright (c) 2013 TwoToasters. All rights reserved.
//

#import "TWTCarouselScrollView.h"

static NSInteger const numPanels = 3;

@interface TWTCarouselScrollView () <UIScrollViewDelegate>

@property (nonatomic, assign) BOOL shouldConstructViews;
@property (nonatomic, strong) NSArray *contentViews;
@property (nonatomic, strong) NSMutableArray *carouselPanels;
@property (nonatomic, assign) CGFloat horizontalOffsetForCenterPanel;
@property (nonatomic, assign) CGFloat panelWidth;

@end

@implementation TWTCarouselScrollView

/**
 * todo: formalize # of carousel panels
 * todo: add constants for width positions
 */

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.delegate = self;
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;

        self.shouldConstructViews = YES;
        self.panelWidth = frame.size.width;
        self.contentSize = (CGSize){ (CGFloat)numPanels * self.panelWidth, frame.size.height };
        _carouselPanels = [NSMutableArray array];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.shouldConstructViews) {
        [self constructViews];
        self.shouldConstructViews = NO;
    }
}

- (void)constructViews
{
    NSUInteger numberOfViews = [self.carouselDelegate numberOfViewsInCarouselView:self];
    CGSize viewSize = [self.carouselDelegate sizeForViewInCarouselView:self];

    // configure all the views
    NSMutableArray *views = [NSMutableArray array];
    for (int i = 0; i < numberOfViews; i++) {
        UIView *contentView = [[UIView alloc] initWithFrame:(CGRect){ CGPointZero, viewSize }];

        // configure view
        contentView = [self.carouselDelegate carouselView:self configureView:contentView atIndex:i];
        
        [views addObject:contentView];
    }
    self.contentViews = views;

    // reset the index
    self.currentIndex = 0;

    [self updateViewsInCarouselPanels];
}

- (void)updateViewsInCarouselPanels
{
    // update carousel panels such that self.currentIndex is the center panel
    // self.carouselPanels[0] = left panel, [1] = center panel, [2] = right panel

    [self.carouselPanels removeAllObjects];
    [self.carouselPanels addObject:[[UIView alloc] initWithFrame:(CGRect){ { 0.0f, 0.0f }, self.frame.size }]];
    [self.carouselPanels addObject:[[UIView alloc] initWithFrame:(CGRect){ { self.panelWidth, 0.0f }, self.frame.size }]];
    [self.carouselPanels addObject:[[UIView alloc] initWithFrame:(CGRect){ { 2*self.panelWidth, 0.0f }, self.frame.size }]];
    for (UIView *view in _carouselPanels) {
        [self addSubview:view];
    }

    self.horizontalOffsetForCenterPanel = CGRectGetMinX([(UIView *)self.carouselPanels[1] frame]);

    for (int i = 0; i < 3; i++) {
        UIView *carouselPanel = self.carouselPanels[i];

        // calculate the "wrapped" content index
        NSInteger offsetIndex = ((NSInteger)self.currentIndex + (i - 1));
        NSInteger contentIndex = offsetIndex % (NSInteger)self.contentViews.count;
        contentIndex = contentIndex >= 0 ? contentIndex : contentIndex + self.contentViews.count; // if the modulous of the index is negative, add the count to the result
        UIView *contentView = self.contentViews[contentIndex];
        contentView.center = (CGPoint){ CGRectGetMidX(carouselPanel.bounds), CGRectGetMidY(carouselPanel.bounds) };
        [carouselPanel addSubview:contentView];
    }

    // set offset to center
    [self setContentOffset:(CGPoint){ self.horizontalOffsetForCenterPanel, 0.0f } animated:NO];
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger newIndex = self.currentIndex; // default in no change
    if (self.contentOffset.x > self.horizontalOffsetForCenterPanel) {
        newIndex = self.currentIndex + 1;
    } else if (self.contentOffset.x < self.horizontalOffsetForCenterPanel) {
        newIndex = self.currentIndex - 1;
    }

    newIndex = newIndex >= 0 ? newIndex : newIndex + self.contentViews.count;
    self.currentIndex = newIndex;

    [self updateViewsInCarouselPanels];
}

#pragma mark - Setters

- (void)setNeedsConstructViews
{
    self.shouldConstructViews = YES;
    [self setNeedsLayout];
}

- (void)setCarouselDelegate:(id<TWTCarouselScrollViewDelegate>)carouselDelegate
{
    _carouselDelegate = carouselDelegate;

    [self setNeedsConstructViews];
}

@end
