
public enum SYUIZoomActivity {
    case zoomIn
    case zoomOut
    case startZoomIn
    case startZoomOut
    case stopZooming
    case zoomingIn
    case zoomingOut
    case toggle3D
}

public protocol SYUIZoomControllerDelegate: class {
    func zoomController(wants activity: SYUIZoomActivity)
}

public class SYUIZoomController: SYUIExpandableButtonsController {
    
    // MARK: - Public Properties
    
    public var is3D = false {
        didSet {
            updateToggle3DButtonTitle()
        }
    }
    
    public var zoomInButtonIcon = SygicIcon.zoomIn {
        didSet {
            zoomInButton.setTitle(zoomInButtonIcon, for: .normal)
        }
    }
    
    public var zoomOutButtonIcon = SygicIcon.zoomOut {
        didSet {
            zoomOutButton.setTitle(zoomOutButtonIcon, for: .normal)
        }
    }
    
    public var icon2D = SygicIcon.view2D {
        didSet {
            toggle3DButton.setTitle(toggle3DButtonIcon, for: .normal)
        }
    }
    
    public var icon3D = SygicIcon.view3D {
        didSet {
            toggle3DButton.setTitle(toggle3DButtonIcon, for: .normal)
        }
    }
    
    public var toggle3DButtonIcon: String {
        return is3D ? icon3D : icon2D
    }
    
    public var zoomingTimerInterval = 0.2
    
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
        delegate?.zoomController(wants: .toggle3D)
    }
    
    @objc private func zoomInButtonPressed(button: SYUIExpandableButton) {
        delegate?.zoomController(wants: .zoomIn)
    }
    
    @objc private func zoomOutButtonPressed(button: SYUIExpandableButton) {
        delegate?.zoomController(wants: .zoomOut)
    }
    
    @objc private func zoomInLongRecognized(recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began:
            delegate?.zoomController(wants: .startZoomIn)
            zoomingTimer = Timer.scheduledTimer(timeInterval: zoomingTimerInterval, target: self, selector: #selector(updateZoomingIn), userInfo: nil, repeats: true)
        case .ended:
            delegate?.zoomController(wants: .stopZooming)
            zoomingTimer?.invalidate()
        default:
            return
        }
    }
    
    @objc private func zoomOutLongRecognized(recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began:
            delegate?.zoomController(wants: .startZoomOut)
            zoomingTimer = Timer.scheduledTimer(timeInterval: zoomingTimerInterval, target: self, selector: #selector(updateZoomingOut), userInfo: nil, repeats: true)
        case .ended:
            delegate?.zoomController(wants: .stopZooming)
            zoomingTimer?.invalidate()
        default:
            return
        }
    }
    
    @objc private func updateZoomingIn() {
        delegate?.zoomController(wants: .zoomingIn)
    }
    
    @objc private func updateZoomingOut() {
        delegate?.zoomController(wants: .zoomingOut)
    }
    
}
