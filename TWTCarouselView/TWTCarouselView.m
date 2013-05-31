//
//  TWTCarouselView.m
//  CarouselScrollView
//
//  Created by Duncan Lewis on 5/30/13.
//  Copyright (c) 2013 TwoToasters. All rights reserved.
//

#import "TWTCarouselView.h"

static NSInteger const kNumPanels = 3;
static NSInteger const kCenterPanelIndex = 1;

@interface TWTCarouselView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *carouselContentViews;
@property (nonatomic, strong) NSMutableArray *carouselPanelViews;
@property (nonatomic, assign) CGFloat horizontalOffsetForCenterPanel;
@property (nonatomic, assign) CGFloat panelWidth;
@property (nonatomic, assign) BOOL shouldConstructViews;

@end

@implementation TWTCarouselView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.delegate = self;
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;

        _shouldConstructViews = YES;
        _panelWidth = frame.size.width;
        self.contentSize = (CGSize){ (CGFloat)kNumPanels * self.panelWidth, frame.size.height };
        _carouselPanelViews = [NSMutableArray array];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)reloadContentViews
{
    NSUInteger numberOfViews = [self.carouselDelegate numberOfContentViewsInCarouselView:self];
    CGSize viewSize = [self.carouselDelegate sizeOfContentViewsInCarouselView:self];

    // configure all the views
    NSMutableArray *views = [NSMutableArray array];
    for (int i = 0; i < numberOfViews; i++) {
        UIView *contentView = [[UIView alloc] initWithFrame:(CGRect){ CGPointZero, viewSize }];
        contentView = [self.carouselDelegate carouselView:self configureView:contentView atIndex:i];
        [views addObject:contentView];
    }
    self.carouselContentViews = views;

    // reset the index
    self.currentIndex = 0;

    [self updateCarouselPanels];
}

// update carousel panels such that self.currentIndex is the center panel
- (void)updateCarouselPanels
{
    [self.carouselPanelViews removeAllObjects];

    for (int i = 0; i < kNumPanels; i++) {
        UIView *carouselPanel = [[UIView alloc] initWithFrame:(CGRect){ { i * self.panelWidth, 0.0f }, self.bounds.size }];
        [self.carouselPanelViews addObject:carouselPanel];
        [self addSubview:carouselPanel];

        if (self.carouselContentViews.count > 0) {
            // calculate the "wrapped" content index
            NSInteger offsetIndex = ((NSInteger)self.currentIndex + (i - 1));
            NSInteger contentViewIndex = offsetIndex % (NSInteger)self.carouselContentViews.count;
            // if the modulous of the index is negative, add the count to the result
            if (contentViewIndex < 0) {
                contentViewIndex += self.carouselContentViews.count;
            }
            UIView *contentView = self.carouselContentViews[contentViewIndex];
            contentView.center = (CGPoint){ floorf(CGRectGetMidX(carouselPanel.bounds)), floorf(CGRectGetMidY(carouselPanel.bounds)) };
            [carouselPanel addSubview:contentView];
        }
    }

    self.horizontalOffsetForCenterPanel = CGRectGetMinX([(UIView *)self.carouselPanelViews[kCenterPanelIndex] frame]);

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

    // if the modulous of the index is negative, add the count to the result
    if (newIndex < 0) {
        newIndex += self.carouselContentViews.count;
    }
    self.currentIndex = newIndex;

    [self updateCarouselPanels];
}

#pragma mark - Setters

- (void)setCarouselDelegate:(id<TWTCarouselViewDelegate>)carouselDelegate
{
    _carouselDelegate = carouselDelegate;

    [self reloadContentViews];
}

@end
