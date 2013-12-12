
//  SettingsViewController.h
//  ColoringBook
//
//  Created by Casey Blamires and Katy Phipps on 10/25/13.
//  Copyright (c) 2013 LCSC-CS360. All rights reserved.
//


/*
 The Settings View Controller is the brains for the Settings View on the storyboards
 When the user taps on the settings button, the ViewController.m calls its PrepareForSegue method
 and passes all necessary variables/information to the Settings View Controller.
 
 In the Settings View, the user can change the brush size and opacity, turn on or off the background
 music, and change coloring book pages.
 */


// necessary imports

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


// A protocol is a method that is expected to be used for a particular situation.
// In this case, when the settings view controller is closed (this is accomplished by means of the closeSettings method),
// then the delegate for this view controller is shut.
@protocol SettingsViewControllerDelegate <NSObject>
- (void)closeSettings:(id)sender;
@end


@interface SettingsViewController : UIViewController
{}


// delegate property
@property (nonatomic, weak) id<SettingsViewControllerDelegate> delegate;
// leave this guy alone!



// properties for the brush size and color
@property CGFloat brush;
@property CGFloat opacity;
@property CGFloat red;
@property CGFloat green;
@property CGFloat blue;
@property AVAudioPlayer * backgroundMusic;
@property CGFloat bgMusicVolume;
@property UIImageView * coloringBookPage;


// applause for the easter egg
@property (nonatomic) NSString * resourcePath;
@property (nonatomic) AVAudioPlayer * applauseMusic;


// for the sliders, the labels, and the brush previews
@property (weak, nonatomic) IBOutlet UISlider *brushControl;
@property (weak, nonatomic) IBOutlet UIImageView *brushPreview;
@property (weak, nonatomic) IBOutlet UISlider *opacityControl;
@property (weak, nonatomic) IBOutlet UISwitch * musicOnOffSwitch;





// Actions
- (IBAction)closeSettings:(id)sender;
- (IBAction)sliderChanged:(id)sender;
- (IBAction)musicSwitch:(id)sender;
- (IBAction)changePage:(id)sender;
- (IBAction)aboutThisApp:(id)sender;
- (IBAction)easterEgg:(id)sender;


@end
