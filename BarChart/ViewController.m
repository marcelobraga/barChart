//
//  ViewController.m
//  BarChart
//
//  Created by Marcelo Braga on 17/01/14.
//  Copyright (c) 2014 Marcelo Braga. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.drawerView initChart];
    self.drawerView.delegate = self;
    
    self.drawerView.masterColor = [UIColor brownColor]; //Use this to create a color template from entire chart. Another color will be ignored
    
    self.drawerView.title = @"BAR CHART TITLE";

    self.drawerView.barDetail.title = @"One";
    self.drawerView.barDetail.color = [UIColor blueColor];
    self.drawerView.barDetail.value = 500;
    self.drawerView.barDetail.subValue = 300;
    [self.drawerView setBar];
    
    self.drawerView.barDetail.title = @"Two";
    self.drawerView.barDetail.color = [UIColor blueColor];
    self.drawerView.barDetail.value = 312;
    self.drawerView.barDetail.subValue = 80;
    [self.drawerView setBar];
    
    self.drawerView.rotate90Degress = YES;
    
    
    [self.drawerView drawChart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) didSelectBar:(BarDetail *)barSelected {
    NSLog(@"Value: %f - SubValue: %f",barSelected.value, barSelected.subValue);
}


@end
