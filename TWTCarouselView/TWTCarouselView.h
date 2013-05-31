//
//  TWTCarouselView.h
//  CarouselScrollView
//
//  Created by Duncan Lewis on 5/30/13.
//  Copyright (c) 2013 TwoToasters. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TWTCarouselView;

@protocol TWTCarouselViewDelegate <NSObject>

- (NSUInteger)numberOfContentViewsInCarouselView:(TWTCarouselView *)carouselView;
- (CGSize)sizeOfContentViewsInCarouselView:(TWTCarouselView *)carouselView; // currently only supports one size
- (UIView *)carouselView:(TWTCarouselView *)carouselView configureView:(UIView *)view atIndex:(NSUInteger)index;

@end

@interface TWTCarouselView : UIScrollView

@property (nonatomic, weak) id<TWTCarouselViewDelegate> carouselDelegate;
@property (nonatomic, assign) NSUInteger currentIndex;

- (void)reloadContentViews;

@end
