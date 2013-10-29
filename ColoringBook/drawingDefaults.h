//
//  drawingDefaults.h
//  ColoringBook
//
//  Created by Casey Blamires on 10/22/13.
//  Copyright (c) 2013 LCSC-CS360. All rights reserved.
//

#ifndef ColoringBook_drawingDefaults_h
#define ColoringBook_drawingDefaults_h



// the maximum value a color can have is 255, and the minimum is 0
// so no rgb color should fall outside this range
const float MAX_COLOR_VALUE = 255.0;
const float MIN_COLOR_VALUE = 0;


// drawing controls
CGPoint lastPoint;                  // store the last point drawn on the canvas
BOOL mouseSwiped;                   // identify if the brush stroke is continuous
BOOL eraserIsActive = NO;           // whether the eraser is being used
BOOL stopDrawing = NO;

// brush and eraser settings

CGFloat red             = 24/MAX_COLOR_VALUE;           // this and below are for RGB values
CGFloat green           = 24/MAX_COLOR_VALUE;
CGFloat blue            = 24/MAX_COLOR_VALUE;

CGFloat brushSize       = 25;                           // default brush stroke
CGFloat eraserSize      = 40;                           // default eraser stroke
CGFloat opacity         = 1.0;                          // default brush opacity
CGFloat opacityBackup   = 1.0;








// C-style function
// setColor
// sets the CGFloat rgb values
// params - integer values for red, green, and blue
void setColor ( int r, int g, int b )
{
    if ( r >= MIN_COLOR_VALUE && r <= MAX_COLOR_VALUE )
        red = r/MAX_COLOR_VALUE;
    
    
    if ( g >= MIN_COLOR_VALUE && g <= MAX_COLOR_VALUE )
        green = g/MAX_COLOR_VALUE;
    
    
    if ( b >= MIN_COLOR_VALUE && b <= MAX_COLOR_VALUE )
        blue = b/MAX_COLOR_VALUE;
    
    
} //-- end of setColor function



#endif
