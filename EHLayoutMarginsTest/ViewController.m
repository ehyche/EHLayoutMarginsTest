//
//  ViewController.m
//  EHLayoutMarginsTest
//
//  Created by Eric Hyche on 7/30/15.
//  Copyright (c) 2015 Eric Hyche. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) UIView *containerView;
@property(nonatomic, strong) UISlider *slider;
@property(nonatomic, strong) UILabel *sliderValueLabel;
@property(nonatomic, strong) UIView *spacerViewTop;
@property(nonatomic, strong) UILabel *label1;
@property(nonatomic, strong) UILabel *label2;
@property(nonatomic, strong) UIView *spacerViewBottom;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.containerView = [[UIView alloc] init];
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.containerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.containerView];

    self.spacerViewTop = [[UIView alloc] init];
    self.spacerViewTop.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.spacerViewTop];

    self.label1 = [[UILabel alloc] init];
    self.label1.numberOfLines = 0;
    self.label1.backgroundColor = [UIColor blueColor];
    self.label1.textColor = [UIColor blackColor];
    self.label1.text = @"H:|-[label1]-|  H:|-[label1]-|  H:|-[label1]-|  H:|-[label1]-|  H:|-[label1]-|  H:|-[label1]-|  H:|-[label1]-|  H:|-[label1]-|  H:|-[label1]-|  H:|-[label1]-|  H:|-[label1]-|";
    self.label1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.label1];

    self.label2 = [[UILabel alloc] init];
    self.label2.numberOfLines = 0;
    self.label2.backgroundColor = [UIColor redColor];
    self.label2.textColor = [UIColor blackColor];
    self.label2.text = @"H:|-(8)-[label2]-(8)-|  H:|-(8)-[label2]-(8)-|  H:|-(8)-[label2]-(8)-|  H:|-(8)-[label2]-(8)-|  H:|-(8)-[label2]-(8)-|  H:|-(8)-[label2]-(8)-|  H:|-(8)-[label2]-(8)-|  H:|-(8)-[label2]-(8)-|";
    self.label2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.label2];

    self.spacerViewBottom = [[UIView alloc] init];
    self.spacerViewBottom.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.spacerViewBottom];

    self.slider = [[UISlider alloc] init];
    self.slider.continuous = YES;
    self.slider.minimumValue = 0.0;
    self.slider.maximumValue = 100.0;
    self.slider.value = self.containerView.layoutMargins.left;
    [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.slider.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.slider];

    self.sliderValueLabel = [[UILabel alloc] init];
    self.sliderValueLabel.backgroundColor = self.containerView.backgroundColor;
    self.sliderValueLabel.textColor = [UIColor blackColor];
    self.sliderValueLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.sliderValueLabel.textAlignment = NSTextAlignmentCenter;
    self.sliderValueLabel.text = [NSString stringWithFormat:@"layoutMargins=%@", NSStringFromUIEdgeInsets(self.containerView.layoutMargins)];
    [self.containerView addSubview:self.sliderValueLabel];

    NSDictionary *views = @{@"container": self.containerView,
                            @"spacerTop": self.spacerViewTop,
                            @"label1": self.label1,
                            @"label2": self.label2,
                            @"spacerBottom": self.spacerViewBottom,
                            @"slider": self.slider,
                            @"sliderLabel": self.sliderValueLabel};
    NSDictionary *metrics = @{@"verticalMargin": @(5.0),
                              @"sliderMarginTop": @(60.0),
                              @"sliderLabelMarginTop": @(8.0)};

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[container]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[container]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];


    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[spacerTop][label1]-(verticalMargin)-[label2][spacerBottom(==spacerTop)]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[spacerTop]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[spacerBottom]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[label1]-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(8)-[label2]-(8)-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];

    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(sliderMarginTop)-[slider]-(sliderLabelMarginTop)-[sliderLabel]"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(40)-[slider]-(40)-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(40)-[sliderLabel]-(40)-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
}

- (void)sliderValueChanged:(id)sender {
    CGFloat sliderValueFloor = floorf(self.slider.value);
    UIEdgeInsets currentLayoutMargins = self.containerView.layoutMargins;
    UIEdgeInsets margins = UIEdgeInsetsMake(currentLayoutMargins.top, sliderValueFloor, currentLayoutMargins.bottom, sliderValueFloor);
    NSLog(@"XXXMEH - setting self.containerView.layoutMargins = %@", NSStringFromUIEdgeInsets(margins));
    self.containerView.layoutMargins = margins;
    self.sliderValueLabel.text = [NSString stringWithFormat:@"layoutMargins=%@", NSStringFromUIEdgeInsets(self.containerView.layoutMargins)];
}

@end
