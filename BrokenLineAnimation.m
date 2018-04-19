//
//  BrokenLineAnimation.m
//  Reha Mstim
//
//  Created by longest on 2016/12/15.
//  Copyright © 2016年 longest.Guangz. All rights reserved.
//

#import "BrokenLineAnimation.h"
@interface BrokenLineAnimation()
@property(nonatomic,strong)UIView *                 animationLayerView;
@property(nonatomic,assign)CGMutablePathRef         solidShapePath;
@end

@implementation BrokenLineAnimation
-(NSMutableArray *)pointsArr{
    if (!_pointsArr) {
        _pointsArr = [NSMutableArray array];
    }
    return _pointsArr;

}
-(instancetype)init{
    if (self = [super init]) {
        
    }
    

    return self;
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    float Hight = 40.f;
    self.backgroundColor = [UIColor clearColor];
    
    CGPoint startP = CGPointMake(10, Hight*0.5);
    CGPoint sameStartP1 = CGPointMake((0.4*SCREEN_WIDTH - startP.x)*0.2+startP.x, Hight*0.5);
    CGPoint sameStartP2 = CGPointMake((0.4*SCREEN_WIDTH - startP.x)*0.4+startP.x, Hight*0.5);
    CGPoint sameStartP3 = CGPointMake((0.4*SCREEN_WIDTH - startP.x)*0.6+startP.x, Hight*0.5);
    CGPoint sameStartP4 = CGPointMake((0.4*SCREEN_WIDTH - startP.x)*0.8+startP.x, Hight*0.5);

    
    CGPoint turningP1 = CGPointMake(0.4*SCREEN_WIDTH, Hight*0.5);
    CGPoint turningP2 = CGPointMake(turningP1.x+10, Hight*0.3);
    CGPoint turningP3 = CGPointMake(turningP2.x+15, Hight*0.5+2);
    CGPoint turningP4 = CGPointMake(turningP3.x+15, Hight*0.5-10);
    CGPoint turningP5 = CGPointMake(turningP4.x+15, Hight*0.5+6);
    CGPoint turningP6 = CGPointMake(turningP5.x+15, Hight*0.5-15);
    CGPoint turningP7 = CGPointMake(turningP6.x+10, Hight*0.5);
    
    CGPoint endP = CGPointMake(SCREEN_WIDTH-10 , self.height*0.5);
    CGPoint sameEndP1 = CGPointMake((endP.x - turningP7.x)*0.3+turningP7.x , self.height*0.5);
    CGPoint sameEndP2 = CGPointMake((endP.x - turningP7.x)*0.6+turningP7.x , self.height*0.5);
    CGPoint sameEndP3 = CGPointMake((endP.x - turningP7.x)*0.9+turningP7.x , self.height*0.5);

    
    
    
    [self.pointsArr addObject:[NSValue valueWithCGPoint:startP]];
    [self.pointsArr addObject:[NSValue valueWithCGPoint:sameStartP1]];
    [self.pointsArr addObject:[NSValue valueWithCGPoint:sameStartP2]];
    [self.pointsArr addObject:[NSValue valueWithCGPoint:sameStartP3]];
    [self.pointsArr addObject:[NSValue valueWithCGPoint:sameStartP4]];

    [self.pointsArr addObject:[NSValue valueWithCGPoint:turningP1]];
    [self.pointsArr addObject:[NSValue valueWithCGPoint:turningP2]];
    [self.pointsArr addObject:[NSValue valueWithCGPoint:turningP3]];
    [self.pointsArr addObject:[NSValue valueWithCGPoint:turningP4]];
    [self.pointsArr addObject:[NSValue valueWithCGPoint:turningP5]];
    [self.pointsArr addObject:[NSValue valueWithCGPoint:turningP6]];
    [self.pointsArr addObject:[NSValue valueWithCGPoint:turningP7]];
    [self.pointsArr addObject:[NSValue valueWithCGPoint:sameEndP1]];
    [self.pointsArr addObject:[NSValue valueWithCGPoint:sameEndP2]];
    [self.pointsArr addObject:[NSValue valueWithCGPoint:sameEndP3]];

    [self.pointsArr addObject:[NSValue valueWithCGPoint:endP]];

    CAShapeLayer *solidShapeLayer = [CAShapeLayer layer];
    CAShapeLayer *solidShadowLayer = [CAShapeLayer layer];
    
    CGMutablePathRef solidShapePath =  CGPathCreateMutable();
    
    [solidShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [solidShapeLayer setStrokeColor:[RGB(200, 200, 200) CGColor]];
    solidShapeLayer.lineWidth = 1.0f ;
    CGPoint bufferPoint = [[self.pointsArr firstObject] CGPointValue];
    
    for (NSValue *pointVlue in self.pointsArr) {
        
        CGPoint p = [pointVlue CGPointValue];
        CGPathMoveToPoint(solidShapePath, NULL, bufferPoint.x, bufferPoint.y);
        CGPathAddLineToPoint(solidShapePath, NULL, p.x,p.y);
        bufferPoint = p;
        
      

    }
    [solidShapeLayer setPath:solidShapePath];

    [self.layer addSublayer:solidShapeLayer];
    
    [solidShadowLayer setFillColor:[[UIColor clearColor] CGColor]];
    [solidShadowLayer setStrokeColor:[RGB(255, 255, 255) CGColor]];
    solidShadowLayer.lineWidth = 1.5f ;
    
    
    UIView * whiteView = [[UIView alloc]initWithFrame:CGRectMake(10, 0.5 *Hight-2.5, 5, 5)];
    
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 4.f;
    
    
        CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
        keyAnimation.path = solidShapePath;
    
        keyAnimation.duration = 1.5;
    
  
    keyAnimation.repeatDuration = self.repeatDuration;
    
    [whiteView.layer addAnimation:keyAnimation forKey:nil];
    [self.layer addSublayer:whiteView.layer];
    self.solidShapePath = solidShapePath;
    self.animationLayerView = whiteView;
}


-(void)StartNow{
    if (self.animationLayerView != nil) {
        [self.animationLayerView removeFromSuperview];
        
        UIView * whiteView = [[UIView alloc]initWithFrame:CGRectMake(10, 0.5 *40-2.5, 5, 5)];
        
        whiteView.backgroundColor = [UIColor whiteColor];
        whiteView.layer.cornerRadius = 4.f;
        
        
        CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        
        keyAnimation.path = self.solidShapePath;
        keyAnimation.duration = 1.5;
        
        keyAnimation.repeatDuration = self.repeatDuration;
        
        [whiteView.layer addAnimation:keyAnimation forKey:nil];
        [self.layer addSublayer:whiteView.layer];
        
        self.animationLayerView = whiteView;
    }

}
@end
