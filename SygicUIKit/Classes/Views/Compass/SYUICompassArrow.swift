//// SYUICompassArrow.swift
//
// Copyright (c) 2019 Sygic a.s.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit


/// Compass arrow drawn with `UIBezierPath`
class SYUICompassArrow: UIView {
    
    override func draw(_ rect: CGRect) {
        //// north Drawing
        let northPath = UIBezierPath()
        northPath.move(to: CGPoint(x: CGFloat(rect.minX + 0.41304 * rect.width), y: CGFloat(rect.minY + 0.50000 * rect.height)))
        northPath.addLine(to: CGPoint(x: CGFloat(rect.minX + 0.50000 * rect.width), y: CGFloat(rect.minY + 0.10870 * rect.height)))
        northPath.addLine(to: CGPoint(x: CGFloat(rect.minX + 0.58696 * rect.width), y: CGFloat(rect.minY + 0.50000 * rect.height)))
        northPath.addLine(to: CGPoint(x: CGFloat(rect.minX + 0.41304 * rect.width), y: CGFloat(rect.minY + 0.50000 * rect.height)))
        northPath.close()
        UIColor.error.setFill()
        northPath.fill()
        //// south Drawing
        let southPath = UIBezierPath()
        southPath.move(to: CGPoint(x: CGFloat(rect.minX + 0.41304 * rect.width), y: CGFloat(rect.minY + 0.50000 * rect.height)))
        southPath.addLine(to: CGPoint(x: CGFloat(rect.minX + 0.50000 * rect.width), y: CGFloat(rect.minY + 0.89130 * rect.height)))
        southPath.addLine(to: CGPoint(x: CGFloat(rect.minX + 0.58696 * rect.width), y: CGFloat(rect.minY + 0.50000 * rect.height)))
        southPath.addLine(to: CGPoint(x: CGFloat(rect.minX + 0.41304 * rect.width), y: CGFloat(rect.minY + 0.50000 * rect.height)))
        southPath.close()
        UIColor.border.setFill()
        southPath.fill()
    }
    
}
