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

@interface ViewController : UIViewController <SettingsViewControllerDelegate> 
    
@property (weak, nonatomic) IBOutlet UIImageView *drawnLayer;
@property (weak, nonatomic) IBOutlet UIImageView *drawingLayer;
- (IBAction)colorPressed:(id)sender;
- (IBAction)eraserPressed:(id)sender;
- (IBAction)settingsButton:(id)sender;
    


@end
