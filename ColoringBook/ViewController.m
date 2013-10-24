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
    // get the button pressed, then get its tag, and finally set the color based on the tag
    UIButton * color = (UIButton *) sender;
    
    if (color.tag == 0) {
        setColor(28, 28, 28);
    }
    else if (color.tag == 1) {
        setColor(29,96,203);
    }
    else if (color.tag == 2) {
        setColor(180, 103, 77);
    }
    else if (color.tag == 3) {
        setColor(149, 145, 140);
    }
    else if (color.tag == 4) {
        setColor(128, 218, 235);
    }
    else if (color.tag == 5) {
        setColor(117, 255, 122);
    }
    else if (color.tag == 6) {
        setColor(116, 10, 10);
    }
    else if (color.tag == 7) {
        setColor(238, 132, 29);
    }
    else if (color.tag == 8) {
        setColor(252, 116, 253);
    }
    else if (color.tag == 9) {
        setColor(143, 80, 157);
    }
    else if (color.tag == 10) {
        setColor(238, 32, 32);
    }
    else if (color.tag == 11) {
        setColor(250, 167, 108);
    }
    else if (color.tag == 12) {
        setColor(255, 255, 255);
    }
    else if (color.tag == 13) {
        setColor(252, 232, 131);
    }
    else if (color.tag == 14) {
        setColor(197, 227, 132);
    }
    else if (color.tag == 15) {
        setColor(28, 172, 120);
    }
    
    //NSLog(@"Color has been set!");
    // this above line is commented out because we no longer need it to tell us every dang time the button is pushed!
}

- (IBAction)eraserPressed:(id)sender {
}
@end
