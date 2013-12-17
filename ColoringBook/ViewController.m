//
//  ViewController.m
//  ColoringBook
//
//  Created by Casey Blamires and Katy Phipps on 10/21/13.
//  Copyright (c) 2013 LCSC-CS360. All rights reserved.
//


/*
 View Controller is the brains for the main vew on the storybvoards. When the user taps any of the buttons, this
 file controls what happens!
 
 User can draw on the storyboard, tap color buttons, etc.
 */



// necessary imports
#import "ViewController.h"
#import "drawingDefaults.h"
#import "SettingsViewController.h" // we need the settingsviewcontroller because of the segue between view controllers
#import "soundEffects.h"
#import <AVFoundation/AVFoundation.h>



@interface ViewController ()
@end





@implementation ViewController

AVAudioPlayer * player; // music player for the background music






- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //play the music here...?
    
    
    /*
     "Ambler" Kevin MacLeod (incompetech.com)
     Licensed under Creative Commons: By Attribution 3.0
     http://creativecommons.org/licenses/by/3.0/
     */
    
    _bgMusicVolume = 0.2;
    
    _resourcePath = [[NSBundle mainBundle] resourcePath];
    _resourcePath = [_resourcePath stringByAppendingString:bgMusic];
    NSError * err;
    _backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:_resourcePath] error:&err];
    if ( err )
    {
        NSLog(@"Music player did not load correctly");
    }
    else{
        _backgroundMusic.delegate = self;
        _backgroundMusic.numberOfLoops = -1;
        _backgroundMusic.volume = _bgMusicVolume; //-- make sure that volume is low enough to not cover up the sound effects
        [_backgroundMusic play];
    }
    
    
    
    // check for iPad vs iPhone
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        brushSize = 10; //basically, if we're on an iPhone, we don't need such a huge brush size.
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// prepareForSegue is called when the user tries to go to the next view controller (in this case, the
// settings view controller). It initializes a settingsvewcontroller object with the destination view controller
// and then sets it's properties to the values in this view controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    SettingsViewController * settingsVC = (SettingsViewController *)segue.destinationViewController;
    settingsVC.delegate = self; //-- this one is important so as to properly set the delegate
    settingsVC.brush = brushSize;
    settingsVC.opacity = opacity;
    settingsVC.red = red;
    settingsVC.green = green;
    settingsVC.blue = blue;
    settingsVC.backgroundMusic = _backgroundMusic;
    settingsVC.coloringBookPage = _coloringBookPage;
    
}


#pragma mark - SettingsViewControllerDelegate methods

// closeSettings method
// this closes down the settings view controller
// it is called when the settings view controller is closed
- (void)closeSettings:(id)sender {
    
    brushSize = ((SettingsViewController*)sender).brush; // save the brush size
    opacity = ((SettingsViewController*)sender).opacity; // save the brush opacity

    _backgroundMusic.volume = ((SettingsViewController*)sender).bgMusicVolume; // set the background music volume

    [self dismissViewControllerAnimated:YES completion:nil]; // dismiss the view controller
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
        //UIGraphicsBeginImageContext(self.view.frame.size);
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, 0.5);
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





