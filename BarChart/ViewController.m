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
    
    
    self.drawerView.title = @"FINANCIAMENTOS";

    self.drawerView.barDetail.title = @"Aprovados";
    self.drawerView.barDetail.color = [UIColor magentaColor];
    self.drawerView.barDetail.value = 500;
    self.drawerView.barDetail.subValue = 700;
    self.drawerView.barDetail.subColor = [UIColor purpleColor];
    [self.drawerView setBar];
    

    self.drawerView.barDetail.title = @"Reprovados";
    self.drawerView.barDetail.color = [UIColor magentaColor];
    self.drawerView.barDetail.value = 312;
    self.drawerView.barDetail.subValue = 212;
    self.drawerView.barDetail.subColor = [UIColor purpleColor];
    [self.drawerView setBar];
    
    [self.drawerView drawChart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
