//
//  ViewController.h
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


// get imported files that are necessary
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SettingsViewController.h"

@interface ViewController : UIViewController <SettingsViewControllerDelegate>
{
    IBOutlet UIImageView *imagepost;
}


// properties that are used for the images (we refer to them here as layers, like layers in Photoshop)
@property (weak, nonatomic) IBOutlet UIImageView *drawnLayer;
@property (weak, nonatomic) IBOutlet UIImageView *drawingLayer;
@property (weak, nonatomic) IBOutlet UIImageView *shareLayer;
@property (weak, nonatomic) IBOutlet UIImageView *coloringBookPage; //-- this is the image that the user is coloring on (or around)



//@property (strong, nonatomic) UIImageView *postImage;
@property (strong, nonatomic) UILabel *postText;

// not sure if this works or not...
@property (nonatomic) CGFloat bgMusicVolume;
@property (nonatomic) NSString * resourcePath;
// actually, it totally does - Casey


@property (nonatomic) AVAudioPlayer * backgroundMusic;



// actions for when the user interacts with the screen (buttons, specifically, and not drawing on the storyboard)
- (IBAction)colorPressed:(id)sender;
- (IBAction)eraserPressed:(id)sender;
- (IBAction)settingsButton:(id)sender;
- (IBAction)sharePressed:(id)sender;
- (IBAction)clearAllButton:(id)sender;
    


@end
