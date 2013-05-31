//
//  TWTViewController.m
//  CarouselScrollView
//
//  Created by Duncan Lewis on 5/30/13.
//  Copyright (c) 2013 TwoToasters. All rights reserved.
//

#import "TWTViewController.h"

#import "TWTCarouselView.h"

@interface TWTViewController () <TWTCarouselViewDelegate>

@end

@implementation TWTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    TWTCarouselView *carouselView = [[TWTCarouselView alloc] initWithFrame:(CGRect){ CGPointZero, { 320.0f, 200.0f } }];
    carouselView.carouselDelegate = self;
    carouselView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:carouselView];

}

#pragma mark - TWTCarouselScrollViewDelegate

- (NSUInteger)numberOfContentViewsInCarouselView:(TWTCarouselView *)carouselView
{
    return 2;
}

- (CGSize)sizeOfContentViewsInCarouselView:(TWTCarouselView *)carouselView
{
    return carouselView.bounds.size;
}

- (UIView *)carouselView:(TWTCarouselView *)carouselView configureView:(UIView *)view atIndex:(NSUInteger)index
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setFont:[UIFont systemFontOfSize:42.0f]];
    [label setTextColor:[UIColor whiteColor]];
    label.backgroundColor = [UIColor blackColor];

    switch (index) {
        case 0:
        {
            view.backgroundColor = [UIColor redColor];
            [label setText:@"1"];
        }
            break;
        case 1:
        {
            view.backgroundColor = [UIColor blueColor];
            [label setText:@"2"];
        }
            break;
        case 2:
        {
            view.backgroundColor = [UIColor greenColor];
            [label setText:@"3"];
        }
            break;
        default:
            break;
    }

    [label sizeToFit];
    label.center = (CGPoint){ CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds) };
    [view addSubview:label];

    return view;
}

@end
