
//  SettingsViewController.h
//  ColoringBook
//
//  Created by Casey Blamires on 10/25/13.
//  Copyright (c) 2013 LCSC-CS360. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@protocol SettingsViewControllerDelegate <NSObject>
- (void)closeSettings:(id)sender;
@end


@interface SettingsViewController : UIViewController
{
    
}


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
@property (weak, nonatomic) IBOutlet UILabel *brushValueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *brushPreview;
@property (weak, nonatomic) IBOutlet UILabel *opacityValueLabel;
@property (weak, nonatomic) IBOutlet UISlider *opacityControl;

@property (weak, nonatomic) IBOutlet UILabel *opacityLabel;
@property (nonatomic, retain) IBOutlet UILabel * brushLabel;

@property (weak, nonatomic) IBOutlet UISwitch * musicOnOffSwitch;





// Actions
- (IBAction)closeSettings:(id)sender;
- (IBAction)sliderChanged:(id)sender;
- (IBAction)musicSwitch:(id)sender;
- (IBAction)changePage:(id)sender;
- (IBAction)aboutThisApp:(id)sender;
- (IBAction)easterEgg:(id)sender;


@end
