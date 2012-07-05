//
//  ViewController.h
//  Nom Nom Goose
//
//  Created by iD Student on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIGestureRecognizerDelegate>{
    float x, y, vx, vy, bounce, x2, y2, vx2, vy2, x3, y3, vx3, vy3, foodx, foody,foodsizex,foodsizey;
    NSTimer *timer, *foodTime, *foodWait;
    CGPoint returnto, landPoint;
    bool foodOut, justStart;
    int killThrow;
    NSDate *pauseStart, *previousFireDate;
    
}

@property (weak, nonatomic) IBOutlet UIButton *duck1;
@property (weak, nonatomic) IBOutlet UIButton *duck2;

@property (weak, nonatomic) IBOutlet UIButton *goose;
@property (weak, nonatomic) IBOutlet UIButton *food;

@property (weak, nonatomic) IBOutlet UIButton *floatingFood;

-(void) stopTimer;
-(void) startTimer;

@end
