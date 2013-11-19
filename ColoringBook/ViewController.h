//
//  ViewController.h
//  ColoringBook
//
//  Created by Casey Blamires on 10/21/13.
//  Copyright (c) 2013 LCSC-CS360. All rights reserved.
//

// blah blah blah
// Testing!

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "SettingsViewController.h"

@interface ViewController : UIViewController <SettingsViewControllerDelegate> {
    IBOutlet UIImageView *imagepost;
    
    
    
}


    
@property (weak, nonatomic) IBOutlet UIImageView *drawnLayer;
@property (weak, nonatomic) IBOutlet UIImageView *drawingLayer;
@property (weak, nonatomic) IBOutlet UIImageView *shareLayer;
@property (weak, nonatomic) IBOutlet UIImageView *coloringBookPage; //-- this is the image that the user is coloring on (or around)



//@property (strong, nonatomic) UIImageView *postImage;
@property (strong, nonatomic) UILabel *postText;

// not sure if this works or not...
@property (nonatomic) CGFloat bgMusicVolume;
@property (nonatomic) NSString * resourcePath;


@property (nonatomic) AVAudioPlayer * backgroundMusic;




- (IBAction)colorPressed:(id)sender;
- (IBAction)eraserPressed:(id)sender;
- (IBAction)settingsButton:(id)sender;
- (IBAction)sharePressed:(id)sender;
- (IBAction)clearAllButton:(id)sender;
    


@end
