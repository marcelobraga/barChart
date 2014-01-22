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
    
    self.drawerView.title = @"GRAFICO BARRAS";

    self.drawerView.barDetail.title = @"Um";
    self.drawerView.barDetail.color = [UIColor magentaColor];
    self.drawerView.barDetail.value = 500;
    self.drawerView.barDetail.subValue = 300;
    self.drawerView.barDetail.subColor = [UIColor purpleColor];
    [self.drawerView setBar];
    
    self.drawerView.barDetail.title = @"Dois";
    self.drawerView.barDetail.color = [UIColor magentaColor];
    self.drawerView.barDetail.value = 312;
    [self.drawerView setBar];
    
    
    
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
