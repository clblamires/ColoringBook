//
//  ViewController.m
//  ColoringBook
//
//  Created by Casey Blamires on 10/21/13.
//  Copyright (c) 2013 LCSC-CS360. All rights reserved.
//

#import "ViewController.h"
#import "drawingDefaults.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





/* DRAWING FUNCTIONS */


// touchesBegan - capture touches on the screen
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    mouseSwiped = NO;
    UITouch * touch = [touches anyObject]; // touch all the objects!
    lastPoint = [touch locationInView:self.view];
}




// touchesMoved - captures touch MOVEMENT on the screen
// it's so moving!
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    mouseSwiped = YES; // because we're moving now!
    UITouch * touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.drawingLayer.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brushSize ); // draw!
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.drawingLayer.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.drawingLayer setAlpha:opacity];
    UIGraphicsEndImageContext();
    lastPoint = currentPoint;
}






// touchesEnded - and we're all done drawing! finish 'er off!
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // check to see if the user actually swiped across the screen
    // if not, then just draw a single point
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.drawingLayer.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brushSize);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.drawingLayer.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // This is what actually draws to the screen! YAY!
    UIGraphicsBeginImageContext(self.drawnLayer.frame.size);
    [self.drawnLayer.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.drawingLayer.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
    self.drawnLayer.image = UIGraphicsGetImageFromCurrentImageContext();
    self.drawingLayer.image = nil; // erase the drawing layer, since the line is now officially "drawn"
    UIGraphicsEndImageContext();
}





- (IBAction)colorPressed:(id)sender {
}
@end
