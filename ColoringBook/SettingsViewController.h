
//  SettingsViewController.h
//  ColoringBook
//
//  Created by Casey Blamires on 10/25/13.
//  Copyright (c) 2013 LCSC-CS360. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsViewControllerDelegate <NSObject>
- (void)closeSettings:(id)sender;
@end


@interface SettingsViewController : UIViewController


// delegate property
@property (nonatomic, weak) id<SettingsViewControllerDelegate> delegate;
// leave this guy alone!



// properties for the brush size and color
@property CGFloat brush;
@property CGFloat opacity;
@property CGFloat red;
@property CGFloat green;
@property CGFloat blue;


// for the sliders, the labels, and the brush previews
@property (weak, nonatomic) IBOutlet UISlider *brushControl;
@property (weak, nonatomic) IBOutlet UILabel *brushValueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *brushPreview;
@property (weak, nonatomic) IBOutlet UILabel *opacityValueLabel;
@property (weak, nonatomic) IBOutlet UISlider *opacityControl;



// Actions
- (IBAction)closeSettings:(id)sender;
- (IBAction)sliderChanged:(id)sender;

@end
