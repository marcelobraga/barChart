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

    self.drawerView.barDetail.title = @"2012";
    self.drawerView.barDetail.color = [UIColor orangeColor];
    self.drawerView.barDetail.value = 700;
    [self.drawerView setBar];
    

    self.drawerView.barDetail.title = @"2016";
    self.drawerView.barDetail.color = [UIColor purpleColor];
    self.drawerView.barDetail.value = 312;
    [self.drawerView setBar];
    
    
    [self.drawerView drawChart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
