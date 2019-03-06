//// SYUIBottomSheetView.swift
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


/// Bottom sheet view delegate protocol.
public protocol BottomSheetViewDelegate: class {
    /// Tells if bottomSheetView should change position when pan gesture is recognized (default set to true)
    func bottomSheetCanMove() -> Bool
    
    /// Delegate information, that bottomSheetView change its position by pan gesture
    ///
    /// - Parameters:
    ///   - bottomSheetView: bottom sheet view
    ///   - delta: position diffrence in points
    ///   - offset: targeted y offset of view from its superview
    func bottomSheetDidSwipe(_ bottomSheetView: SYUIBottomSheetView, with delta: CGFloat, to offset: CGFloat)
    
    /// Delegate information, that bottomSheetView will animate its position
    ///
    /// - Parameters:
    ///   - bottomSheetView: bottom sheet view
    ///   - offset: targeted y offset of view from its superview
    ///   - duration: animation duration
    func bottomSheetWillAnimate(_ bottomSheetView: SYUIBottomSheetView, to offset: CGFloat, with duration: TimeInterval)
    
    /// Delegate information, that bottomSheetView will appear on screen
    func bottomSheetWillAppear(_ bottomSheetView: SYUIBottomSheetView)
    
    /// Delegate information, that bottomSheetView will disappear from screen
    func bottomSheetWillDisappear(_ bottomSheetView: SYUIBottomSheetView)
    
    /// Delegate information, that bottomSheetView was swiped out of screen by pan gesture
    func bottomSheetDidSwipeOut(_ bottomSheetView: SYUIBottomSheetView)
    
    /// Delegate information, that bottomSheetView did finish its animation
    ///
    /// - Parameters:
    ///   - offset: final y offset of view from its superview
    func bottomSheetDidAnimate(_ bottomSheetView: SYUIBottomSheetView, to offset: CGFloat)
}

/// Default implementation to declare delegate methods as optional
public extension BottomSheetViewDelegate {
    func bottomSheetCanMove() -> Bool { return true }
    
    func bottomSheetDidSwipe(_ bottomSheetView: SYUIBottomSheetView, with delta: CGFloat, to offset: CGFloat) {}
    func bottomSheetWillAnimate(_ bottomSheetView: SYUIBottomSheetView, to offset: CGFloat, with duration: TimeInterval) {}
    func bottomSheetWillAppear(_ bottomSheetView: SYUIBottomSheetView) {}
    func bottomSheetWillDisappear(_ bottomSheetView: SYUIBottomSheetView) {}
    func bottomSheetDidSwipeOut(_ bottomSheetView: SYUIBottomSheetView) {}
    func bottomSheetDidAnimate(_ bottomSheetView: SYUIBottomSheetView, to offset: CGFloat) {}
}

/// Bottom sheet view
open class SYUIBottomSheetView: UIView {
    
    // MARK: - Public Properties
    
    /// Offset of bottom sheet view from top of its superview when expanded.
    public var minTopMargin: CGFloat = 68
    /// Height of visible part of bottom sheet view when minimized.
    public var minimizedHeight: CGFloat = SYUIBottomSheetView.minVisibleHeight
    /// Indicates if bottom sheet view will listen to swipe to hide gesture when minimized.
    public var canSwipeToHide: Bool = false
    /// Pan gesture recognizer to handle bottom sheet movement.
    public let panGesture = UIPanGestureRecognizer()
    /// View to indicate bottom sheet can be moved with gestures.
    public let dragIndicatorView = UIView()
    
    /// Delegate
    public weak var sheetDelegate: BottomSheetViewDelegate?
    
    /// Starting position (in points) of bottom sheet view used as targeted position by animateIn(...)
    open var startingOffset: CGFloat {
        return minimizedHeight
    }
    
    /// Minimal positon offset of bottom sheet view from top of its superview
    open var minOffset: CGFloat {
        return minTopMargin
    }
    
