//
//  ViewController.h
//  BarChart
//
//  Created by Marcelo Braga on 17/01/14.
//  Copyright (c) 2014 Marcelo Braga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawerBarChart.h"

@interface ViewController : UIViewController <DrawerBarChartDelegate> {
    
}

@property (nonatomic, strong) IBOutlet DrawerBarChart * drawerView;

@end
