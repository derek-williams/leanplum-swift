//
//  CGRectExtension.swift
//  TicTacToeApp
//
//  Created by Derek Williams on 1/20/18.
//  Copyright © 2018 derekLeanplum. All rights reserved.
//

import UIKit

internal extension CGRect {
    var bottomCenter: CGPoint { return CGPoint(x: midX, y: maxY) }
    var bottomLeft:   CGPoint { return CGPoint(x: minX, y: maxY) }
    var bottomRight:  CGPoint { return CGPoint(x: maxX, y: maxY) }
    var center:       CGPoint { return CGPoint(x: midX, y: midY) }
    var centerLeft:   CGPoint { return CGPoint(x: minX, y: midY) }
    var centerRight:  CGPoint { return CGPoint(x: maxX, y: midY) }
    var topCenter:    CGPoint { return CGPoint(x: midX, y: minY) }
    var topLeft:      CGPoint { return CGPoint(x: minX, y: minY) }
    var topRight:     CGPoint { return CGPoint(x: maxX, y: minY) }
    
    func insetBy(_ amount: CGFloat) -> CGRect {
        return self.insetBy(dx: amount, dy: amount)
    }
}
