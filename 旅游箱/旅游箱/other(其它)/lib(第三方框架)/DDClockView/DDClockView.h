//
//  ColckView.h
//  Clock
//
//  Created by dxl on 12-12-30.
//
//

#import <UIKit/UIKit.h>

@class DDDialView;
@class DDNeedleHourView;
@class DDNeedleMinuteView;
@class DDNeedleSecondView;

@protocol DDClockViewDelegate <NSObject>
@optional
-(void)clockWithHour:(long)hour minute:(long)minute tag:(long)tag;
@end

@interface DDClockView : UIView{

    DDDialView *_viewOfDial;
    
    DDNeedleHourView *_viewOfHourNeedle;
    
    DDNeedleMinuteView *_viewOfMinuteNeedle;
    
    DDNeedleSecondView *_viewOfSecondNeedle;
    
}
@property (nonatomic,assign) int clockJetLag;
@property (nonatomic,weak) id <DDClockViewDelegate>delegate;
-(void)startTimer;
-(void)endTimer;
@end
