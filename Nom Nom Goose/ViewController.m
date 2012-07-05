//
//  ViewController.m
//  Nom Nom Goose
//
//  Created by iD Student on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize duck1;
@synthesize duck2;
@synthesize goose;
@synthesize food;
@synthesize floatingFood;



- (void)viewDidLoad
{
    
    x = 50;
	y = 50;
	vx = 3.0;
	vy = 3.0;
	bounce = -1; 
    
    x2 = 80;
	y2 = 90;
	vx2 = 3.0;
	vy2 = 3.0;
    
    x3 = 112;
	y3 = 73;
	vx3 = 3.0;
	vy3 = 3.0;
    
        killThrow = 0;
    
    foodsizex = 20;
    foodsizey = 20;
    
    justStart = true;
    
    returnto = food.center;
    
    foodx = food.center.x;
    foody = food.center.y;
    
    foodOut = NO;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
	timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(animate) userInfo:nil repeats:YES];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(animate2) userInfo:nil repeats:YES];

    
    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(random) userInfo:nil repeats:YES];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(animate3) userInfo:nil repeats:YES];
    

    
    //SWIPING ACTION
    
    UISwipeGestureRecognizer *SwipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(upwardSwipe)];
    SwipeUp.numberOfTouchesRequired = 1;
    SwipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    
    [self.view addGestureRecognizer:SwipeUp];
    
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidUnload
{
    [self setDuck1:nil];
    [self setDuck2:nil];
    [self setGoose:nil];
    [self setFood:nil];
    [self setFloatingFood:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//MOVING LE DUCKS

-(void)animate {
    duck1.center = CGPointMake(x, y);
	
	/*velocity*/
	x += vx;
	y += vy;
	/*bounce*/
	if(x >= 444)
	{
        x = 444;
		vx *= bounce;
	}
	else if(x <= 20)
	{
		x = 20;
		vx *= bounce;
	}
	if(y >= 224)
	{
		y = 224;
		vy *= bounce;
	}
	else if(y <= 20)
	{
		y = 20;
		vy *= bounce;
	}
   
}

-(void)animate2 {
    
    duck2.center = CGPointMake(x2, y2);
	
	/*velocity*/
	x2 += vx2;
	y2 += vy2;
	/*bounce*/
	if(x2 >= 444)
	{
        x2 = 444;
		vx2 *= bounce;
	}
	else if(x2 <= 20)
	{
		x2 = 20;
		vx2 *= bounce;
	}
	if(y2 >= 224)
	{
		y2 = 224;
		vy2 *= bounce;
	}
	else if(y2 <= 20)
	{
		y2 = 20;
		vy2 *= bounce;
	}
}

-(void)animate3 {
    
    goose.center = CGPointMake(x3, y3);
	
	/*velocity*/
	x3 += vx3;
	y3 += vy3;
	/*bounce*/
	if(x3 >= 444)
	{
        x3 = 444;
		vx3 *= bounce;
	}
	else if(x3 <= 20)
	{
		x3 = 20;
		vx3 *= bounce;
	}
	if(y3 >= 224)
	{
		y3 = 224;
		vy3 *= bounce;
	}
	else if(y3 <= 20)
	{
		y3 = 20;
		vy3 *= bounce;
	}
}


-(void)random {
    int number = arc4random() % 2;
    if (number == 0){
        vx = arc4random() % 5 + 1;
        vy = arc4random() % 5 + 1;
    }
    else if (number == 1){
        vx2 = arc4random() % 5 + 1;
        vy2 = arc4random() % 5 + 1;
    }
    else if (number == 2){
        vx3 = arc4random() % 5 + 1;
        vy3 = arc4random() % 5 + 1;
    }
    
}






-(void) upwardSwipe {
    NSLog(@"SWIPED");
    foodOut = true;
    
    
    //NOTE TO SELF: FIND A WAY OF SLOWING THIS DOWN. MAYBE ADD TIMER THEN DO THIS

    if (![foodTime isValid]){
            foodTime = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(foodfly) userInfo:nil repeats:YES];
    }
    killThrow = 0;
    
    
}

-(void) foodfly {
    if (foodOut){
       
    food.center = CGPointMake(foodx, foody);

	/*velocity*/
	//foodx += 3;å
        if (killThrow < 10){
          	foody -= 5;  
        }
        else if (killThrow < 20){
            foody -= 3;
        }
        else {
            foody -= 5;
            foodsizey-= .5;
            foodsizex-= .5;
            floatingFood.center = food.center;
            floatingFood.hidden = YES;
        }
        CGRect buttonFrame = food.frame;
        buttonFrame.size = CGSizeMake(foodsizex, foodsizey);
        food.frame = buttonFrame;

    if (killThrow >= 30 || food.center.y <= 150){
        
        foodOut = false;
        justStart = false;
                }
        killThrow++;
        
    }
    else {
        [foodTime invalidate];
        if (![foodTime isValid]){
            [self bob];
        foodWait = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(resetFood) userInfo:nil repeats:NO];
        
        }
         
    }

}

-(void) bob {
    floatingFood.hidden = NO;
    [foodTime invalidate];
    
}

-(void) resetFood {
    food.center = CGPointMake(returnto.x,returnto.y);
    foodx = returnto.x;
    foody = returnto.y;
    
    foodsizey = 20;
    foodsizex = 20;
    
    CGRect buttonFrame = food.frame;
    buttonFrame.size = CGSizeMake(foodsizex, foodsizey);
    food.frame = buttonFrame;
    [foodTime invalidate];
}

-(void) stopTimer {
    pauseStart = [NSDate dateWithTimeIntervalSinceNow:0];
    
    previousFireDate = [foodTime fireDate];
    
    [foodTime setFireDate:[NSDate distantFuture]];
    
}

-(void) startTimer {
    float pauseTime = -1*[pauseStart timeIntervalSinceNow];
    
    [foodTime setFireDate:[previousFireDate initWithTimeInterval:pauseTime sinceDate:previousFireDate]];
    
}

@end
