//// SYUICompassController.swift
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

import Foundation


/// Compass controller delegate protocol.
public protocol SYUICompassDelegate: class {
    
    /// Delegate informs, that was tapped on compass.
    ///
    /// - Parameter compass: compass reference, which was tapped.
    func compassDidTap(_ compass: SYUICompass)
}

/// View controller, that manage compass view.
open class SYUICompassController {
    
    // MARK: - Public Properties
    
    /// View, that compass controller manage.
    public var compass = SYUICompass()
    
    /// Sets angle of a compass in degrees.
    ///
    /// If course is 0 degrees, compass is hidden with animation. You can override this behavior in inherited class.
    public var course: Double {
        didSet {
            course = course.truncatingRemainder(dividingBy: 360.0)
            compass.rotateArrow(CGFloat(course) * .pi / halfRotation)
            compass.animateVisibility(shouldBeVisible())
        }
    }
    
    /// Auto hide sets possibility to hide compass, if course is 0, which is north.
    public var autoHide: Bool
    
    /// Compass controller delegate.
    public weak var delegate: SYUICompassDelegate?
    
    // MARK: - Private Properties
    
    private let halfRotation = CGFloat(180.0)
    
    // MARK: - Public Methods
    
    public init(course: Double = 0.0, autoHide: Bool = true) {
        self.course = course
        self.autoHide = autoHide
        
        createTapGestureRecognizer()
    }
    
    // MARK: - Private Methods
    
    private func shouldBeVisible() -> Bool {
        return course.rounded() != 0 || !autoHide
    }
    
    // MARK: Actions
    private func createTapGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.compassClicked))
        compass.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func compassClicked(_ rg: UITapGestureRecognizer) {
        delegate?.compassDidTap(compass)
    }
}
