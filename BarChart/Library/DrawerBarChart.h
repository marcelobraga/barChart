//
//  DrawerBarChart.h
//  BarChart
//
//  Created by Marcelo Braga on 17/01/14.
//  Copyright (c) 2014 Marcelo Braga. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BarDetail;
@class DrawerBarChart;

@protocol DrawerBarChartDelegate <NSObject>

@required

-(void)didSelectBar : (BarDetail *) barSelected;

@end

@interface DrawerBarChart : UIView {
    NSMutableArray * arrayBar;
}

@property (nonatomic, assign) UIColor * lineColor;
@property (nonatomic, assign) int maxValue;
@property (nonatomic, assign) int minValue;
@property (nonatomic, assign) int fontSize;
@property (nonatomic, strong) BarDetail * barDetail;
@property (nonatomic, assign) BOOL showShadow;
@property (nonatomic, assign) BOOL showBorder;
@property (nonatomic, assign) BOOL showGradient;
@property (nonatomic, assign) BOOL rotate45Degress;
@property (nonatomic, assign) BOOL rotate90Degress;
@property (nonatomic, assign) BOOL abortRotate;
@property (nonatomic, assign) NSString * title;
@property (nonatomic, assign) UIColor * masterColor;
@property(assign,nonatomic) id<DrawerBarChartDelegate>delegate;

-(void) drawChart;
-(void) initChart;
-(void)resetChart;
-(void) setBar;

@end
