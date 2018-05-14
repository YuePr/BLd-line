//
//  BrokenLineAnimation.h
//  Reha Mstim
//
//  Created by yuepr on 2016/12/15.
//  Copyright © 2016年 yuepr.Guangz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrokenLineAnimation : UIView
@property(nonatomic,getter=startNow)BOOL                start;
@property(nonatomic,strong)NSMutableArray *             pointsArr;
@property(nonatomic,assign)float                        repeatDuration;
-(void)StartNow;
-(instancetype)init;
-(void)drawRect:(CGRect)rect;
@end
