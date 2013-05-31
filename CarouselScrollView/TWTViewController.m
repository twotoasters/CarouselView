//
//  TWTViewController.m
//  CaroselScrollView
//
//  Created by Duncan Lewis on 5/30/13.
//  Copyright (c) 2013 TwoToasters. All rights reserved.
//

#import "TWTViewController.h"

#import "TWTCarouselScrollView.h"

@interface TWTViewController () <TWTCarouselScrollViewDelegate>

@end

@implementation TWTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    TWTCarouselScrollView *carouselView = [[TWTCarouselScrollView alloc] initWithFrame:(CGRect){ CGPointZero, { 320.0f, 200.0f } }];
    carouselView.carouselDelegate = self;
    carouselView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:carouselView];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TWTCarouselScrollViewDelegate

- (NSUInteger)numberOfViewsInCarouselView:(TWTCarouselScrollView *)carouselView
{
    return 3;
}

- (CGSize)sizeForViewInCarouselView:(TWTCarouselScrollView *)carouselView
{
    return carouselView.bounds.size;
}

- (UIView *)carouselView:(TWTCarouselScrollView *)carouselView configureView:(UIView *)view atIndex:(NSUInteger)index
{
    switch (index) {
        case 0:
        {
            view.backgroundColor = [UIColor redColor];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            [label setText:@"1"];
            [label setFont:[UIFont systemFontOfSize:42.0f]];
            [label sizeToFit];
            [label setTextColor:[UIColor whiteColor]];
            label.backgroundColor = [UIColor blackColor];
            label.center = (CGPoint){ CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds) };
            [view addSubview:label];
        }
            break;
        case 1:
        {
            view.backgroundColor = [UIColor blueColor];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            [label setText:@"2"];
            [label setFont:[UIFont systemFontOfSize:42.0f]];
            [label sizeToFit];
            [label setTextColor:[UIColor whiteColor]];
            label.backgroundColor = [UIColor blackColor];
            label.center = (CGPoint){ CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds) };
            [view addSubview:label];
        }
            break;
        case 2:
        {
            view.backgroundColor = [UIColor greenColor];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            [label setText:@"3"];
            [label setFont:[UIFont systemFontOfSize:42.0f]];
            [label sizeToFit];
            [label setTextColor:[UIColor whiteColor]];
            label.backgroundColor = [UIColor blackColor];
            label.center = (CGPoint){ CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds) };
            [view addSubview:label];
        }
            break;
        default:
            break;
    }
    return view;
}

@end
