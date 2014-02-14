//
//  BarDetail.h
//  BarChart
//
//  Created by Marcelo Braga on 20/01/14.
//  Copyright (c) 2014 Marcelo Braga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BarDetail : NSObject {
    
}

@property (nonatomic, assign) NSString * title;
@property (nonatomic, assign) double value;
@property (nonatomic, assign) UIColor * color;
@property (nonatomic, assign) UIColor * titleColor;
@property (nonatomic, assign) UIColor * subColor;
@property (nonatomic, assign) double subValue;


@end
