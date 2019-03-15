//// CirclePathCountdownView.swift
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


/**
 Circle path view with countdown.
 
 To set countdown and stroke color call
 ```
 public func setup(with countdownDuration: TimeInterval, strokeColor: UIColor = .action)
 ```
 */
public class CirclePathCountdownView: PathProgressView {

    override public var path: UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - PathProgressView.lineWidth)/2, startAngle: CGFloat(.pi * -0.5), endAngle: CGFloat(.pi * 1.5), clockwise: true)
    }
    
}

/**
 Circle path view with progress.
 
 To set progress and stroke color call
 ```
 public func setup(progress: CGFloat, strokeColor: UIColor = .action)
 ```
 */
public class CirclePathProgressView: PathProgressView {
    
    override public var path: UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - PathProgressView.lineWidth)/2, startAngle: CGFloat(.pi * -0.5), endAngle: CGFloat(.pi * -2.5), clockwise: false)
    }
    
}
