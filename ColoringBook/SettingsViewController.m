//
//  SettingsViewController.m
//  ColoringBook
//
//  Created by Casey Blamires on 10/25/13.
//  Copyright (c) 2013 LCSC-CS360. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()




@end

@implementation SettingsViewController


// synthetic!
@synthesize brush;
@synthesize opacity;
@synthesize delegate;




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
	// Do any additional setup after loading the view.
    
    self.brushControl.value = self.brush;
    self.opacityControl.value = self.opacity;
    NSLog(@"%.3f",self.opacity);
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
        NSLog(@"Opacity Slider was changed");
    }
    
}
@end
