//// SYUIZoomController.swift
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


/// Zoom controller possible activites (user interaction)
public enum SYUIZoomActivity {
    /// zoom in button tapped activity
    case zoomIn
    /// zoom out button tapped activity
    case zoomOut
    /// zoom in button long press activity
    case startZoomIn
    /// zoom out button long press activity
    case startZoomOut
    /// zoom in / zoom out button released after being in zoomingIn/zoomingOut activity
    case stopZooming
    /// zoom in button is being pressed activity
    case zoomingIn
    /// zoom out button is being pressed activity
    case zoomingOut
    /// toggle 3D button tapped activity
    case toggle3D
}

/// Zoom controller delegate
public protocol SYUIZoomControllerDelegate: class {
    
    /// Zoom controller delegation of user interaction with zoom control.
    ///
    /// - Parameter activity: Activity based on user interaction.
    func zoomController(_ controller: SYUIZoomController, wants activity: SYUIZoomActivity)
}


/// Zoom controller is specific implementation of expandable buttons controller
/// with zoom buttons, 3D toggle button and gesture recognizers.
open class SYUIZoomController: SYUIExpandableButtonsController {

    // MARK: - Public Properties
    
    /// Returns if control is toggled to 3D and updates toggle button title.
    public var is3D = false {
        didSet {
            // must be guarded to not trigger unwanted animations
            guard is3D != oldValue else { return }
            updateToggle3DButtonTitle()
        }
    }
    
    /// Icon for zoom in button.
    public var zoomInButtonIcon = SYUIIcon.zoomIn {
        didSet {
            zoomInButton.setTitle(zoomInButtonIcon, for: .normal)
        }
    }
    
    /// Icon for zoom out button.
    public var zoomOutButtonIcon = SYUIIcon.zoomOut {
        didSet {
            zoomOutButton.setTitle(zoomOutButtonIcon, for: .normal)
        }
    }
    
    /// Icon for 2D toggle button,
    public var icon2D = SYUIIcon.view2D {
        didSet {
            toggle3DButton.setTitle(toggle3DButtonIcon, for: .normal)
        }
    }
    
    /// Icon for 3D toggle button.
    public var icon3D = SYUIIcon.view3D {
        didSet {
            toggle3DButton.setTitle(toggle3DButtonIcon, for: .normal)
        }
    }
    
    /// Returns button icon for toggle button.
    public var toggle3DButtonIcon: String {
        return is3D ? icon3D : icon2D
    }
    
    /// A speed interval of zooming in or zooming out.
    public var zoomingTimerInterval = 0.2
    
    /// Zoom controller delegate.
    public weak var delegate: SYUIZoomControllerDelegate?
    
    // MARK: - Private Properties
    
    private let zoomInButton = SYUIExpandableButton(withType: .icon)
    private let zoomOutButton = SYUIExpandableButton(withType: .icon)
    private let toggle3DButton = SYUIExpandableButton(withType: .icon)
    
    private var zoomingTimer: Timer?
    
    // MARK: - Public Methods
    
    public override init() {
        super.init()
        
        setupExpandableButtons()
        setupRecognizers()
    }
    
    public override func expandButtons() {
        updateToggle3DButtonTitle()
        super.expandButtons()
    }
    
    // MARK: - Private Methods
    
    private func updateToggle3DButtonTitle() {
        toggle3DButton.animateTitleChange(to: toggle3DButtonIcon, withDuration: SYUIExpandableButtonsView.buttonAnimationInterval, andDirection: is3D ? .left : .right)
    }
    
    private func setupExpandableButtons() {
        zoomInButton.setTitle(zoomInButtonIcon, for: .normal)
        zoomOutButton.setTitle(zoomOutButtonIcon, for: .normal)
        toggle3DButton.setTitle(toggle3DButtonIcon, for: .normal)
        
        setExpandableButtons(buttons: [zoomInButton, zoomOutButton, toggle3DButton])
    }
    
    private func setupRecognizers() {
        toggle3DButton.addTarget(self, action: #selector(toggle3DButtonPressed(button:)), for: .touchUpInside)
        zoomInButton.addTarget(self, action: #selector(zoomInButtonPressed(button:)), for: .touchUpInside)
        zoomOutButton.addTarget(self, action: #selector(zoomOutButtonPressed(button:)), for: .touchUpInside)
        
        let zoomInRecognizer = UILongPressGestureRecognizer.init(target: self, action: #selector(zoomInLongRecognized(recognizer:)))
        zoomInRecognizer.minimumPressDuration = 0.2
        let zoomOutRecognizer = UILongPressGestureRecognizer.init(target: self, action: #selector(zoomOutLongRecognized(recognizer:)))
        zoomOutRecognizer.minimumPressDuration = 0.2
        
        zoomInButton.addGestureRecognizer(zoomInRecognizer)
        zoomOutButton.addGestureRecognizer(zoomOutRecognizer)
    }
    
    @objc private func toggle3DButtonPressed(button: SYUIExpandableButton) {
        delegate?.zoomController(self, wants: .toggle3D)
    }
    
    @objc private func zoomInButtonPressed(button: SYUIExpandableButton) {
        delegate?.zoomController(self, wants: .zoomIn)
    }
    
    @objc private func zoomOutButtonPressed(button: SYUIExpandableButton) {
        delegate?.zoomController(self, wants: .zoomOut)
    }
    
    @objc private func zoomInLongRecognized(recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began:
            delegate?.zoomController(self, wants: .startZoomIn)
            zoomingTimer = Timer.scheduledTimer(timeInterval: zoomingTimerInterval, target: self, selector: #selector(updateZoomingIn), userInfo: nil, repeats: true)
        case .ended:
            delegate?.zoomController(self, wants: .stopZooming)
            zoomingTimer?.invalidate()
        default:
            return
        }
    }
    
    @objc private func zoomOutLongRecognized(recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began:
            delegate?.zoomController(self, wants: .startZoomOut)
            zoomingTimer = Timer.scheduledTimer(timeInterval: zoomingTimerInterval, target: self, selector: #selector(updateZoomingOut), userInfo: nil, repeats: true)
        case .ended:
            delegate?.zoomController(self, wants: .stopZooming)
            zoomingTimer?.invalidate()
        default:
            return
        }
    }
    
    @objc private func updateZoomingIn() {
        delegate?.zoomController(self, wants: .zoomingIn)
    }
    
    @objc private func updateZoomingOut() {
        delegate?.zoomController(self, wants: .zoomingOut)
    }
    
}
