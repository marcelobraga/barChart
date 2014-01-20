//
//  DrawerBarChart.m
//  BarChart
//
//  Created by Marcelo Braga on 17/01/14.
//  Copyright (c) 2014 Marcelo Braga. All rights reserved.
//

#import "DrawerBarChart.h"

#define MARGIN_VERTICAL     30
#define MARGIN_HORIZONTAL   30

@implementation DrawerBarChart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(id) init {
    self = [super init];
    self.barDetail = [BarDetail new];
    return self;
}


-(void) drawChart {

    if (!self.dimensionColor) {
        self.dimensionColor = [UIColor blackColor];
    }
    
    
    [self getMaxValue];
    [self getMinValue];
    

    UIView * limitVerticalView = [UIView new];
    UIView * limiteHorizontalView = [UIView new];
    CGRect frameVertical = limitVerticalView.frame;
    CGRect frameHorizontal = limiteHorizontalView.frame;
    
    frameVertical.size.width = 1;
    frameVertical.origin.x = MARGIN_HORIZONTAL;
    frameVertical.origin.y = MARGIN_VERTICAL;
    frameVertical.size.height = self.frame.size.height - MARGIN_VERTICAL * 2;
    limitVerticalView.backgroundColor = self.dimensionColor;
    limitVerticalView.frame = frameVertical;
    
    frameHorizontal.size.width = self.frame.size.width - MARGIN_HORIZONTAL * 2;
    frameHorizontal.size.height = 1;
    frameHorizontal.origin.x = MARGIN_HORIZONTAL;
    frameHorizontal.origin.y = frameVertical.origin.y + frameVertical.size.height;
    limiteHorizontalView.backgroundColor = self.dimensionColor;
    limiteHorizontalView.frame = frameHorizontal;
    
    
    UIView * lineViewTop = [UIView new];
    UIView * lineViewTop2 = [UIView new];
    UIView * lineViewMiddle = [UIView new];
    UIView * lineViewBottom = [UIView new];
    
    CGRect frameLineTop = lineViewTop.frame;
    frameLineTop.size.width = frameHorizontal.size.width;
    frameLineTop.origin.y = frameVertical.origin.y;
    frameLineTop.origin.x = frameVertical.origin.x;
    frameLineTop.size.height = 1;
    lineViewTop.backgroundColor = [UIColor blackColor];
    lineViewTop.alpha = .1;
    lineViewTop.frame = frameLineTop;
    
    
    
    CGRect frameLineTop2 = lineViewTop2.frame;
    frameLineTop2.size.width = frameHorizontal.size.width;
    frameLineTop2.origin.y = frameVertical.origin.y + (frameVertical.size.height / 4);
    frameLineTop2.origin.x = frameVertical.origin.x;
    frameLineTop2.size.height = 1;
    lineViewTop2.backgroundColor = [UIColor blackColor];
    lineViewTop2.alpha = .1;
    lineViewTop2.frame = frameLineTop2;
    
    CGRect frameLineMiddle = lineViewMiddle.frame;
    frameLineMiddle.size.width = frameHorizontal.size.width;
    frameLineMiddle.origin.y = limitVerticalView.center.y;
    frameLineMiddle.origin.x = frameLineTop.origin.x;
    frameLineMiddle.size.height = 1;
    lineViewMiddle.backgroundColor = [UIColor blackColor];
    lineViewMiddle.alpha = .1;
    lineViewMiddle.frame = frameLineMiddle;

    CGRect frameLineBottom = lineViewBottom.frame;
    frameLineBottom.size.width = frameHorizontal.size.width;
    frameLineBottom.origin.y = frameLineMiddle.origin.y +  (frameVertical.size.height / 4);
    frameLineBottom.origin.x = frameLineTop.origin.x;
    frameLineBottom.size.height = 1;
    lineViewBottom.backgroundColor = [UIColor blackColor];
    lineViewBottom.alpha = .1;
    lineViewBottom.frame = frameLineBottom;
    
    
    
    [self addSubview:lineViewTop];
    [self addSubview:lineViewTop2];
    [self addSubview:lineViewMiddle];
    [self addSubview:lineViewBottom];
    [self addSubview:limitVerticalView];
    [self addSubview:limiteHorizontalView];
    

    if (self.fontSize == 0) {
        self.fontSize = 8;
    }
    UILabel * labelMax = [UILabel new];
    [labelMax setFont:[UIFont systemFontOfSize:self.fontSize]];
    labelMax.textColor = self.dimensionColor;
    CGRect frameLabelMax = labelMax.frame;
    frameLabelMax.origin.x = 2;
    frameLabelMax.origin.y = frameLineTop.origin.y - 15;
    frameLabelMax.size.width = 40;
    frameLabelMax.size.height = 30;
    labelMax.frame = frameLabelMax;
    labelMax.text = [NSString stringWithFormat:@"%i", self.maxValue];
    [self addSubview:labelMax];

    UILabel * labelMax2 = [UILabel new];
    [labelMax2 setFont:[UIFont systemFontOfSize:self.fontSize]];
    labelMax2.textColor = self.dimensionColor;
    CGRect frameLabelMax2 = labelMax2.frame;
    frameLabelMax2.origin.x = 2;
    frameLabelMax2.origin.y = frameLineTop2.origin.y - 15;
    frameLabelMax2.size.width = 40;
    frameLabelMax2.size.height = 30;
    labelMax2.frame = frameLabelMax2;
    labelMax2.text = [NSString stringWithFormat:@"%i", self.maxValue - (self.maxValue / 4)];
    [self addSubview:labelMax2];
    
    UILabel * labelAverage = [UILabel new];
    [labelAverage setFont:[UIFont systemFontOfSize:self.fontSize]];
    labelAverage.textColor = self.dimensionColor;
    CGRect frameLabelAverage = labelAverage.frame;
    frameLabelAverage.origin.x = 2;
    frameLabelAverage.origin.y = frameLineMiddle.origin.y - 15;
    frameLabelAverage.size.width = 40;
    frameLabelAverage.size.height = 30;
    labelAverage.frame = frameLabelAverage;
    labelAverage.text = [NSString stringWithFormat:@"%i", self.maxValue / 2];
    [self addSubview:labelAverage];

    UILabel * labelBottom = [UILabel new];
    [labelBottom setFont:[UIFont systemFontOfSize:self.fontSize]];
    labelBottom.textColor = self.dimensionColor;
    CGRect frameLabelBottom = labelBottom.frame;
    frameLabelBottom.origin.x = 2;
    frameLabelBottom.origin.y = frameLineBottom.origin.y - 15;
    frameLabelBottom.size.width = 40;
    frameLabelBottom.size.height = 30;
    labelBottom.frame = frameLabelBottom;
    labelBottom.text = [NSString stringWithFormat:@"%i", self.maxValue / 4];
    [self addSubview:labelBottom];
    
    
    double heightDefinition = limitVerticalView.frame.size.height / self.maxValue;
    int originX = frameLineTop.origin.x + 10;
    int widthBar = limiteHorizontalView.frame.size.width / arrayBar.count;
    
    
    for (BarDetail * barDetail in arrayBar) {

        double heightBar = barDetail.value * heightDefinition;
        double heightSubBar = 0;
        if (barDetail.subValue != 0) {
            heightSubBar = barDetail.subValue * heightDefinition;
        }
        
        UIView * bar = [UIView new];
        CGRect frameBar = bar.frame;
        frameBar.origin.x = originX;
        frameBar.origin.y = frameHorizontal.origin.y - heightBar;
        frameBar.size.width = widthBar - 10;
        frameBar.size.height = heightBar + 1;
        bar.frame = frameBar;
        bar.backgroundColor = barDetail.color;
        [self addSubview:bar];
        bar.layer.borderWidth = 1;
        if (self.showBorder) {
            bar.layer.borderColor = self.dimensionColor.CGColor;
        } else {
            bar.layer.borderColor = self.backgroundColor.CGColor;
        }
        
        if (barDetail.subValue != 0) {
            UIView * subBar = [UIView new];
            CGRect frameSubBar = subBar.frame;
            frameSubBar.origin.x = originX + 5;
            frameSubBar.origin.y = frameHorizontal.origin.y - heightSubBar ;
            frameSubBar.size.width = widthBar - 10;
            frameSubBar.size.height = heightSubBar + 1;
            subBar.frame = frameSubBar;
            subBar.backgroundColor = barDetail.subColor;
            [self addSubview:subBar];
            subBar.layer.borderWidth = 1;
            subBar.layer.borderColor = self.backgroundColor.CGColor;
            
            frameHorizontal.size.width += 5;
            limiteHorizontalView.frame = frameHorizontal;
            
        }
        
        
        UILabel * labelTitle = [UILabel new];
        labelTitle.text = barDetail.title;
        [labelTitle setFont:[UIFont boldSystemFontOfSize:self.fontSize]];
        if (self.rotate45Degress) {
            [labelTitle setTransform:CGAffineTransformMakeRotation(-M_PI_4)];
            [labelTitle setTextAlignment:NSTextAlignmentRight];
        } else if (self.rotate90Degress) {
            [labelTitle setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
            [labelTitle setTextAlignment:NSTextAlignmentRight];
        } else {
            [labelTitle setTextAlignment:NSTextAlignmentCenter];
        }
        CGRect frameTitle = labelTitle.frame;
        frameTitle.origin.x = originX;
        frameTitle.origin.y = frameBar.origin.y + frameBar.size.height   ;
        if (!self.rotate45Degress) {
            frameTitle.origin.y += 5;
        }
        frameTitle.size.width = widthBar ;
        if (self.abortRotate) {
            frameTitle.size.height = 25;
        } else if (self.rotate90Degress) {
            frameTitle.size.height = 25;
        } else if (self.rotate45Degress) {
            frameTitle.size.height = 25;
        }
        labelTitle.frame = frameTitle;
        labelTitle.backgroundColor = [UIColor clearColor];
        if (barDetail.titleColor) {
            labelTitle.textColor = barDetail.titleColor;
        } else {
            labelTitle.textColor = self.dimensionColor;
        }
        [self addSubview:labelTitle];
        
        
        originX += widthBar ;
    }
    
    if (self.title) {
        UILabel * labelTitle = [UILabel new];
        [labelTitle setFont:[UIFont boldSystemFontOfSize:10]];
        CGRect frameTitle = labelTitle.frame;
        frameTitle.origin.x = MARGIN_HORIZONTAL;
        frameTitle.origin.y = 0;
        frameTitle.size.height = 30;
        frameTitle.size.width = self.frame.size.width - MARGIN_HORIZONTAL * 2;
        labelTitle.frame = frameTitle;
        labelTitle.text = self.title;
        labelTitle.textColor = self.dimensionColor;
        [labelTitle setTextAlignment:NSTextAlignmentCenter];
        labelTitle.backgroundColor = [UIColor clearColor];
        [self addSubview:labelTitle];
    }
    
    
    [self bringSubviewToFront:lineViewTop];
    [self bringSubviewToFront:lineViewTop2];
    [self bringSubviewToFront:lineViewMiddle];
    [self bringSubviewToFront:lineViewBottom];
    
    [self bringSubviewToFront:limitVerticalView];
    [self bringSubviewToFront:limiteHorizontalView];
    
}


-(void) initChart {
    self.barDetail = [BarDetail new];
    arrayBar = [NSMutableArray new];
    self.showBorder = NO;
    self.abortRotate = YES;
}

-(void) setBar {
    [arrayBar addObject:self.barDetail];
    self.barDetail = [BarDetail new];
}


-(void) getMaxValue {
    int maxValue = 0;
    for (BarDetail * barDetail in arrayBar) {
        if (barDetail.value > maxValue){
            maxValue = barDetail.value;
        }
        if (barDetail.subValue > maxValue){
            maxValue = barDetail.subValue;
        }
    }
    self.maxValue = maxValue;
}


-(void) setAbortRotate:(BOOL)abortRotate {
    if (abortRotate) {
        _rotate45Degress = NO;
        _rotate90Degress = NO;
        _abortRotate = YES;
    }
}


-(void) setRotate45Degress:(BOOL)rotate45Degress {
    if (rotate45Degress) {
        _abortRotate = NO;
        _rotate90Degress = NO;
        _rotate45Degress = YES;
    }
}


-(void) setRotate90Degress:(BOOL)rotate90Degress {
    if (rotate90Degress) {
        _abortRotate = NO;
        _rotate45Degress = NO;
        _rotate90Degress = YES;
    }
}


-(void) getMinValue {
    int minValue = 0;
    BOOL firstOperation = YES;
    for (BarDetail * barDetail in arrayBar) {
        if (barDetail.value < minValue || firstOperation){
            minValue = barDetail.value;
            firstOperation = NO;
        }
    }
    self.minValue = minValue;
}



@end
