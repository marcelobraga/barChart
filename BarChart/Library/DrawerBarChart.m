//
//  DrawerBarChart.m
//  BarChart
//
//  Created by Marcelo Braga on 17/01/14.
//  Copyright (c) 2014 Marcelo Braga. All rights reserved.
//

#import "DrawerBarChart.h"
#import "BarDetail.h"

#define MARGIN_VERTICAL     55
#define MARGIN_HORIZONTAL   30

@implementation DrawerBarChart

#pragma mark - Public methods

-(void) clickBar : (UIButton *) btn {
    if((self.delegate) && ([self.delegate respondsToSelector:@selector(didSelectBar: )])) {
        [self.delegate didSelectBar:[arrayBar objectAtIndex:btn.tag]];
    }
}

- (UIColor *)darkerColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.9, 0.0)
                               green:MAX(g - 0.9, 0.0)
                                blue:MAX(b - 0.9, 0.0)
                               alpha:a];
    return nil;
}

-(void) drawChart {
    if (!self.lineColor) {
        self.lineColor = [UIColor blackColor];
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
    frameVertical.size.height -= 5;
    limitVerticalView.backgroundColor = self.lineColor;
    limitVerticalView.frame = frameVertical;
    
    frameHorizontal.size.width = self.frame.size.width - MARGIN_HORIZONTAL * 2;
    frameHorizontal.size.height = 1;
    frameHorizontal.origin.x = MARGIN_HORIZONTAL;
    frameHorizontal.origin.y = frameVertical.origin.y + frameVertical.size.height;
    limiteHorizontalView.backgroundColor = self.lineColor;
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
        self.fontSize = 9;
    }
    
    UILabel * labelMax = [UILabel new];
    [labelMax setFont:[UIFont systemFontOfSize:self.fontSize]];
    labelMax.textColor = self.lineColor;
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
    labelMax2.textColor = self.lineColor;
    CGRect frameLabelMax2 = labelMax2.frame;
    frameLabelMax2.origin.x = 2;
    frameLabelMax2.origin.y = frameLineTop2.origin.y - 15;
    frameLabelMax2.size.width = 40;
    frameLabelMax2.size.height = 30;
    labelMax2.frame = frameLabelMax2;
    labelMax2.text = [NSString stringWithFormat:@"%i", self.maxValue - (self.maxValue / 4)];
    if (![labelMax2.text isEqualToString:labelMax.text]) {
        [self addSubview:labelMax2];
    }
    
    UILabel * labelBottom = [UILabel new];
    [labelBottom setFont:[UIFont systemFontOfSize:self.fontSize]];
    labelBottom.textColor = self.lineColor;
    CGRect frameLabelBottom = labelBottom.frame;
    frameLabelBottom.origin.x = 2;
    frameLabelBottom.origin.y = frameLineBottom.origin.y - 15;
    frameLabelBottom.size.width = 40;
    frameLabelBottom.size.height = 30;
    labelBottom.frame = frameLabelBottom;
    labelBottom.text = [NSString stringWithFormat:@"%i", self.maxValue / 4];
    if (self.maxValue / 4 > 0) {
        [self addSubview:labelBottom];
    }
    
    
    UILabel * labelAverage = [UILabel new];
    [labelAverage setFont:[UIFont systemFontOfSize:self.fontSize]];
    labelAverage.textColor = self.lineColor;
    CGRect frameLabelAverage = labelAverage.frame;
    frameLabelAverage.origin.x = 2;
    frameLabelAverage.origin.y = frameLineMiddle.origin.y - 15;
    frameLabelAverage.size.width = 40;
    frameLabelAverage.size.height = 30;
    labelAverage.frame = frameLabelAverage;
    labelAverage.text = [NSString stringWithFormat:@"%i", self.maxValue / 2];
    if (![labelAverage.text isEqualToString:labelBottom.text]) {
        [self addSubview:labelAverage];
    }
    
    
    UILabel * labelZero = [UILabel new];
    [labelZero setFont:[UIFont systemFontOfSize:self.fontSize]];
    labelZero.textColor = self.lineColor;
    CGRect frameLabelZero = labelZero.frame;
    frameLabelZero.origin.x = 2;
    frameLabelZero.origin.y = frameHorizontal.origin.y - 15;
    frameLabelZero.size.width = 40;
    frameLabelZero.size.height = 30;
    labelZero.frame = frameLabelZero;
    labelZero.text = @"0";
    [self addSubview:labelZero];
    
    
    double heightDefinition = limitVerticalView.frame.size.height / self.maxValue;
    int originX = frameLineTop.origin.x + 10;
    int widthBar = limiteHorizontalView.frame.size.width / arrayBar.count;
    
    int index = 0;
    
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
        
        //===== reduce bar width
        
        if(frameBar.size.width > 40) {
            frameBar.size.width = 30;
        }
        
        //=====
        
        frameBar.size.height = heightBar + 1;
        bar.frame = frameBar;
        
        if (self.masterColor) {
            barDetail.color = self.masterColor;
        }
        
        //===== add a popup image above a bar including its value
        
        UIImageView *imgPopUp   = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popup-item.png"]];
        float barWidth          = frameBar.size.width;
        float imgPadding        = 0;
        
        if(barWidth > 30) {
            imgPadding = (barWidth-30);
        }
        
        imgPopUp.frame          = CGRectMake(((imgPadding/2)+frameBar.origin.x),(frameBar.origin.y-30),(barWidth-imgPadding),25);
        [self addSubview:imgPopUp];
        UILabel *uilValue       = [[UILabel alloc] initWithFrame:CGRectMake((imgPopUp.frame.origin.x+10),(imgPopUp.frame.origin.y-2),imgPopUp.frame.size.width,imgPopUp.frame.size.height)];
        uilValue.text           = [NSString stringWithFormat:@"%i",(int)barDetail.value];
        uilValue.textColor      = [UIColor whiteColor];
        uilValue.font           = [UIFont fontWithName:@"HelveticaNeue" size:13];
        [self addSubview:uilValue];
        
        //=====
        
        if (self.showGradient) {
            CAGradientLayer *gradient = [CAGradientLayer layer];
            gradient.frame = bar.bounds;
            gradient.colors = [NSArray arrayWithObjects:(id)barDetail.color.CGColor, (id)[self darkerColorForColor:barDetail.color].CGColor, nil];
            [bar.layer insertSublayer:gradient atIndex:0];
        } else {
            bar.backgroundColor = barDetail.color;
        }
        
        [self addSubview:bar];
        
        if (self.showBorder) {
            bar.layer.borderWidth = 1;
            bar.layer.borderColor = self.lineColor.CGColor;
        } else {
            bar.layer.borderWidth = 0;
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
            if (!barDetail.subColor) {
                barDetail.subColor = [self lighterColorForColor:barDetail.color];
            }
            
            if (self.showGradient) {
                CAGradientLayer *gradient = [CAGradientLayer layer];
                gradient.frame = subBar.bounds;
                gradient.colors = [NSArray arrayWithObjects:(id)barDetail.subColor.CGColor, (id)[self darkerColorForColor:barDetail.subColor].CGColor, nil];
                [subBar.layer insertSublayer:gradient atIndex:0];
            } else {
                subBar.backgroundColor = barDetail.subColor;
            }
            
            subBar.layer.borderWidth = 1;
            if (self.showBorder) {
                subBar.layer.borderColor = self.lineColor.CGColor;
            } else {
                subBar.layer.borderColor = [self lighterColorForColor:barDetail.subColor].CGColor;
            }
            
            [self addSubview:subBar];
            
            frameHorizontal.size.width += 5;
            limiteHorizontalView.frame = frameHorizontal;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = frameBar;
            btn.tag = index;
            [btn addTarget:self action:@selector(clickBar:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = frameBar;
        btn.tag = index;
        [btn addTarget:self action:@selector(clickBar:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UILabel * labelTitle = [UILabel new];
        labelTitle.text = barDetail.title;
        [labelTitle setFont:[UIFont boldSystemFontOfSize:self.fontSize]];
        
        CGRect frameTitle = labelTitle.frame;
        //frameTitle.origin.x = originX;
        //frameTitle.origin.y = frameBar.origin.y + frameBar.size.height + 5   ;
        //frameTitle.origin.y += 5;
        //frameTitle.size.width = widthBar;
        frameTitle.origin.x     = (originX-30);
        frameTitle.origin.y     = (frameBar.origin.y+frameBar.size.height+10);
        frameTitle.size.width   = [self getTextWidth:barDetail.title withFontName:@"HelveticaNeue" withFontSize:10];
        
        if (self.rotate45Degress) {
            frameTitle.origin.x     = (originX-50);
            frameTitle.size.width  *= 2;
            [labelTitle setTransform:CGAffineTransformMakeRotation(-0.9)];
            [labelTitle setTextAlignment:NSTextAlignmentLeft];
        } else if (self.rotate90Degress) {
            [labelTitle setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
            [labelTitle setTextAlignment:NSTextAlignmentRight];
            frameTitle.origin.x = (originX-13);
            frameTitle.origin.y = (frameBar.origin.y+frameBar.size.height+50);
        } else {
            [labelTitle setTextAlignment:NSTextAlignmentCenter];
        }
        
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
            labelTitle.textColor = self.lineColor;
        }
        
        [self addSubview:labelTitle];
        
        originX += widthBar ;
        index++;
    }
    
    if (self.title) {
        UILabel * labelTitle = [UILabel new];
        [labelTitle setFont:[UIFont boldSystemFontOfSize:15]];
        CGRect frameTitle = labelTitle.frame;
        frameTitle.origin.x = MARGIN_HORIZONTAL;
        frameTitle.origin.y = 0;
        frameTitle.size.height = 30;
        frameTitle.size.width = self.frame.size.width - MARGIN_HORIZONTAL * 2;
        labelTitle.frame = frameTitle;
        labelTitle.text = self.title;
        labelTitle.textColor = self.lineColor;
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
    
    if (self.masterColor) {
        self.backgroundColor = self.masterColor;
    }
    
    if (self.showGradient) {
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = self.bounds;
        gradient.colors = [NSArray arrayWithObjects: (id)[self lighterColorForColor:self.backgroundColor].CGColor, (id)self.backgroundColor.CGColor, nil];
        [self.layer insertSublayer:gradient atIndex:0];
    }
    
    if (self.showBorder || self.showGradient) {
        self.layer.borderColor = self.lineColor.CGColor;
        self.layer.borderWidth = 1;
    }
    
    if(self.showShadow) {
        self.layer.shadowColor    = [UIColor blackColor].CGColor;
        self.layer.shadowOffset   = CGSizeMake(0,2);
        self.layer.shadowOpacity  = 0.9;
        self.layer.shadowRadius   = 2;
    }
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
    if (maxValue < 10) {
        self.maxValue = maxValue + 1;
    } else {
        self.maxValue = maxValue * 1.1;
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

// calculate label's width according to font informed
-(int)getTextWidth:(NSString *)text withFontName:(NSString *)fontName withFontSize:(float)fontSize {
    NSString *label = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    int lblWidth    = [label boundingRectWithSize:CGSizeMake(285,4000) options:NSStringDrawingUsesFontLeading attributes:nil context:nil].size.width;
    
    return lblWidth;
}

-(void) initChart {
    self.barDetail = [BarDetail new];
    arrayBar = [NSMutableArray new];
    self.showBorder = NO;
    self.abortRotate = YES;
    self.showGradient = YES;
    self.showShadow = NO;
}

- (UIColor *)lighterColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MIN(r + 0.6, 1.0)
                               green:MIN(g + 0.6, 1.0)
                                blue:MIN(b + 0.6, 1.0)
                               alpha:a];
    return nil;
}

-(void)resetChart {
    self.barDetail      = nil;
    arrayBar            = nil;
    self.showBorder     = NO;
    self.abortRotate    = NO;
    self.showGradient   = NO;
    self.showShadow     = NO;
    
    for(UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

-(void) setAbortRotate:(BOOL)abortRotate {
    if (abortRotate) {
        _rotate45Degress = NO;
        _rotate90Degress = NO;
        _abortRotate = YES;
    }
}

-(void) setBar {
    [arrayBar addObject:self.barDetail];
    self.barDetail = [BarDetail new];
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

#pragma mark - Lifecycle methods

-(id) init {
    self = [super init];
    self.barDetail = [BarDetail new];
    return self;
}

@end
