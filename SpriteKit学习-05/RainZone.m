//
//  RainZone.m
//  SpriteKit学习-05
//
//  Created by ccguo on 15/11/21.
//  Copyright © 2015年 ccguo. All rights reserved.
//

#import "RainZone.h"

static inline CGFloat skRandf(){
    return rand() / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high){
    return skRandf() * (high - low) + low;
}

@implementation RainZone

+ (float)bottomBaseLine:(float)x
{
    float y = 0;
    ScreenHeight;
    y = - TanValue * x + (pow(ScreenWidth, 2) + pow(ScreenHeight, 2)) / ScreenHeight;
    return y;
}

+ (float)topBaseLine:(float)x
{
    float y = 0;
    y = [self bottomBaseLine:x] + RainZoneHeight / sinValue;
    return y;
}

+ (float)leftBaseLine:(float)x
{
    float y = 0;
    y = TanValue * x + ScreenWidth - (RainZoneWidth / 2) / sinValue;
    return y;
}

+ (float)rightBaseLine:(float)x
{
    float y = 0;
    y = TanValue * x - ScreenWidth + (RainZoneWidth / 2) / sinValue;
    return y;
}

+ (CGPoint)randRainPosition
{
    // x (width - sin*rainW/2   ,   width + sin*rainW/2)
    // y (height - cos*rainW/2  ,   height + cos*rainW/2)
    
    CGFloat valueH = sinValue*RainZoneWidth/2;
    CGFloat valueV = cosValue*RainZoneWidth/2;

    CGFloat startPointX = skRand(ScreenWidth - valueH, ScreenWidth + valueH);
    CGFloat startPointY = skRand(ScreenHeight - valueV, ScreenHeight + valueV);
//    CGFloat startPointMaxY =

    CGPoint point = CGPointMake(startPointX + 20, startPointY + 50);
    
    return point;
}
@end