// colorPressed - what happens when the user pushes a button for the color?
- (IBAction)colorPressed:(id)sender {
    // get the button pressed, then get its tag, and finally set the color based on the tag
    
    // first, turn "off" the eraser
    
    if ( eraserIsActive )
    {
        eraserIsActive = NO;
        opacity = opacityBackup;
    }
    
    //eraserIsActive = NO;
    //opacity = opacityBackup;
    
    // set the path to the sound effects
    NSString * resourcePath = [[NSBundle mainBundle] resourcePath];
    // each button will have a sound effect for it, as seen below
    
    UIButton * color = (UIButton *) sender; // save the currently pushed button
    
    if (color.tag == 0) {
        setColor(28, 28, 28);
        resourcePath = [resourcePath stringByAppendingString:sfxBlack];
    }
    else if (color.tag == 1) {
        setColor(29,96,203);
        resourcePath = [resourcePath stringByAppendingString:sfxBlue];
    }
    else if (color.tag == 2) {
        setColor(180, 103, 77);
        resourcePath = [resourcePath stringByAppendingString:sfxBrown];
    }
    else if (color.tag == 3) {
        setColor(149, 145, 140);
        resourcePath = [resourcePath stringByAppendingString:sfxGrey];
    }
    else if (color.tag == 4) {
        setColor(128, 218, 235);
        resourcePath = [resourcePath stringByAppendingString:sfxLightBlue];
    }
    else if (color.tag == 5) {
        setColor(117, 255, 122);
        resourcePath = [resourcePath stringByAppendingString:sfxLightGreen];
    }
    else if (color.tag == 6) {
        setColor(116, 10, 10);
        resourcePath = [resourcePath stringByAppendingString:sfxMaroon];
    }
    else if (color.tag == 7) {
        setColor(238, 132, 29);
        resourcePath = [resourcePath stringByAppendingString:sfxOrange];
    }
    else if (color.tag == 8) {
        setColor(252, 116, 253);
        resourcePath = [resourcePath stringByAppendingString:sfxPink];
    }
    else if (color.tag == 9) {
        setColor(143, 80, 157);
        resourcePath = [resourcePath stringByAppendingString:sfxPurple];
    }
    else if (color.tag == 10) {
        setColor(238, 32, 32);
        resourcePath = [resourcePath stringByAppendingString:sfxRed];
    }
    else if (color.tag == 11) {
        setColor(200, 168, 146); // NOTE TO SELF: Casey you changed this color, be sure to update the actual color button too!
        resourcePath = [resourcePath stringByAppendingString:sfxTan];
    }
    else if (color.tag == 12) {
        setColor(255, 255, 255);
        resourcePath = [resourcePath stringByAppendingString:sfxWhite];
    }
    else if (color.tag == 13) {
        setColor(252, 232, 131);
        resourcePath = [resourcePath stringByAppendingString:sfxYellow];
    }
    else if (color.tag == 14) {
        setColor(197, 227, 132);
        resourcePath = [resourcePath stringByAppendingString:sfxYellowGreen];
    }
    else if (color.tag == 15) {
        setColor(28, 172, 120);
        resourcePath = [resourcePath stringByAppendingString:sfxGreen];
    }
    
    //NSLog(@"Color has been set!");
    // this above line is commented out because we no longer need it to tell us every dang time the button is pushed!
    
    
    
    // sound playing!
    NSError * err;
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:resourcePath] error:&err];
    if ( err )
    {
        NSLog(@"Music failure");
    }
    else{
        if ( self.backgroundMusic.volume != 0 )
        {
            player.delegate = self;
            [player play];
        }
        
    }
    
    
}

- (IBAction)eraserPressed:(id)sender {
    eraserIsActive = YES; // turns on the eraser.
    // in the initial build stages of this project, the eraser will actually have a
    // brush stroke that is slightly larger than the rest of the colors.
    // eventually this will be editable by the user
    setColor(255,255,255);
    opacityBackup = opacity;
    opacity = 1.0;
    // add a noise for the eraser
}

- (IBAction)settingsButton:(id)sender {
    stopDrawing = YES; // when going to the settings View, stop the drawing abilities!
    // that way the user doesn't "draw" on the settings view and have it show up on the main view.
}



// called when the share button is pressed
// this method will save the drawnLayer and the coloringBookPage layer all as one imaveview, then send it
- (IBAction)sharePressed:(id)sender {
    
    
    
    UIGraphicsBeginImageContext(self.shareLayer.frame.size);
    [self.shareLayer.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.drawnLayer.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    self.shareLayer.image = UIGraphicsGetImageFromCurrentImageContext();
    //self.drawnLayer.image = nil; // erase the drawing layer, since the line is now officially "drawn"
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(self.shareLayer.frame.size);
    [self.shareLayer.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.coloringBookPage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    self.shareLayer.image = UIGraphicsGetImageFromCurrentImageContext();
    //self.drawingLayer.image = nil; // erase the drawing layer, since the line is now officially "drawn"
    UIGraphicsEndImageContext();
    
    // at this point in the code, the shareLayer contains the drawing and the coloring book page all combined.
    
    //NSLog(@"Testing, does the code even get here?"); // evidently it does, remove this!
    
    NSArray *activityItems;
    activityItems = @[_postText.text = @"This is a cool app!", _shareLayer.image];
    
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    [self presentViewController:activityController animated:YES completion:NULL];
    self.shareLayer.image = nil;
    NSLog(@"Image is finished being sent");
}


// clearAllButton - clears the page (use an alertview to make sure the user actually wants to do this though)
- (IBAction)clearAllButton:(id)sender {
    NSString * alertTitle = @"Clear Drawing";
    NSString * alertText  = @"This will clear your drawing. Are you sure you want to do this?";

    UIAlertView *alert = [[UIAlertView alloc]
                            initWithTitle: alertTitle
                            message: alertText
                            delegate: self
                            cancelButtonTitle:@"Yes"
                            otherButtonTitles:@"No",nil];
    [alert show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //NSLog(@"user pressed OK");
        self.drawnLayer.image = nil; // erase the entire image!
    }
}



@end
