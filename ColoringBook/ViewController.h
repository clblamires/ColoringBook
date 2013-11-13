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

#import "SettingsViewController.h"

@interface ViewController : UIViewController <SettingsViewControllerDelegate> {
    IBOutlet UIImageView *imagepost;
}
    
@property (weak, nonatomic) IBOutlet UIImageView *drawnLayer;
@property (weak, nonatomic) IBOutlet UIImageView *drawingLayer;
@property (weak, nonatomic) IBOutlet UIImageView *shareLayer;
@property (weak, nonatomic) IBOutlet UIImageView *coloringBookPage;



//@property (strong, nonatomic) UIImageView *postImage;
@property (strong, nonatomic) UILabel *postText;


- (IBAction)colorPressed:(id)sender;
- (IBAction)eraserPressed:(id)sender;
- (IBAction)settingsButton:(id)sender;
- (IBAction)sharePressed:(id)sender;
- (IBAction)clearAllButton:(id)sender;
    


@end
