//
//  SettingsViewController.m
//  ColoringBook
//
//  Created by Casey Blamires on 10/25/13.
//  Copyright (c) 2013 LCSC-CS360. All rights reserved.
//

#import "SettingsViewController.h"


// define a MACRO
#define FONT_ANGELINA(s) [UIFont fontWithName:@"Angelina" size:s]

@interface SettingsViewController ()




@end

@implementation SettingsViewController


// synthetic!
@synthesize brush;
@synthesize opacity;
@synthesize delegate;
@synthesize brushLabel;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //brushLabel.font= FONT_ANGELINA(30);
    
    self.brushControl.value = self.brush;
    self.opacityControl.value = self.opacity;
    self.bgMusicVolume = self.backgroundMusic.volume;
    if ( self.backgroundMusic.volume == 0 )
    {
        [self.musicOnOffSwitch setOn:NO];
    }
    else
    {
        [self.musicOnOffSwitch setOn:YES];
    }
    //NSLog(@"%.3f",self.opacity);
    [self sliderChanged:self.brushControl];
    [self sliderChanged:self.opacityControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// close the settings View
- (IBAction)closeSettings:(id)sender {
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate closeSettings:self];
}


- (IBAction)sliderChanged:(id)sender {
    UISlider * changedSlider = (UISlider*)sender;
    
    if(changedSlider == self.brushControl) {
        
        self.brush = self.brushControl.value;
        self.brushValueLabel.text = [NSString stringWithFormat:@"Size: %.0f", round(self.brush)];
        
        UIGraphicsBeginImageContext(self.brushPreview.frame.size);
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue , self.opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(),45, 45);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),45, 45);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        self.brushPreview.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    else if(changedSlider == self.opacityControl) {
        
        self.opacity = self.opacityControl.value;
        self.opacityValueLabel.text = [NSString stringWithFormat:@"Opacity: %.0f %%", round(self.opacity*100)];
        
        
        UIGraphicsBeginImageContext(self.brushPreview.frame.size);
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue , self.opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(),45, 45);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),45, 45);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        self.brushPreview.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //NSLog(@"Opacity Slider was changed");
    }
    
}

// When the switch is "switched", change the volume of the music.
// If the switch is set to OFF, turn the volume down to zero
// If the switch is set to ON, then turn the volume back up to 0.2 (20%)
// volume is this low because we don't want to drown out the volume of the color sounds
- (IBAction)musicSwitch:(id)sender {
    // get the switch's information from the sender
    UISwitch * theSwitch = (UISwitch *)sender;
    
    // test to see if the switch is on or off
    if ( theSwitch.on )
    {
        //NSLog(@"Switch is on");
        self.backgroundMusic.volume = 0.2;
        self.bgMusicVolume = 0.2;
    }
    else
    {
        //NSLog(@"Switch is off");
        self.backgroundMusic.volume = 0.0;
        self.bgMusicVolume = 0.0;
    }
}


// change the drawing page (this method also closes the settings view)
- (IBAction)changePage:(id)sender {
    
    UIButton * pageSelected = (UIButton *) sender;
    if ( pageSelected.tag  == 0 )
    {
        UIImage * img = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"Bunney" ofType:@"png"]];
        [self.coloringBookPage setImage:img];
    }
    else if ( pageSelected.tag == 1 )
    {
        UIImage * img = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"teddybearlineart" ofType:@"png"]];
        [self.coloringBookPage setImage:img];
    }
    // puppy pizza burger nil
    else if ( pageSelected.tag == 2 )
    {
        UIImage * img = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"puppy" ofType:@"png"]];
        [self.coloringBookPage setImage:img];
    }
    else if ( pageSelected.tag == 3 )
    {
        UIImage * img = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"pizzalineart" ofType:@"png"]];
        [self.coloringBookPage setImage:img];
    }
    else if ( pageSelected.tag == 4 )
    {
        UIImage * img = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"burgerlineart" ofType:@"png"]];
        [self.coloringBookPage setImage:img];

    }
    else if ( pageSelected.tag == 5 )
    {
        self.coloringBookPage.image = nil;
    }
    // and now close the screen!
    [self closeSettings:0];
}

- (IBAction)aboutThisApp:(id)sender {
    
    NSString * alertTitle = @"About This App";
    NSString * alertText  = @"Color Time Drawing App by Katy Phipps and Casey Blamires. Made for CS 360 at LCSC.";
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: alertTitle
                          message: alertText
                          delegate: self
                          cancelButtonTitle:@"OK!"
                          otherButtonTitles:nil];
    [alert show];
    
}

- (IBAction)easterEgg:(id)sender {
    NSLog(@"secret easter egg");
    
    _bgMusicVolume = 0.2;
    
    _resourcePath = [[NSBundle mainBundle] resourcePath];
    _resourcePath = [_resourcePath stringByAppendingString:@"/clapping.wav"];
    NSError * err;
    _applauseMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:_resourcePath] error:&err];
    if ( err )
    {
        NSLog(@"Music player did not load correctly");
    }
    else{
        _applauseMusic.delegate = self;
        _applauseMusic.volume = _bgMusicVolume; //-- make sure that volume is low enough to not cover up the sound effects
        [_applauseMusic play];
        UIImage * img = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"Ninjacat" ofType:@"png"]];
        [self.coloringBookPage setImage:img];
        [self closeSettings:0];
    }
}




@end
