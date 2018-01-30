//
//  CGContextExtension.swift
//  TicTacToeApp
//
//  Created by Derek Williams on 1/29/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import UIKit

// Utility methods that encapsulate the CoreGraphics API.
internal extension CGContext {
    func strokeLineFrom(_ from: CGPoint, to: CGPoint, color: UIColor, width: CGFloat, lineCap: CGLineCap) {
        self.setStrokeColor(color.cgColor)
        self.setLineWidth(width)
        self.setLineCap(lineCap)
        self.move(to: CGPoint(x: from.x, y: from.y))
        self.addLine(to: CGPoint(x: to.x, y: to.y))
        self.strokePath()
    }
    
    func fillRect(_ rect: CGRect, color: UIColor) {
        self.setFillColor(color.cgColor)
        self.fill(rect)
        self.strokePath()
    }
    
    func strokeRect(_ rect: CGRect, color: UIColor, width: CGFloat) {
        self.setLineWidth(width)
        self.setStrokeColor(color.cgColor)
        self.addRect(rect)
        self.strokePath()
    }
    
    func strokeEllipseInRect(_ rect: CGRect, color: UIColor, width: CGFloat) {
        self.setStrokeColor(color.cgColor)
        self.setLineWidth(width)
        self.addEllipse(in: rect)
        self.strokePath()
    }
}
