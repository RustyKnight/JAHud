//
//  JAHubStyleKit.swift
//  JAHub
//
//  Created by Shane Whitehead on 7/9/18.
//  Copyright © 2018 KaiZen Enterprises. All rights reserved.
//
//  Generated by PaintCode
//  http://www.paintcodeapp.com
//



import UIKit

public class JAHubStyleKit : NSObject {

    //// Drawing Methods

    @objc dynamic public class func drawActivityIndicator(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 108, height: 108), resizing: ResizingBehavior = .aspectFit, fillColor: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000), rotationProgress: CGFloat = 0) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 108, height: 108), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 108, y: resizedFrame.height / 108)


        //// Color Declarations
        var fillColorRedComponent: CGFloat = 1
        var fillColorGreenComponent: CGFloat = 1
        var fillColorBlueComponent: CGFloat = 1
        fillColor.getRed(&fillColorRedComponent, green: &fillColorGreenComponent, blue: &fillColorBlueComponent, alpha: nil)

        let darker01 = UIColor(red: (fillColorRedComponent * 0.83), green: (fillColorGreenComponent * 0.83), blue: (fillColorBlueComponent * 0.83), alpha: (fillColor.cgColor.alpha * 0.83 + 0.17))
        let darkerAlpha01 = darker01.withAlphaComponent(0.83)
        let dark02 = UIColor(red: (fillColorRedComponent * 0.67), green: (fillColorGreenComponent * 0.67), blue: (fillColorBlueComponent * 0.67), alpha: (fillColor.cgColor.alpha * 0.67 + 0.33))
        let darkerAlpha02 = dark02.withAlphaComponent(0.67)
        let dark03 = UIColor(red: (fillColorRedComponent * 0.5), green: (fillColorGreenComponent * 0.5), blue: (fillColorBlueComponent * 0.5), alpha: (fillColor.cgColor.alpha * 0.5 + 0.5))
        let darkAlpha03 = dark03.withAlphaComponent(0.5)

        //// Variable Declarations
        let rotationAngle: CGFloat = 360.0 / 12.0 * round(12 * -rotationProgress)

        //// SpinningBladesOfDoom
        context.saveGState()
        context.translateBy(x: 54, y: 54)
        context.rotate(by: -rotationAngle * CGFloat.pi/180)



        //// Blade01 Drawing
        let blade01Path = UIBezierPath()
        blade01Path.move(to: CGPoint(x: 0, y: -52))
        blade01Path.addLine(to: CGPoint(x: 0, y: -52))
        blade01Path.addLine(to: CGPoint(x: 0, y: -52))
        blade01Path.addLine(to: CGPoint(x: 0.25, y: -52))
        blade01Path.addCurve(to: CGPoint(x: 4.63, y: -48.94), controlPoint1: CGPoint(x: 2.21, y: -52), controlPoint2: CGPoint(x: 3.96, y: -50.78))
        blade01Path.addCurve(to: CGPoint(x: 5, y: -44.45), controlPoint1: CGPoint(x: 5, y: -47.75), controlPoint2: CGPoint(x: 5, y: -46.65))
        blade01Path.addLine(to: CGPoint(x: 5, y: -31.64))
        blade01Path.addCurve(to: CGPoint(x: 4.67, y: -27.26), controlPoint1: CGPoint(x: 5, y: -29.35), controlPoint2: CGPoint(x: 5, y: -28.25))
        blade01Path.addLine(to: CGPoint(x: 4.63, y: -27.06))
        blade01Path.addCurve(to: CGPoint(x: 0.25, y: -24), controlPoint1: CGPoint(x: 3.96, y: -25.22), controlPoint2: CGPoint(x: 2.21, y: -24))
        blade01Path.addCurve(to: CGPoint(x: 0, y: -24), controlPoint1: CGPoint(x: 0, y: -24), controlPoint2: CGPoint(x: 0, y: -24))
        blade01Path.addLine(to: CGPoint(x: 0, y: -24))
        blade01Path.addLine(to: CGPoint(x: 0, y: -24))
        blade01Path.addLine(to: CGPoint(x: -0.25, y: -24))
        blade01Path.addCurve(to: CGPoint(x: -4.63, y: -27.06), controlPoint1: CGPoint(x: -2.21, y: -24), controlPoint2: CGPoint(x: -3.96, y: -25.22))
        blade01Path.addCurve(to: CGPoint(x: -5, y: -31.55), controlPoint1: CGPoint(x: -5, y: -28.25), controlPoint2: CGPoint(x: -5, y: -29.35))
        blade01Path.addLine(to: CGPoint(x: -5, y: -31.64))
        blade01Path.addCurve(to: CGPoint(x: -4.67, y: -48.74), controlPoint1: CGPoint(x: -5, y: -46.65), controlPoint2: CGPoint(x: -5, y: -47.75))
        blade01Path.addLine(to: CGPoint(x: -4.63, y: -48.94))
        blade01Path.addCurve(to: CGPoint(x: -0.25, y: -52), controlPoint1: CGPoint(x: -3.96, y: -50.78), controlPoint2: CGPoint(x: -2.21, y: -52))
        blade01Path.addCurve(to: CGPoint(x: 0, y: -52), controlPoint1: CGPoint(x: 0, y: -52), controlPoint2: CGPoint(x: 0, y: -52))
        blade01Path.addLine(to: CGPoint(x: 0, y: -52))
        blade01Path.close()
        fillColor.setFill()
        blade01Path.fill()


        //// Blade02 Drawing
        let blade02Path = UIBezierPath()
        blade02Path.move(to: CGPoint(x: -52, y: 0))
        blade02Path.addLine(to: CGPoint(x: -52, y: 0))
        blade02Path.addLine(to: CGPoint(x: -52, y: 0))
        blade02Path.addLine(to: CGPoint(x: -52, y: -0.25))
        blade02Path.addCurve(to: CGPoint(x: -48.94, y: -4.63), controlPoint1: CGPoint(x: -52, y: -2.21), controlPoint2: CGPoint(x: -50.78, y: -3.96))
        blade02Path.addCurve(to: CGPoint(x: -44.45, y: -5), controlPoint1: CGPoint(x: -47.75, y: -5), controlPoint2: CGPoint(x: -46.65, y: -5))
        blade02Path.addLine(to: CGPoint(x: -31.64, y: -5))
        blade02Path.addCurve(to: CGPoint(x: -27.26, y: -4.67), controlPoint1: CGPoint(x: -29.35, y: -5), controlPoint2: CGPoint(x: -28.25, y: -5))
        blade02Path.addLine(to: CGPoint(x: -27.06, y: -4.63))
        blade02Path.addCurve(to: CGPoint(x: -24, y: -0.25), controlPoint1: CGPoint(x: -25.22, y: -3.96), controlPoint2: CGPoint(x: -24, y: -2.21))
        blade02Path.addCurve(to: CGPoint(x: -24, y: 0), controlPoint1: CGPoint(x: -24, y: -0), controlPoint2: CGPoint(x: -24, y: 0))
        blade02Path.addLine(to: CGPoint(x: -24, y: 0))
        blade02Path.addLine(to: CGPoint(x: -24, y: 0))
        blade02Path.addLine(to: CGPoint(x: -24, y: 0.25))
        blade02Path.addCurve(to: CGPoint(x: -27.06, y: 4.63), controlPoint1: CGPoint(x: -24, y: 2.21), controlPoint2: CGPoint(x: -25.22, y: 3.96))
        blade02Path.addCurve(to: CGPoint(x: -31.55, y: 5), controlPoint1: CGPoint(x: -28.25, y: 5), controlPoint2: CGPoint(x: -29.35, y: 5))
        blade02Path.addLine(to: CGPoint(x: -31.64, y: 5))
        blade02Path.addCurve(to: CGPoint(x: -48.74, y: 4.67), controlPoint1: CGPoint(x: -46.65, y: 5), controlPoint2: CGPoint(x: -47.75, y: 5))
        blade02Path.addLine(to: CGPoint(x: -48.94, y: 4.63))
        blade02Path.addCurve(to: CGPoint(x: -52, y: 0.25), controlPoint1: CGPoint(x: -50.78, y: 3.96), controlPoint2: CGPoint(x: -52, y: 2.21))
        blade02Path.addCurve(to: CGPoint(x: -52, y: 0), controlPoint1: CGPoint(x: -52, y: 0), controlPoint2: CGPoint(x: -52, y: 0))
        blade02Path.addLine(to: CGPoint(x: -52, y: 0))
        blade02Path.close()
        darkAlpha03.setFill()
        blade02Path.fill()


        //// Blade03 Drawing
        let blade03Path = UIBezierPath()
        blade03Path.move(to: CGPoint(x: -26, y: -45.03))
        blade03Path.addLine(to: CGPoint(x: -26, y: -45.03))
        blade03Path.addLine(to: CGPoint(x: -26, y: -45.03))
        blade03Path.addLine(to: CGPoint(x: -25.78, y: -45.16))
        blade03Path.addCurve(to: CGPoint(x: -20.46, y: -44.69), controlPoint1: CGPoint(x: -24.09, y: -46.14), controlPoint2: CGPoint(x: -21.96, y: -45.95))
        blade03Path.addCurve(to: CGPoint(x: -17.9, y: -41), controlPoint1: CGPoint(x: -19.55, y: -43.85), controlPoint2: CGPoint(x: -19, y: -42.9))
        blade03Path.addLine(to: CGPoint(x: -11.49, y: -29.9))
        blade03Path.addCurve(to: CGPoint(x: -9.58, y: -25.94), controlPoint1: CGPoint(x: -10.34, y: -27.92), controlPoint2: CGPoint(x: -9.79, y: -26.96))
        blade03Path.addLine(to: CGPoint(x: -9.53, y: -25.75))
        blade03Path.addCurve(to: CGPoint(x: -11.78, y: -20.91), controlPoint1: CGPoint(x: -9.19, y: -23.82), controlPoint2: CGPoint(x: -10.09, y: -21.89))
        blade03Path.addCurve(to: CGPoint(x: -12, y: -20.78), controlPoint1: CGPoint(x: -12, y: -20.78), controlPoint2: CGPoint(x: -12, y: -20.78))
        blade03Path.addLine(to: CGPoint(x: -12, y: -20.78))
        blade03Path.addLine(to: CGPoint(x: -12, y: -20.78))
        blade03Path.addLine(to: CGPoint(x: -12.22, y: -20.66))
        blade03Path.addCurve(to: CGPoint(x: -17.54, y: -21.13), controlPoint1: CGPoint(x: -13.91, y: -19.68), controlPoint2: CGPoint(x: -16.04, y: -19.87))
        blade03Path.addCurve(to: CGPoint(x: -20.1, y: -24.82), controlPoint1: CGPoint(x: -18.45, y: -21.96), controlPoint2: CGPoint(x: -19, y: -22.92))
        blade03Path.addLine(to: CGPoint(x: -20.15, y: -24.9))
        blade03Path.addCurve(to: CGPoint(x: -28.42, y: -39.88), controlPoint1: CGPoint(x: -27.66, y: -37.9), controlPoint2: CGPoint(x: -28.21, y: -38.85))
        blade03Path.addLine(to: CGPoint(x: -28.47, y: -40.07))
        blade03Path.addCurve(to: CGPoint(x: -26.22, y: -44.91), controlPoint1: CGPoint(x: -28.81, y: -42), controlPoint2: CGPoint(x: -27.91, y: -43.93))
        blade03Path.addCurve(to: CGPoint(x: -26, y: -45.03), controlPoint1: CGPoint(x: -26, y: -45.03), controlPoint2: CGPoint(x: -26, y: -45.03))
        blade03Path.addLine(to: CGPoint(x: -26, y: -45.03))
        blade03Path.close()
        darkerAlpha01.setFill()
        blade03Path.fill()


        //// Blade04 Drawing
        let blade04Path = UIBezierPath()
        blade04Path.move(to: CGPoint(x: -45.03, y: -26))
        blade04Path.addLine(to: CGPoint(x: -45.03, y: -26))
        blade04Path.addLine(to: CGPoint(x: -45.03, y: -26))
        blade04Path.addLine(to: CGPoint(x: -44.91, y: -26.22))
        blade04Path.addCurve(to: CGPoint(x: -40.07, y: -28.47), controlPoint1: CGPoint(x: -43.93, y: -27.91), controlPoint2: CGPoint(x: -42, y: -28.81))
        blade04Path.addCurve(to: CGPoint(x: -36, y: -26.56), controlPoint1: CGPoint(x: -38.85, y: -28.21), controlPoint2: CGPoint(x: -37.9, y: -27.66))
        blade04Path.addLine(to: CGPoint(x: -24.9, y: -20.15))
        blade04Path.addCurve(to: CGPoint(x: -21.27, y: -17.67), controlPoint1: CGPoint(x: -22.92, y: -19), controlPoint2: CGPoint(x: -21.96, y: -18.45))
        blade04Path.addLine(to: CGPoint(x: -21.13, y: -17.54))
        blade04Path.addCurve(to: CGPoint(x: -20.66, y: -12.22), controlPoint1: CGPoint(x: -19.87, y: -16.04), controlPoint2: CGPoint(x: -19.68, y: -13.91))
        blade04Path.addCurve(to: CGPoint(x: -20.78, y: -12), controlPoint1: CGPoint(x: -20.78, y: -12), controlPoint2: CGPoint(x: -20.78, y: -12))
        blade04Path.addLine(to: CGPoint(x: -20.78, y: -12))
        blade04Path.addLine(to: CGPoint(x: -20.78, y: -12))
        blade04Path.addLine(to: CGPoint(x: -20.91, y: -11.78))
        blade04Path.addCurve(to: CGPoint(x: -25.75, y: -9.53), controlPoint1: CGPoint(x: -21.89, y: -10.09), controlPoint2: CGPoint(x: -23.82, y: -9.19))
        blade04Path.addCurve(to: CGPoint(x: -29.82, y: -11.44), controlPoint1: CGPoint(x: -26.96, y: -9.79), controlPoint2: CGPoint(x: -27.92, y: -10.34))
        blade04Path.addLine(to: CGPoint(x: -29.9, y: -11.49))
        blade04Path.addCurve(to: CGPoint(x: -44.55, y: -20.33), controlPoint1: CGPoint(x: -42.9, y: -19), controlPoint2: CGPoint(x: -43.85, y: -19.55))
        blade04Path.addLine(to: CGPoint(x: -44.69, y: -20.46))
        blade04Path.addCurve(to: CGPoint(x: -45.16, y: -25.78), controlPoint1: CGPoint(x: -45.95, y: -21.96), controlPoint2: CGPoint(x: -46.14, y: -24.09))
        blade04Path.addCurve(to: CGPoint(x: -45.03, y: -26), controlPoint1: CGPoint(x: -45.03, y: -26), controlPoint2: CGPoint(x: -45.03, y: -26))
        blade04Path.addLine(to: CGPoint(x: -45.03, y: -26))
        blade04Path.close()
        darkerAlpha02.setFill()
        blade04Path.fill()


        //// Blade05 Drawing
        let blade05Path = UIBezierPath()
        blade05Path.move(to: CGPoint(x: -45.03, y: 26))
        blade05Path.addLine(to: CGPoint(x: -45.03, y: 26))
        blade05Path.addLine(to: CGPoint(x: -45.03, y: 26))
        blade05Path.addLine(to: CGPoint(x: -45.16, y: 25.78))
        blade05Path.addCurve(to: CGPoint(x: -44.69, y: 20.46), controlPoint1: CGPoint(x: -46.14, y: 24.09), controlPoint2: CGPoint(x: -45.95, y: 21.96))
        blade05Path.addCurve(to: CGPoint(x: -41, y: 17.9), controlPoint1: CGPoint(x: -43.85, y: 19.55), controlPoint2: CGPoint(x: -42.9, y: 19))
        blade05Path.addLine(to: CGPoint(x: -29.9, y: 11.49))
        blade05Path.addCurve(to: CGPoint(x: -25.94, y: 9.58), controlPoint1: CGPoint(x: -27.92, y: 10.34), controlPoint2: CGPoint(x: -26.96, y: 9.79))
        blade05Path.addLine(to: CGPoint(x: -25.75, y: 9.53))
        blade05Path.addCurve(to: CGPoint(x: -20.91, y: 11.78), controlPoint1: CGPoint(x: -23.82, y: 9.19), controlPoint2: CGPoint(x: -21.89, y: 10.09))
        blade05Path.addCurve(to: CGPoint(x: -20.78, y: 12), controlPoint1: CGPoint(x: -20.78, y: 12), controlPoint2: CGPoint(x: -20.78, y: 12))
        blade05Path.addLine(to: CGPoint(x: -20.78, y: 12))
        blade05Path.addLine(to: CGPoint(x: -20.78, y: 12))
        blade05Path.addLine(to: CGPoint(x: -20.66, y: 12.22))
        blade05Path.addCurve(to: CGPoint(x: -21.13, y: 17.54), controlPoint1: CGPoint(x: -19.68, y: 13.91), controlPoint2: CGPoint(x: -19.87, y: 16.04))
        blade05Path.addCurve(to: CGPoint(x: -24.82, y: 20.1), controlPoint1: CGPoint(x: -21.96, y: 18.45), controlPoint2: CGPoint(x: -22.92, y: 19))
        blade05Path.addLine(to: CGPoint(x: -24.9, y: 20.15))
        blade05Path.addCurve(to: CGPoint(x: -39.88, y: 28.42), controlPoint1: CGPoint(x: -37.9, y: 27.66), controlPoint2: CGPoint(x: -38.85, y: 28.21))
        blade05Path.addLine(to: CGPoint(x: -40.07, y: 28.47))
        blade05Path.addCurve(to: CGPoint(x: -44.91, y: 26.22), controlPoint1: CGPoint(x: -42, y: 28.81), controlPoint2: CGPoint(x: -43.93, y: 27.91))
        blade05Path.addCurve(to: CGPoint(x: -45.03, y: 26), controlPoint1: CGPoint(x: -45.03, y: 26), controlPoint2: CGPoint(x: -45.03, y: 26))
        blade05Path.addLine(to: CGPoint(x: -45.03, y: 26))
        blade05Path.close()
        darkAlpha03.setFill()
        blade05Path.fill()


        //// Blade06 Drawing
        let blade06Path = UIBezierPath()
        blade06Path.move(to: CGPoint(x: -26, y: 45.03))
        blade06Path.addLine(to: CGPoint(x: -26, y: 45.03))
        blade06Path.addLine(to: CGPoint(x: -26, y: 45.03))
        blade06Path.addLine(to: CGPoint(x: -26.22, y: 44.91))
        blade06Path.addCurve(to: CGPoint(x: -28.47, y: 40.07), controlPoint1: CGPoint(x: -27.91, y: 43.93), controlPoint2: CGPoint(x: -28.81, y: 42))
        blade06Path.addCurve(to: CGPoint(x: -26.56, y: 36), controlPoint1: CGPoint(x: -28.21, y: 38.85), controlPoint2: CGPoint(x: -27.66, y: 37.9))
        blade06Path.addLine(to: CGPoint(x: -20.15, y: 24.9))
        blade06Path.addCurve(to: CGPoint(x: -17.67, y: 21.27), controlPoint1: CGPoint(x: -19, y: 22.92), controlPoint2: CGPoint(x: -18.45, y: 21.96))
        blade06Path.addLine(to: CGPoint(x: -17.54, y: 21.13))
        blade06Path.addCurve(to: CGPoint(x: -12.22, y: 20.66), controlPoint1: CGPoint(x: -16.04, y: 19.87), controlPoint2: CGPoint(x: -13.91, y: 19.68))
        blade06Path.addCurve(to: CGPoint(x: -12, y: 20.78), controlPoint1: CGPoint(x: -12, y: 20.78), controlPoint2: CGPoint(x: -12, y: 20.78))
        blade06Path.addLine(to: CGPoint(x: -12, y: 20.78))
        blade06Path.addLine(to: CGPoint(x: -12, y: 20.78))
        blade06Path.addLine(to: CGPoint(x: -11.78, y: 20.91))
        blade06Path.addCurve(to: CGPoint(x: -9.53, y: 25.75), controlPoint1: CGPoint(x: -10.09, y: 21.89), controlPoint2: CGPoint(x: -9.19, y: 23.82))
        blade06Path.addCurve(to: CGPoint(x: -11.44, y: 29.82), controlPoint1: CGPoint(x: -9.79, y: 26.96), controlPoint2: CGPoint(x: -10.34, y: 27.92))
        blade06Path.addLine(to: CGPoint(x: -11.49, y: 29.9))
        blade06Path.addCurve(to: CGPoint(x: -20.33, y: 44.55), controlPoint1: CGPoint(x: -19, y: 42.9), controlPoint2: CGPoint(x: -19.55, y: 43.85))
        blade06Path.addLine(to: CGPoint(x: -20.46, y: 44.69))
        blade06Path.addCurve(to: CGPoint(x: -25.78, y: 45.16), controlPoint1: CGPoint(x: -21.96, y: 45.95), controlPoint2: CGPoint(x: -24.09, y: 46.14))
        blade06Path.addCurve(to: CGPoint(x: -26, y: 45.03), controlPoint1: CGPoint(x: -26, y: 45.03), controlPoint2: CGPoint(x: -26, y: 45.03))
        blade06Path.addLine(to: CGPoint(x: -26, y: 45.03))
        blade06Path.close()
        darkAlpha03.setFill()
        blade06Path.fill()


        //// Blade07 Drawing
        let blade07Path = UIBezierPath()
        blade07Path.move(to: CGPoint(x: -0, y: 52))
        blade07Path.addLine(to: CGPoint(x: -0, y: 52))
        blade07Path.addLine(to: CGPoint(x: -0, y: 52))
        blade07Path.addLine(to: CGPoint(x: -0.25, y: 52))
        blade07Path.addCurve(to: CGPoint(x: -4.63, y: 48.94), controlPoint1: CGPoint(x: -2.21, y: 52), controlPoint2: CGPoint(x: -3.96, y: 50.78))
        blade07Path.addCurve(to: CGPoint(x: -5, y: 44.45), controlPoint1: CGPoint(x: -5, y: 47.75), controlPoint2: CGPoint(x: -5, y: 46.65))
        blade07Path.addLine(to: CGPoint(x: -5, y: 31.64))
        blade07Path.addCurve(to: CGPoint(x: -4.67, y: 27.26), controlPoint1: CGPoint(x: -5, y: 29.35), controlPoint2: CGPoint(x: -5, y: 28.25))
        blade07Path.addLine(to: CGPoint(x: -4.63, y: 27.06))
        blade07Path.addCurve(to: CGPoint(x: -0.25, y: 24), controlPoint1: CGPoint(x: -3.96, y: 25.22), controlPoint2: CGPoint(x: -2.21, y: 24))
        blade07Path.addCurve(to: CGPoint(x: 0, y: 24), controlPoint1: CGPoint(x: 0, y: 24), controlPoint2: CGPoint(x: 0, y: 24))
        blade07Path.addLine(to: CGPoint(x: 0, y: 24))
        blade07Path.addLine(to: CGPoint(x: 0, y: 24))
        blade07Path.addLine(to: CGPoint(x: 0.25, y: 24))
        blade07Path.addCurve(to: CGPoint(x: 4.63, y: 27.06), controlPoint1: CGPoint(x: 2.21, y: 24), controlPoint2: CGPoint(x: 3.96, y: 25.22))
        blade07Path.addCurve(to: CGPoint(x: 5, y: 31.55), controlPoint1: CGPoint(x: 5, y: 28.25), controlPoint2: CGPoint(x: 5, y: 29.35))
        blade07Path.addLine(to: CGPoint(x: 5, y: 31.64))
        blade07Path.addCurve(to: CGPoint(x: 4.67, y: 48.74), controlPoint1: CGPoint(x: 5, y: 46.65), controlPoint2: CGPoint(x: 5, y: 47.75))
        blade07Path.addLine(to: CGPoint(x: 4.63, y: 48.94))
        blade07Path.addCurve(to: CGPoint(x: 0.25, y: 52), controlPoint1: CGPoint(x: 3.96, y: 50.78), controlPoint2: CGPoint(x: 2.21, y: 52))
        blade07Path.addCurve(to: CGPoint(x: -0, y: 52), controlPoint1: CGPoint(x: -0, y: 52), controlPoint2: CGPoint(x: -0, y: 52))
        blade07Path.addLine(to: CGPoint(x: -0, y: 52))
        blade07Path.close()
        darkAlpha03.setFill()
        blade07Path.fill()


        //// Blade08 Drawing
        let blade08Path = UIBezierPath()
        blade08Path.move(to: CGPoint(x: 26, y: 45.03))
        blade08Path.addLine(to: CGPoint(x: 26, y: 45.03))
        blade08Path.addLine(to: CGPoint(x: 26, y: 45.03))
        blade08Path.addLine(to: CGPoint(x: 25.78, y: 45.16))
        blade08Path.addCurve(to: CGPoint(x: 20.46, y: 44.69), controlPoint1: CGPoint(x: 24.09, y: 46.14), controlPoint2: CGPoint(x: 21.96, y: 45.95))
        blade08Path.addCurve(to: CGPoint(x: 17.9, y: 41), controlPoint1: CGPoint(x: 19.55, y: 43.85), controlPoint2: CGPoint(x: 19, y: 42.9))
        blade08Path.addLine(to: CGPoint(x: 11.49, y: 29.9))
        blade08Path.addCurve(to: CGPoint(x: 9.58, y: 25.94), controlPoint1: CGPoint(x: 10.34, y: 27.92), controlPoint2: CGPoint(x: 9.79, y: 26.96))
        blade08Path.addLine(to: CGPoint(x: 9.53, y: 25.75))
        blade08Path.addCurve(to: CGPoint(x: 11.78, y: 20.91), controlPoint1: CGPoint(x: 9.19, y: 23.82), controlPoint2: CGPoint(x: 10.09, y: 21.89))
        blade08Path.addCurve(to: CGPoint(x: 12, y: 20.78), controlPoint1: CGPoint(x: 12, y: 20.78), controlPoint2: CGPoint(x: 12, y: 20.78))
        blade08Path.addLine(to: CGPoint(x: 12, y: 20.78))
        blade08Path.addLine(to: CGPoint(x: 12, y: 20.78))
        blade08Path.addLine(to: CGPoint(x: 12.22, y: 20.66))
        blade08Path.addCurve(to: CGPoint(x: 17.54, y: 21.13), controlPoint1: CGPoint(x: 13.91, y: 19.68), controlPoint2: CGPoint(x: 16.04, y: 19.87))
        blade08Path.addCurve(to: CGPoint(x: 20.1, y: 24.82), controlPoint1: CGPoint(x: 18.45, y: 21.96), controlPoint2: CGPoint(x: 19, y: 22.92))
        blade08Path.addLine(to: CGPoint(x: 20.15, y: 24.9))
        blade08Path.addCurve(to: CGPoint(x: 28.42, y: 39.88), controlPoint1: CGPoint(x: 27.66, y: 37.9), controlPoint2: CGPoint(x: 28.21, y: 38.85))
        blade08Path.addLine(to: CGPoint(x: 28.47, y: 40.07))
        blade08Path.addCurve(to: CGPoint(x: 26.22, y: 44.91), controlPoint1: CGPoint(x: 28.81, y: 42), controlPoint2: CGPoint(x: 27.91, y: 43.93))
        blade08Path.addCurve(to: CGPoint(x: 26, y: 45.03), controlPoint1: CGPoint(x: 26, y: 45.03), controlPoint2: CGPoint(x: 26, y: 45.03))
        blade08Path.addLine(to: CGPoint(x: 26, y: 45.03))
        blade08Path.close()
        darkAlpha03.setFill()
        blade08Path.fill()


        //// Blade09 Drawing
        let blade09Path = UIBezierPath()
        blade09Path.move(to: CGPoint(x: 45.03, y: 26))
        blade09Path.addLine(to: CGPoint(x: 45.03, y: 26))
        blade09Path.addLine(to: CGPoint(x: 45.03, y: 26))
        blade09Path.addLine(to: CGPoint(x: 44.91, y: 26.22))
        blade09Path.addCurve(to: CGPoint(x: 40.07, y: 28.47), controlPoint1: CGPoint(x: 43.93, y: 27.91), controlPoint2: CGPoint(x: 42, y: 28.81))
        blade09Path.addCurve(to: CGPoint(x: 36, y: 26.56), controlPoint1: CGPoint(x: 38.85, y: 28.21), controlPoint2: CGPoint(x: 37.9, y: 27.66))
        blade09Path.addLine(to: CGPoint(x: 24.9, y: 20.15))
        blade09Path.addCurve(to: CGPoint(x: 21.27, y: 17.67), controlPoint1: CGPoint(x: 22.92, y: 19), controlPoint2: CGPoint(x: 21.96, y: 18.45))
        blade09Path.addLine(to: CGPoint(x: 21.13, y: 17.54))
        blade09Path.addCurve(to: CGPoint(x: 20.66, y: 12.22), controlPoint1: CGPoint(x: 19.87, y: 16.04), controlPoint2: CGPoint(x: 19.68, y: 13.91))
        blade09Path.addCurve(to: CGPoint(x: 20.78, y: 12), controlPoint1: CGPoint(x: 20.78, y: 12), controlPoint2: CGPoint(x: 20.78, y: 12))
        blade09Path.addLine(to: CGPoint(x: 20.78, y: 12))
        blade09Path.addLine(to: CGPoint(x: 20.78, y: 12))
        blade09Path.addLine(to: CGPoint(x: 20.91, y: 11.78))
        blade09Path.addCurve(to: CGPoint(x: 25.75, y: 9.53), controlPoint1: CGPoint(x: 21.89, y: 10.09), controlPoint2: CGPoint(x: 23.82, y: 9.19))
        blade09Path.addCurve(to: CGPoint(x: 29.82, y: 11.44), controlPoint1: CGPoint(x: 26.96, y: 9.79), controlPoint2: CGPoint(x: 27.92, y: 10.34))
        blade09Path.addLine(to: CGPoint(x: 29.9, y: 11.49))
        blade09Path.addCurve(to: CGPoint(x: 44.55, y: 20.33), controlPoint1: CGPoint(x: 42.9, y: 19), controlPoint2: CGPoint(x: 43.85, y: 19.55))
        blade09Path.addLine(to: CGPoint(x: 44.69, y: 20.46))
        blade09Path.addCurve(to: CGPoint(x: 45.16, y: 25.78), controlPoint1: CGPoint(x: 45.95, y: 21.96), controlPoint2: CGPoint(x: 46.14, y: 24.09))
        blade09Path.addCurve(to: CGPoint(x: 45.03, y: 26), controlPoint1: CGPoint(x: 45.03, y: 26), controlPoint2: CGPoint(x: 45.03, y: 26))
        blade09Path.addLine(to: CGPoint(x: 45.03, y: 26))
        blade09Path.close()
        darkAlpha03.setFill()
        blade09Path.fill()


        //// Blade10 Drawing
        let blade10Path = UIBezierPath()
        blade10Path.move(to: CGPoint(x: 52, y: 0))
        blade10Path.addLine(to: CGPoint(x: 52, y: 0))
        blade10Path.addLine(to: CGPoint(x: 52, y: 0))
        blade10Path.addLine(to: CGPoint(x: 52, y: 0.25))
        blade10Path.addCurve(to: CGPoint(x: 48.94, y: 4.63), controlPoint1: CGPoint(x: 52, y: 2.21), controlPoint2: CGPoint(x: 50.78, y: 3.96))
        blade10Path.addCurve(to: CGPoint(x: 44.45, y: 5), controlPoint1: CGPoint(x: 47.75, y: 5), controlPoint2: CGPoint(x: 46.65, y: 5))
        blade10Path.addLine(to: CGPoint(x: 31.64, y: 5))
        blade10Path.addCurve(to: CGPoint(x: 27.26, y: 4.67), controlPoint1: CGPoint(x: 29.35, y: 5), controlPoint2: CGPoint(x: 28.25, y: 5))
        blade10Path.addLine(to: CGPoint(x: 27.06, y: 4.63))
        blade10Path.addCurve(to: CGPoint(x: 24, y: 0.25), controlPoint1: CGPoint(x: 25.22, y: 3.96), controlPoint2: CGPoint(x: 24, y: 2.21))
        blade10Path.addCurve(to: CGPoint(x: 24, y: 0), controlPoint1: CGPoint(x: 24, y: 0), controlPoint2: CGPoint(x: 24, y: 0))
        blade10Path.addLine(to: CGPoint(x: 24, y: 0))
        blade10Path.addLine(to: CGPoint(x: 24, y: 0))
        blade10Path.addLine(to: CGPoint(x: 24, y: -0.25))
        blade10Path.addCurve(to: CGPoint(x: 27.06, y: -4.63), controlPoint1: CGPoint(x: 24, y: -2.21), controlPoint2: CGPoint(x: 25.22, y: -3.96))
        blade10Path.addCurve(to: CGPoint(x: 31.55, y: -5), controlPoint1: CGPoint(x: 28.25, y: -5), controlPoint2: CGPoint(x: 29.35, y: -5))
        blade10Path.addLine(to: CGPoint(x: 31.64, y: -5))
        blade10Path.addCurve(to: CGPoint(x: 48.74, y: -4.67), controlPoint1: CGPoint(x: 46.65, y: -5), controlPoint2: CGPoint(x: 47.75, y: -5))
        blade10Path.addLine(to: CGPoint(x: 48.94, y: -4.63))
        blade10Path.addCurve(to: CGPoint(x: 52, y: -0.25), controlPoint1: CGPoint(x: 50.78, y: -3.96), controlPoint2: CGPoint(x: 52, y: -2.21))
        blade10Path.addCurve(to: CGPoint(x: 52, y: 0), controlPoint1: CGPoint(x: 52, y: 0), controlPoint2: CGPoint(x: 52, y: 0))
        blade10Path.addLine(to: CGPoint(x: 52, y: 0))
        blade10Path.close()
        darkAlpha03.setFill()
        blade10Path.fill()


        //// Blade11 Drawing
        let blade11Path = UIBezierPath()
        blade11Path.move(to: CGPoint(x: 45.03, y: -26))
        blade11Path.addLine(to: CGPoint(x: 45.03, y: -26))
        blade11Path.addLine(to: CGPoint(x: 45.03, y: -26))
        blade11Path.addLine(to: CGPoint(x: 45.16, y: -25.78))
        blade11Path.addCurve(to: CGPoint(x: 44.69, y: -20.46), controlPoint1: CGPoint(x: 46.14, y: -24.09), controlPoint2: CGPoint(x: 45.95, y: -21.96))
        blade11Path.addCurve(to: CGPoint(x: 41, y: -17.9), controlPoint1: CGPoint(x: 43.85, y: -19.55), controlPoint2: CGPoint(x: 42.9, y: -19))
        blade11Path.addLine(to: CGPoint(x: 29.9, y: -11.49))
        blade11Path.addCurve(to: CGPoint(x: 25.94, y: -9.58), controlPoint1: CGPoint(x: 27.92, y: -10.34), controlPoint2: CGPoint(x: 26.96, y: -9.79))
        blade11Path.addLine(to: CGPoint(x: 25.75, y: -9.53))
        blade11Path.addCurve(to: CGPoint(x: 20.91, y: -11.78), controlPoint1: CGPoint(x: 23.82, y: -9.19), controlPoint2: CGPoint(x: 21.89, y: -10.09))
        blade11Path.addCurve(to: CGPoint(x: 20.78, y: -12), controlPoint1: CGPoint(x: 20.78, y: -12), controlPoint2: CGPoint(x: 20.78, y: -12))
        blade11Path.addLine(to: CGPoint(x: 20.78, y: -12))
        blade11Path.addLine(to: CGPoint(x: 20.78, y: -12))
        blade11Path.addLine(to: CGPoint(x: 20.66, y: -12.22))
        blade11Path.addCurve(to: CGPoint(x: 21.13, y: -17.54), controlPoint1: CGPoint(x: 19.68, y: -13.91), controlPoint2: CGPoint(x: 19.87, y: -16.04))
        blade11Path.addCurve(to: CGPoint(x: 24.82, y: -20.1), controlPoint1: CGPoint(x: 21.96, y: -18.45), controlPoint2: CGPoint(x: 22.92, y: -19))
        blade11Path.addLine(to: CGPoint(x: 24.9, y: -20.15))
        blade11Path.addCurve(to: CGPoint(x: 39.88, y: -28.42), controlPoint1: CGPoint(x: 37.9, y: -27.66), controlPoint2: CGPoint(x: 38.85, y: -28.21))
        blade11Path.addLine(to: CGPoint(x: 40.07, y: -28.47))
        blade11Path.addCurve(to: CGPoint(x: 44.91, y: -26.22), controlPoint1: CGPoint(x: 42, y: -28.81), controlPoint2: CGPoint(x: 43.93, y: -27.91))
        blade11Path.addCurve(to: CGPoint(x: 45.03, y: -26), controlPoint1: CGPoint(x: 45.03, y: -26), controlPoint2: CGPoint(x: 45.03, y: -26))
        blade11Path.addLine(to: CGPoint(x: 45.03, y: -26))
        blade11Path.close()
        darkAlpha03.setFill()
        blade11Path.fill()


        //// Blade12 Drawing
        let blade12Path = UIBezierPath()
        blade12Path.move(to: CGPoint(x: 26, y: -45.03))
        blade12Path.addLine(to: CGPoint(x: 26, y: -45.03))
        blade12Path.addLine(to: CGPoint(x: 26, y: -45.03))
        blade12Path.addLine(to: CGPoint(x: 26.22, y: -44.91))
        blade12Path.addCurve(to: CGPoint(x: 28.47, y: -40.07), controlPoint1: CGPoint(x: 27.91, y: -43.93), controlPoint2: CGPoint(x: 28.81, y: -42))
        blade12Path.addCurve(to: CGPoint(x: 26.56, y: -36), controlPoint1: CGPoint(x: 28.21, y: -38.85), controlPoint2: CGPoint(x: 27.66, y: -37.9))
        blade12Path.addLine(to: CGPoint(x: 20.15, y: -24.9))
        blade12Path.addCurve(to: CGPoint(x: 17.67, y: -21.27), controlPoint1: CGPoint(x: 19, y: -22.92), controlPoint2: CGPoint(x: 18.45, y: -21.96))
        blade12Path.addLine(to: CGPoint(x: 17.54, y: -21.13))
        blade12Path.addCurve(to: CGPoint(x: 12.22, y: -20.66), controlPoint1: CGPoint(x: 16.04, y: -19.87), controlPoint2: CGPoint(x: 13.91, y: -19.68))
        blade12Path.addCurve(to: CGPoint(x: 12, y: -20.78), controlPoint1: CGPoint(x: 12, y: -20.78), controlPoint2: CGPoint(x: 12, y: -20.78))
        blade12Path.addLine(to: CGPoint(x: 12, y: -20.78))
        blade12Path.addLine(to: CGPoint(x: 12, y: -20.78))
        blade12Path.addLine(to: CGPoint(x: 11.78, y: -20.91))
        blade12Path.addCurve(to: CGPoint(x: 9.53, y: -25.75), controlPoint1: CGPoint(x: 10.09, y: -21.89), controlPoint2: CGPoint(x: 9.19, y: -23.82))
        blade12Path.addCurve(to: CGPoint(x: 11.44, y: -29.82), controlPoint1: CGPoint(x: 9.79, y: -26.96), controlPoint2: CGPoint(x: 10.34, y: -27.92))
        blade12Path.addLine(to: CGPoint(x: 11.49, y: -29.9))
        blade12Path.addCurve(to: CGPoint(x: 20.33, y: -44.55), controlPoint1: CGPoint(x: 19, y: -42.9), controlPoint2: CGPoint(x: 19.55, y: -43.85))
        blade12Path.addLine(to: CGPoint(x: 20.46, y: -44.69))
        blade12Path.addCurve(to: CGPoint(x: 25.78, y: -45.16), controlPoint1: CGPoint(x: 21.96, y: -45.95), controlPoint2: CGPoint(x: 24.09, y: -46.14))
        blade12Path.addCurve(to: CGPoint(x: 26, y: -45.03), controlPoint1: CGPoint(x: 26, y: -45.03), controlPoint2: CGPoint(x: 26, y: -45.03))
        blade12Path.addLine(to: CGPoint(x: 26, y: -45.03))
        blade12Path.close()
        darkAlpha03.setFill()
        blade12Path.fill()



        context.restoreGState()
        
        context.restoreGState()

    }

    //// Generated Images

    @objc dynamic public class func imageOfActivityIndicator(fillColor: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000), rotationProgress: CGFloat = 0) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 108, height: 108), false, 0)
            JAHubStyleKit.drawActivityIndicator(fillColor: fillColor, rotationProgress: rotationProgress)

        let imageOfActivityIndicator = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return imageOfActivityIndicator
    }




    @objc(JAHubStyleKitResizingBehavior)
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.

        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }

            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
                    scales.width = 1
                    scales.height = 1
            }

            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}
