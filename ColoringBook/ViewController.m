//
//  ViewController.m
//  ColoringBook
//
//  Created by Casey Blamires on 10/21/13.
//  Copyright (c) 2013 LCSC-CS360. All rights reserved.
//

#import "ViewController.h"
#import "drawingDefaults.h"
#import "SettingsViewController.h"



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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    SettingsViewController * settingsVC = (SettingsViewController *)segue.destinationViewController;
    settingsVC.delegate = self;
    settingsVC.brush = brushSize;
    settingsVC.opacity = opacity;
    settingsVC.red = red;
    settingsVC.green = green;
    settingsVC.blue = blue;
    
}


#pragma mark - SettingsViewControllerDelegate methods

- (void)closeSettings:(id)sender {
    
    brushSize = ((SettingsViewController*)sender).brush;
    opacity = ((SettingsViewController*)sender).opacity;
    [self dismissViewControllerAnimated:YES completion:nil];
    stopDrawing= NO; // turn the drawing feature back on, we're done with the settings page!
}






/* DRAWING FUNCTIONS */


// touchesBegan - capture touches on the screen
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ( !stopDrawing ) { // only do this if we aren't stopped
        // stopping would be at the settings screen, or other screens
        
        
        mouseSwiped = NO;
        UITouch * touch = [touches anyObject]; // touch all the objects!
        lastPoint = [touch locationInView:self.view];
    }
}




// touchesMoved - captures touch MOVEMENT on the screen
// it's so moving!
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ( !stopDrawing ) {
        mouseSwiped = YES; // because we're moving now!
        UITouch * touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:self.view];
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.drawingLayer.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
        // test if the eraser is being used or not!
        if ( eraserIsActive ){
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), eraserSize );
        }
        else {
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brushSize ); // draw!
            
        } //-- end testing if the eraser is being used or not
        
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
    
        self.drawingLayer.image = UIGraphicsGetImageFromCurrentImageContext();
        [self.drawingLayer setAlpha:opacity];
        UIGraphicsEndImageContext();
        lastPoint = currentPoint;
        
    } //-- end of stopDrawing if condintional
    // I think I spelled that wrong and I'm not willing to fix it!
}






// touchesEnded - and we're all done drawing! finish 'er off!
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!stopDrawing ) {
    
        // check to see if the user actually swiped across the screen
        // if not, then just draw a single point
        if(!mouseSwiped) {
            UIGraphicsBeginImageContext(self.view.frame.size);
            [self.drawingLayer.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        
        
            // test if the eraser is being used or not!
            if ( eraserIsActive ){
                CGContextSetLineWidth(UIGraphicsGetCurrentContext(), eraserSize );
            }
            else {
                CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brushSize);
            } //-- end testing if the eraser is being used or not
        
        
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
            CGContextStrokePath(UIGraphicsGetCurrentContext());
            CGContextFlush(UIGraphicsGetCurrentContext());
            self.drawingLayer.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    
        // Move the image from the drawingLayer down to the drawnLayer
        UIGraphicsBeginImageContext(self.drawnLayer.frame.size);
        [self.drawnLayer.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
        [self.drawingLayer.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
        self.drawnLayer.image = UIGraphicsGetImageFromCurrentImageContext();
        self.drawingLayer.image = nil; // erase the drawing layer, since the line is now officially "drawn"
        UIGraphicsEndImageContext();
    }
}







- (IBAction)colorPressed:(id)sender {
    // get the button pressed, then get its tag, and finally set the color based on the tag
    
    // first, turn "off" the eraser
    eraserIsActive = NO;
    opacity = opacityBackup;
    
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
    eraserIsActive = YES; // turns on the eraser.
    // in the initial build stages of this project, the eraser will actually have a
    // brush stroke that is slightly larger than the rest of the colors.
    // eventually this will be editable by the user
    setColor(255,255,255);
    opacityBackup = opacity;
    opacity = 1.0;
}

- (IBAction)settingsButton:(id)sender {
    stopDrawing = YES; // when going to the settings View, stop the drawing abilities!
    // that way the user doesn't "draw" on the settings view and have it show up on the main view.
}
@end
