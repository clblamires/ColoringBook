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
#import "drawingDefaults.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *drawnLayer;
@property (weak, nonatomic) IBOutlet UIImageView *drawingLayer;
- (IBAction)colorPressed:(id)sender;

@end