    /// Maximal positon offset of bottom sheet view from top of its superview
    open var maxOffset: CGFloat {
        return minimizedPosition
    }
    
    /// Current positon offset of bottom sheet view from top of its superview
    public var currentOffset: CGFloat {
        return superviewHeight() - topConstraint.constant
    }
    
    /// Height of bottom sheet view content (should be equal with bottom sheet view height)
    public var contentHeight: CGFloat {
        return superviewHeight() - minOffset
    }
    
    /// Positon offset of bottom sheet view from top of its superview when minimized
    public var minimizedPosition: CGFloat {
        return superviewHeight() - minimizedHeight
    }
    
    /// Indicates if bottom sheet view is fully visible on screen (expanded)
    public var isFullViewVisible: Bool {
        if let presentationLayer = layer.presentation() {
            return presentationLayer.frame.origin.y <= minOffset
        }
        return false
    }
    
    /// Indicates if bottom sheet view is placed on its minimized offset position
    public var isCollapsed: Bool {
        return frame.origin.y.rounded(.toNearestOrEven) == minimizedPosition.rounded(.toNearestOrEven)
    }
    
    // MARK: - Private Properties
    
    private static let dragIndicatorViewTopMargin: CGFloat = 7.0
    private static let minVisibleHeight: CGFloat = 100
    private static let maxSlideAnimationDuration: TimeInterval = 0.8
    
    private var heightConstraint = NSLayoutConstraint()
    private var translationOffset: CGFloat = 0
    private var animationToCount: Int = 0
    private var dragIndicatorViewTopConstraint = NSLayoutConstraint()
    private var topConstraint = NSLayoutConstraint()
    
    // MARK: - Public Methods
    
    public init() {
        super.init(frame: CGRect.zero)
        createUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func didMoveToSuperview() {
        if superview != nil {
            createLayoutConstraintsForSuperview()
            bringSubview(toFront: dragIndicatorView)
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        dragIndicatorView.fullRoundCorners()
    }
    
    /// Moves drag indicator view
    ///
    /// - Parameter offset: position offset from top of bottom sheet view
    open func updateDragIndicatorView(with offset: CGFloat) {
        let normalizedOffset = min(SYUIBottomSheetView.dragIndicatorViewTopMargin, offset+SYUIBottomSheetView.dragIndicatorViewTopMargin)
        dragIndicatorViewTopConstraint.constant = normalizedOffset
        dragIndicatorView.isHidden = normalizedOffset < -SYUIBottomSheetView.dragIndicatorViewTopMargin
        layoutIfNeeded()
    }
    
    /// Update bottom sheet view to fit its content height property
    ///
    /// - Parameter shouldMinimize: if true, bottom sheet view will minimize after
    public func updateContentHeight(shouldMinimize: Bool) {
        heightConstraint.constant = contentHeight
        if shouldMinimize {
            minimize()
        }
    }
    
    /// Updates height and minimize bottom sheet view. Should be called by superview controller when viewWillTransition(..) is called
    ///
    /// - Parameters:
    ///   - size: superview new size
    ///   - coordinator: transition coordinator
    public func superviewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        updateContentHeight(shouldMinimize: true)
    }
    
    /// Minimize bottom sheet view
    public func minimize() {
        if !isCollapsed {
            animateTo(maxOffset, duration: SYUIConstants.animationDuration)
        }
    }
    
    /// Shows full bottom sheet view
    public func expand() {
        animateTo(minOffset, duration: SYUIConstants.animationDuration)
    }
    
    //MARK: UI
    
    /// Creates and setups besic UI elements
    open func createUI() {
        backgroundColor = .background
        setupShadowTopBorder()
        
        clipsToBounds = false
        
        createPanGesture()
        createDragIndicatorView()
    }
    
    //MARK: To override
    
    /// Called when view is going to be expanded
    open func willExpand() {}
    /// Called when view was expanded
    open func didExpand() {}
    /// Called when view is going to be minimized
    open func willMinimize() {}
    /// Called when view was minimized
    open func didMinimize() {}
    
    // MARK: - Private Methods
    
    private func superviewHeight() -> CGFloat {
        if let superview = superview {
            return superview.frame.size.height
        }
        return 0
    }
    
    private func createPanGesture() {
        panGesture.addTarget(self, action: #selector(panGestureRecognized(_:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delegate = self
        addGestureRecognizer(panGesture)
    }
    
    private func createDragIndicatorView() {
        dragIndicatorView.backgroundColor = .actionIndicator

        dragIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dragIndicatorView)
        
        dragIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dragIndicatorView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        dragIndicatorView.heightAnchor.constraint(equalToConstant: 6).isActive = true
        dragIndicatorViewTopConstraint = dragIndicatorView.topAnchor.constraint(equalTo: topAnchor, constant: SYUIBottomSheetView.dragIndicatorViewTopMargin)
        dragIndicatorViewTopConstraint.isActive = true
        
        bringSubview(toFront: dragIndicatorView)
    }
    
    private func createLayoutConstraintsForSuperview() {
        guard let superview = superview else { return }
        
        frame =  superview.frame // fix constraints broke after content setup before view was layout
        translatesAutoresizingMaskIntoConstraints = false
        
        let layoutDictionary = ["view": self]

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: layoutDictionary))
        
