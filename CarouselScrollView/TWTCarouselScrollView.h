//
//  TWTCarouselScrollView.h
//  CaroselScrollView
//
//  Created by Duncan Lewis on 5/30/13.
//  Copyright (c) 2013 TwoToasters. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TWTCarouselScrollView;

@protocol TWTCarouselScrollViewDelegate <NSObject>

- (NSUInteger)numberOfViewsInCarouselView:(TWTCarouselScrollView *)carouselView;
- (CGSize)sizeForViewInCarouselView:(TWTCarouselScrollView *)carouselView; // currently only supports one size
- (UIView *)carouselView:(TWTCarouselScrollView *)carouselView configureView:(UIView *)view atIndex:(NSUInteger)index;

@end

@interface TWTCarouselScrollView : UIScrollView

@property (nonatomic, weak) id<TWTCarouselScrollViewDelegate> carouselDelegate;
@property (nonatomic, assign) NSUInteger currentIndex;

- (void)constructViews;
- (void)setNeedsConstructViews;

@end
