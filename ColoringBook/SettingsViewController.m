//
//  SettingsViewController.m
//  ColoringBook
//
//  Created by Casey Blamires and Katy Phipps on 10/25/13.
//  Copyright (c) 2013 LCSC-CS360. All rights reserved.
//

#import "SettingsViewController.h"


/*
 The Settings View Controller is the brains for the Settings View on the storyboards
 When the user taps on the settings button, the ViewController.m calls its PrepareForSegue method
 and passes all necessary variables/information to the Settings View Controller.
 
 In the Settings View, the user can change the brush size and opacity, turn on or off the background
 music, and change coloring book pages.
 */

@interface SettingsViewController ()
@end


// Implementation for the Settings View Controller. Here we go!
@implementation SettingsViewController


// synthetic! (making a getter and a setter for each property below)
@synthesize brush;
@synthesize opacity;
@synthesize delegate;
//@synthesize brushLabel;




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

    // Save the values of the properties
    self.brushControl.value = self.brush;
    self.opacityControl.value = self.opacity;
    self.bgMusicVolume = self.backgroundMusic.volume;
    
    // if the music is off (or rather, its volume is zero)...
    if ( self.backgroundMusic.volume == 0 )
    {
        // ... make sure the music switch is off
        [self.musicOnOffSwitch setOn:NO];
    }
    else
    {
        // ... make sure the switch is on
        [self.musicOnOffSwitch setOn:YES];
    }
    // change the sliders according to what the current values are (passed into this view controller
    // from the ViewController)
    [self sliderChanged:self.brushControl];
    [self sliderChanged:self.opacityControl];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





// close the settings View controller
- (IBAction)closeSettings:(id)sender {
    [self.delegate closeSettings:self];
    // to be perfectly honest I don't quite understand how this one works other
    // than this is what the interwebs told me to do to get this done
    // ~ Casey
}



// sliderChanged
// controls what happens when the user moves any of the slider bars
- (IBAction)sliderChanged:(id)sender {
    
    // get the slider that the user is currently changing
    UISlider * changedSlider = (UISlider*)sender;
    
    // if the currently changed slider matches the brush control slider...
    if(changedSlider == self.brushControl) {
        
        self.brush = self.brushControl.value;
        //self.brushValueLabel.text = [NSString stringWithFormat:@"Size: %.0f", round(self.brush)];
        // Note, the above line is no longer even being used.
        
        // start the graphic context to draw the brush preview
        UIGraphicsBeginImageContext(self.brushPreview.frame.size);
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue , self.opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(),45, 45);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),45, 45);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        
        // now set the preview image
        self.brushPreview.image = UIGraphicsGetImageFromCurrentImageContext();
        // and we're done!
        UIGraphicsEndImageContext();
    }
    
    else if(changedSlider == self.opacityControl) {
        
        self.opacity = self.opacityControl.value;
        //self.opacityValueLabel.text = [NSString stringWithFormat:@"Opacity: %.0f %%", round(self.opacity*100)];
        
        
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
    
    // get the button that was pushed. We will be changing the page according to the
    // button's tag (which will be pageSelected.tag)
    UIButton * pageSelected = (UIButton *) sender;
    
    // check to see what the pageSelected's tag is, and change the page accordingly
    if ( pageSelected.tag  == 0 )
    {
        UIImage * img = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"Bunney" ofType:@"png"]];
        [self.coloringBookPage setImage:img]; // <-- sets the image
    }
    
    else if ( pageSelected.tag == 1 )
    {
        UIImage * img = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"teddybearlineart" ofType:@"png"]];
        [self.coloringBookPage setImage:img];
    }
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
    else
    {
        NSLog(@"Something went horribly wrong.....");
    }
    
    
    
    // and now close the screen!
    [self closeSettings:0];
    // The screen is now closed so that when the user taps on a new page template, they can
    // start drawing immediately without any wait or having to close the settings view.
}


// aboutThisApp is just a method that loads a UIAlertView when called
// Does nothing more...
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


// Because all fun apps have an easter egg...
- (IBAction)easterEgg:(id)sender {
    
/*
 Robot Dog Easter Egg
             ,
      __,.._; )
 ,--``' / ,";,\
 |   __; `-'   ;
 |```          ;                          _
 '-""`!------'/                      _,-'`/
  "===`-'"|_|"                 ____,(__,-'
         (ctr`.________,,---``` ;__|
         | ,-"""""\-..._____,"""""-.
         |;;;'''':::````:::; ;'''': :
         (( .---.  ))     ( ( .---.) )
          : \    \ ;  ____ : /    / ;
           \ |````|',-"----`-|    |'
            (`----'          `----'
            /(____\          /____)
         ,-\ /   /          ,\    \
        (_ _/   /          (__\    \
         ,-\   /               ;-._ |
        (___)_/               (____\|
 */

    //NSLog(@"secret easter egg"); //-- prints to the console that the user found the easter egg!
    
    _bgMusicVolume = 0.2;
    
    // Start playing the clapping sound effect for when the user finds the easter egg
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
        [_applauseMusic play]; //-- and here we actually play the music!
        
        // change the page to the secret page (which is a ninja cat)
        UIImage * img = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"Ninjacat" ofType:@"png"]];
        [self.coloringBookPage setImage:img];
        [self closeSettings:0]; // and close the settings view controller. We're done here!
    }
}




@end
