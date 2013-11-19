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
@end
