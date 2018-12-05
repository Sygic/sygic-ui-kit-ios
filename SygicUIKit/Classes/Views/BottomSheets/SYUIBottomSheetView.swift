import UIKit

public protocol BottomSheetViewDelegate: class {
    /// Tells if bottomSheetView should change position when pan gesture is recognized (default set to true)
    func bottomSheetCanMove() -> Bool
    
    func bottomSheetDidSwipe(_ bottomSheetView: SYUIBottomSheetView, with delta: CGFloat, to offset: CGFloat)
    func bottomSheetWillAnimate(_ bottomSheetView: SYUIBottomSheetView, to offset: CGFloat, with duration: TimeInterval)
    func bottomSheetWillAppear(_ bottomSheetView: SYUIBottomSheetView)
    func bottomSheetWillDisappear(_ bottomSheetView: SYUIBottomSheetView)
    func bottomSheetDidSwipeOut(_ bottomSheetView: SYUIBottomSheetView)
    func bottomSheetDidAnimate(_ bottomSheetView: SYUIBottomSheetView, to offset: CGFloat)
}

public extension BottomSheetViewDelegate {
    func bottomSheetCanMove() -> Bool { return true }
    
    func bottomSheetDidSwipe(_ bottomSheetView: SYUIBottomSheetView, with delta: CGFloat, to offset: CGFloat) {}
    func bottomSheetWillAnimate(_ bottomSheetView: SYUIBottomSheetView, to offset: CGFloat, with duration: TimeInterval) {}
    func bottomSheetWillAppear(_ bottomSheetView: SYUIBottomSheetView) {}
    func bottomSheetWillDisappear(_ bottomSheetView: SYUIBottomSheetView) {}
    func bottomSheetDidSwipeOut(_ bottomSheetView: SYUIBottomSheetView) {}
    func bottomSheetDidAnimate(_ bottomSheetView: SYUIBottomSheetView, to offset: CGFloat) {}
}


open class SYUIBottomSheetView: UIView {
    
    private static let dragIndicatorViewTopMargin: CGFloat = 7.0
    private static let minVisibleHeight: CGFloat = 100
    private static let maxSlideAnimationDuration: TimeInterval = 0.8
    
    public weak var sheetDelegate: BottomSheetViewDelegate?
    public var minTopMargin: CGFloat = 68
    public var minimizedHeight: CGFloat = SYUIBottomSheetView.minVisibleHeight
    public var canSwipeToHide: Bool = false
    public var translationOffset: CGFloat = 0
    public let panGesture = UIPanGestureRecognizer()
    public let dragIndicatorView = UIView()
    
    private var heightConstraint = NSLayoutConstraint()
    private var animationToCount: Int = 0
    private var dragIndicatorViewTopConstraint = NSLayoutConstraint()
    private var topConstraint = NSLayoutConstraint()
    
    open var startingOffset: CGFloat {
        return minimizedHeight
    }
    open var minOffset: CGFloat {
        return minTopMargin
    }
    open var maxOffset: CGFloat {
        return minimizedPosition
    }
    
    public var currentOffset: CGFloat {
        return superviewHeight() - topConstraint.constant
    }
    
    public var contentHeight: CGFloat {
        return superviewHeight() - minOffset
    }
    
    public var minimizedPosition: CGFloat {
        return superviewHeight() - minimizedHeight
    }
    
    public var isFullViewVisible: Bool {
        if let presentationLayer = layer.presentation() {
            return presentationLayer.frame.origin.y <= minOffset
        }
        return false
    }
    public var isCollapsed: Bool {
        return frame.origin.y.rounded(.toNearestOrEven) == minimizedPosition.rounded(.toNearestOrEven)
    }
    
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
    
    private func superviewHeight() -> CGFloat {
        if let superview = superview {
            return superview.frame.size.height
        }
        return 0
    }
    
    //MARK: - UI
    open func createUI() {
        backgroundColor = .background
        setupShadowTopBorder()
        
        clipsToBounds = false
        
        createPanGesture()
        createDragIndicatorView()
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
    
    open func updateDragIndicatorView(with offset: CGFloat) {
        let normalizedOffset = min(SYUIBottomSheetView.dragIndicatorViewTopMargin, offset+SYUIBottomSheetView.dragIndicatorViewTopMargin)
        dragIndicatorViewTopConstraint.constant = normalizedOffset
        dragIndicatorView.isHidden = normalizedOffset < -SYUIBottomSheetView.dragIndicatorViewTopMargin
        layoutIfNeeded()
    }
    
    public func updateContentHeight(shouldMinimize: Bool) {
        heightConstraint.constant = contentHeight
        if shouldMinimize {
            minimize()
        }
    }
    
    public func superviewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        updateContentHeight(shouldMinimize: true)
    }
    
    public func minimize() {
        if !isCollapsed {
            animateTo(maxOffset, duration: SYUIConstants.animationDuration)
        }
    }
    
    public func expand() {
        animateTo(minOffset, duration: SYUIConstants.animationDuration)
    }
    
    //MARK: - To override
    
    open func willExpand() {}
    open func didExpand() {}
    open func willMinimize() {}
    open func didMinimize() {}
    
    open func shouldRestoreMapState() -> Bool { return false }
}

//MARK: - Animating

extension SYUIBottomSheetView {//: Animating {
    open func shouldAnimateAlpha() -> Bool {
        return false
    }

    open func willAppear() {
        updateContentHeight(shouldMinimize: false)
        sheetDelegate?.bottomSheetWillAppear(self)
    }

    open func didAppear() {
    }

    open func willDisappear() {
        sheetDelegate?.bottomSheetWillDisappear(self)
    }

    open func didDisappear() {
    }
}

// MARK: -

public extension SYUIBottomSheetView {
    
    public func animateIn(_ completion: (()->Void)?) {
        topConstraint.constant = 0
        updateContentHeight(shouldMinimize: false)
        superview?.layoutIfNeeded()
        
        let duration = SYUIConstants.animationDuration
        
        topConstraint.constant = startingOffset
        isHidden = false
        
        sheetDelegate?.bottomSheetWillAnimate(self, to: minimizedPosition, with: duration)
        willAppear()
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: { [unowned self] in
            self.superview?.layoutIfNeeded()
        }) { (finished) in
            completion?()
            
            self.didAppear()
            self.sheetDelegate?.bottomSheetDidAnimate(self, to: self.minimizedPosition)
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