        topConstraint = superview.bottomAnchor.constraint(equalTo: topAnchor)
        heightConstraint = heightAnchor.constraint(greaterThanOrEqualToConstant: contentHeight)
        
        NSLayoutConstraint.activate([topConstraint, heightConstraint])
    }
    
}

// MARK: - Animating

extension SYUIBottomSheetView {
    
    open func shouldAnimateAlpha() -> Bool {
        return false
    }

    open func willAppear() {
        updateContentHeight(shouldMinimize: false)
        sheetDelegate?.bottomSheetWillAppear(self)
    }

    open func didAppear() { }

    open func willDisappear() {
        sheetDelegate?.bottomSheetWillDisappear(self)
    }

    open func didDisappear() { }
    
}

public extension SYUIBottomSheetView {
    
    public func animateIn(bounce: Bool = false, _ completion: (()->Void)?) {
        topConstraint.constant = 0
        updateContentHeight(shouldMinimize: false)
        superview?.layoutIfNeeded()
        
        let duration = SYUIConstants.animationDuration
        
        topConstraint.constant = startingOffset
        isHidden = false
        
        sheetDelegate?.bottomSheetWillAnimate(self, to: minimizedPosition, with: duration)
        willAppear()
        
        let animationBlock: (()->()) = { [unowned self] in
            self.superview?.layoutIfNeeded()
        }
        
        let completionBlock: ((Bool)->()) = { finished in
            completion?()
            
            self.didAppear()
            self.sheetDelegate?.bottomSheetDidAnimate(self, to: self.minimizedPosition)
        }
        
        if bounce {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 30, options: [], animations: animationBlock, completion: completionBlock)
        } else {
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: animationBlock, completion: completionBlock)
        }
    }
    
    public func animateOut(_ completion: (()->Void)?) {
        topConstraint.constant = 0
        
        let duration = SYUIConstants.animationDuration
        
        willDisappear()
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: { [unowned self] in
            self.superview?.layoutIfNeeded()
        }) { [unowned self] (finished) in
            self.isHidden = true
            completion?()
            
            self.didDisappear()
        }
    }
    
    public func animateTo(_ offset: CGFloat, duration: TimeInterval) {
        animateTo(offset, duration: duration, completion: nil)
    }
    
    @objc public func animateTo(_ offset: CGFloat, duration: TimeInterval, completion: (()->Void)?) {
        animateTo(offset, duration: duration, notifyDelegate: true, completion: completion)
    }
    
    public func animateTo(_ offset: CGFloat, duration: TimeInterval, notifyDelegate: Bool, completion: (()->Void)?) {
        if notifyDelegate {
            self.sheetDelegate?.bottomSheetWillAnimate(self, to: offset, with: duration)
        }
        
        if offset == minOffset {
            willExpand()
        } else {
            willMinimize()
        }
        topConstraint.constant = superviewHeight() - offset
        
        self.animationToCount += 1
        
        UIView.animate(withDuration: duration, delay: 0, options: [.allowUserInteraction,.curveEaseOut], animations: { [unowned self] in
            self.superview?.layoutIfNeeded()
        }) { [unowned self] (finished) in
            self.animationToCount -= 1
            
            if offset == self.minOffset {
                self.didExpand()
            } else {
                self.didMinimize()
            }
            
            if notifyDelegate, self.animationToCount == 0 {
                self.sheetDelegate?.bottomSheetDidAnimate(self, to: offset)
            }
            
            completion?()
        }
    }
}

