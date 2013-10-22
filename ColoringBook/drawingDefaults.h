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

BOOL mouseSwiped;   // identify if the brush stroke is continuous

#endif
