//
//  NeedleView.h
//  Clock
//
//  Created by dxl dxl on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDNeedleView : UIView{

    float _angle;
    
    float _radius;
    
    CGPoint _centerCircle;
}

@property (nonatomic,assign) float angle;

@property (nonatomic,assign) CGPoint centerCircle;

@end

@interface DDNeedleHourView : DDNeedleView

@end

@interface DDNeedleMinuteView : DDNeedleView

@end

@interface DDNeedleSecondView : DDNeedleView

@end