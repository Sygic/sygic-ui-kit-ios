//// SYUICompass.swift
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
import UIKit


/// Compass view.
public class SYUICompass: UIView {
    
    // MARK: - Private Properties
    
    private let COMPASS_BACKGROUND_SIZE = 44.0
    private let COMPASS_BORDER_SIZE = 46.0
    private let compassArrow = SYUICompassArrow()
    private let backgroundView = UIView()
    private let borderView = UIView()
    
    // MARK: - Public Methods
    
    public init() {
        super.init(frame: CGRect.zero)
        initDefault()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.fullRoundCorners()
        borderView.fullRoundCorners()
    }
    
    /// Rotate arrow at compass.
    ///
    /// - Parameter rotation: angle of arrow in radians.
    public func rotateArrow(_ rotation: CGFloat) {
        compassArrow.layer.setAffineTransform(CGAffineTransform(rotationAngle: rotation))
    }
    
    /// Animate visibility of a compass.
    ///
    /// - Parameter visible: Boolean value whether compass is visible or not.
    public func animateVisibility(_ visible: Bool) {
        if visible && alpha == 0.0  {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut, .beginFromCurrentState], animations: {
                self.alpha = 1.0
            })
        } else if !visible && alpha == 1.0 {
            UIView.animate(withDuration: 0.2, delay: 1.0, options: [.curveEaseInOut, .beginFromCurrentState], animations: {
                self.alpha = 0.0
            })
        }
    }
    
    // MARK: UIViewGeometry
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if (alpha == 0) {
            return false
        }
        var bounds: CGRect = self.bounds
        let hitOffset = CGFloat(10.0)
        bounds = CGRect(x: CGFloat(bounds.origin.x - hitOffset), y: CGFloat(bounds.origin.y - hitOffset), width: CGFloat(bounds.size.width + 2 * hitOffset), height: CGFloat(bounds.size.height + 2 * hitOffset))
        return bounds.contains(point)
    }
    
    // MARK: - Private Methods
    
    // MARK: UI
    
    private func initDefault() {
        alpha = 1
        accessibilityLabel = "native.compas"
        translatesAutoresizingMaskIntoConstraints = false
        let compassSize = CGSize(width: COMPASS_BACKGROUND_SIZE, height: COMPASS_BACKGROUND_SIZE)
        NSLayoutConstraint.activate(widthAndHeightConstraints(with: compassSize))
        createBorderView()
        createBackgroundView()
        createCompassArrow()
        
        setupColors()
        NotificationCenter.default.addObserver(self, selector: #selector(setupColors), name: Notification.Name(ColorPaletteChangedNotification), object: nil)
    }
    
    private func createBackgroundView() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundView)
        backgroundView.coverWholeSuperview()
    }
    
    private func createBorderView() {
        borderView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(borderView)
        borderView.coverWholeSuperview(withMargin: -1.0)
    }
    
    private func createCompassArrow() {
        compassArrow.translatesAutoresizingMaskIntoConstraints = false
        compassArrow.layer.shouldRasterize = true
        compassArrow.backgroundColor = .clear
        
        addSubview(compassArrow)
        compassArrow.coverWholeSuperview()
    }
    
}

extension SYUICompass: SYUIColorUpdate {
    public func setupColors() {
        borderView.backgroundColor = .iconBackground
        backgroundView.backgroundColor = .background
        compassArrow.setNeedsDisplay()
        setupDefaultShadow()
    }
}
