//
//  Common.h
//  CoolTable
//
//  Created by Ray Wenderlich on 9/29/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//


//Clase utilitaria para pintar y realizar animaciones
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>




@interface Common : NSObject{
    
}




//=======================ANIMAR=======================

//rota una vista con un ángulo (radianes), duración y número de repeticiones dado.
+(void) makeRotationToView: (UIView*)aView withAngle:(CGFloat)angle withDuration:(CGFloat) duration withRepeatCount:(float) aRepeatCount delegate:(id) aDelegate;
+(void) makeTranslationToView:(UIView*) aView WithX:(CGFloat) x withY:(CGFloat) y withZ:(CGFloat) z withDuration:(CGFloat) duration delegate:(id) aDelegate;

@end


//=======================PINTAR=======================
//Pinta un gradiente lineal dado un contexto.
void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef  endColor);

//Modifica un cgrect desplazando su borde (stroke) 0.5px hacia dentro, para corregir problemas con antiliasing y bordes.
CGRect rectFor1PxStroke(CGRect rect);

//Pinta un rectángulo con un borde (stroke) de 1px de grosor, usar primero rectFor1PxStroke para que pinte bien el borde. 
void draw1PxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color);

//Pinta un rectángulo con un gradiente lineal y aplica efecto gloss.
void drawGlossAndGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor);

//Esta se explica sola ;)
static inline double radians (double degrees) { return degrees * M_PI/180; }


//Crea un Path reusable con un arco para un rectángulo dado. 
CGMutablePathRef createArcPathFromBottomOfRect(CGRect rect, CGFloat arcHeight);


// Crea un Path reusable con un Rounded Rectangle dado un radio. Cuanto mayor sea el radio, más amplio será el arco dibujado en las esquinas.

CGMutablePathRef createRoundedRectForRect(CGRect rect, CGFloat radius);