//MARK: - Pan gesture

extension SYUIBottomSheetView: UIGestureRecognizerDelegate {
    
    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc public func panGestureRecognized(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            panGestureRecognizerBegin(recognizer)
        case .changed:
            let translation = recognizer.translation(in: self)
            if let recognizerFrame = recognizer.view?.frame {
                self.sheetDelegate?.bottomSheetDidSwipe(self, with: translation.y, to: recognizerFrame.origin.y)
            }
            panGestureRecognizerChanged(recognizer)
        case .ended,
             .failed,
             .cancelled:
            panGestureRecognizerEnded(recognizer)
        default:
            break
        }
    }
    
    open func panGestureRecognizerBegin(_ recognizer: UIPanGestureRecognizer) {
        translationOffset = recognizer.location(in: self).y
    }
    
    @objc open func panGestureRecognizerChanged(_ recognizer: UIPanGestureRecognizer) {
        if let delegate = sheetDelegate, !delegate.bottomSheetCanMove() {
            return
        }
        
        let currentTranslation = recognizer.location(in: self)
        let translation = currentTranslation.y - translationOffset
        
        let delta = topConstraint.constant - translation;
        var constantAdjustment: CGFloat
        if (delta > (superviewHeight() - minOffset)) {
            constantAdjustment = superviewHeight() - minOffset
        } else if (delta < (superviewHeight() - maxOffset)) {
            constantAdjustment = (superviewHeight() - maxOffset);
        } else {
            constantAdjustment = topConstraint.constant - translation;
        }
        
        topConstraint.constant = constantAdjustment
    }
    
    @objc open func panGestureRecognizerEnded(_ recognizer: UIPanGestureRecognizer) {
        if let delegate = sheetDelegate, !delegate.bottomSheetCanMove() {
            return
        }
        
        if canSwipeToHide && isCollapsed && (recognizer.location(in: self).y - translationOffset) > 0 {
            animateOut({
                self.sheetDelegate?.bottomSheetDidSwipeOut(self)
            })
            return
        }
        
        if isFullViewVisible {
            self.sheetDelegate?.bottomSheetWillAnimate(self, to: minOffset, with: 0)
            self.didExpand()
            self.sheetDelegate?.bottomSheetDidAnimate(self, to: minOffset)
            return
        }
        
        let velocity = recognizer.velocity(in: self)
        var duration =  (TimeInterval)((contentHeight - minOffset) / fabs(velocity.y))
        duration = min(SYUIBottomSheetView.maxSlideAnimationDuration, duration)
        
        let isHorizontalPan = abs(velocity.x) > abs(velocity.y)
        var offset: CGFloat
        
        if velocity.y == 0 || isHorizontalPan {
            let midOffset = (maxOffset-minOffset)/2.0 + minOffset
            if frame.origin.y < midOffset {
                offset = minOffset
            } else {
                offset = maxOffset
            }
        } else if velocity.y > 0 {
            offset = maxOffset
        } else {
            offset = minOffset
        }
        
        animateTo(offset, duration: duration, completion: nil)
    }
}
