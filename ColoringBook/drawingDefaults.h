//
//  drawingDefaults.h
//  ColoringBook
//
//  Created by Casey Blamires on 10/22/13.
//  Copyright (c) 2013 LCSC-CS360. All rights reserved.
//

#ifndef ColoringBook_drawingDefaults_h
#define ColoringBook_drawingDefaults_h

CGPoint lastPoint;  // store the last point drawn on the canvas

CGFloat red         = 24/255.0;        // this and below are for RGB values
CGFloat green       = 24/255.0;
CGFloat blue        = 24/255.0;
CGFloat brushSize   = 25;      // brush stroke
CGFloat opacity     = 1.0;    // brush width

const float MAX_COLOR_VALUE = 255.0;

BOOL mouseSwiped;   // identify if the brush stroke is continuous



// setColor
// sets the CGFloat rgb values
// params - integer values for red, green, and blue
void setColor ( int r, int g, int b )
{
    if ( r >= 0 && r <= 255 )
        red = r/MAX_COLOR_VALUE;
    if ( g >= 0 && g <= 255 )
        green = g/MAX_COLOR_VALUE;
    if ( b >= 0 && b <= 255 )
        blue = b/MAX_COLOR_VALUE;
}

#endif
