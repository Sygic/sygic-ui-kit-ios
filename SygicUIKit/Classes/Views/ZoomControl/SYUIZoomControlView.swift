public enum SYUIZoomControlActivity {
    case zoomIn
    case zoomOut
    case startZoomIn
    case startZoomOut
    case stopZooming
    case toggle3D
}

public protocol SYUIZoomControlViewDelegate: class {
    func zoomControl(wants activity: SYUIZoomControlActivity)
}

public protocol SYUIZoomControlProperties {
    var icon2D: String { get }
    var icon3D: String { get }
    var iconZoomIn: String { get }
    var iconZoomOut: String { get }
    var iconToggle3D: String { get }
    var is3D: Bool { get }
}

public class SYUIZoomControlView: SYUIExpandableButtonsView {
    
    private let zoomInButton = SYUIExpandableButton(withType: .icon)
    private let zoomOutButton = SYUIExpandableButton(withType: .icon)
    private let toggle3DButton = SYUIExpandableButton(withType: .icon)
    
    public weak var delegate: SYUIZoomControlViewDelegate?
    
    public var viewModel: SYUIZoomControlProperties? {
        didSet {
            guard let viewModel = viewModel else { return }
            zoomInButton.setTitle(viewModel.iconZoomIn, for: .normal)
            zoomOutButton.setTitle(viewModel.iconZoomOut, for: .normal)
            toggle3DButton.setTitle(viewModel.iconToggle3D, for: .normal)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupRecognizers()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func initDefaults() {
        super.initDefaults()
        expandableButtons.append(zoomOutButton)
        expandableButtons.append(zoomInButton)
        expandableButtons.append(toggle3DButton)
        
        toggle3DButton.addTarget(self, action: #selector(toggle3DButtonPressed(button:)), for: .touchUpInside)
        zoomInButton.addTarget(self, action: #selector(zoomInButtonPressed(button:)), for: .touchUpInside)
        zoomOutButton.addTarget(self, action: #selector(zoomOutButtonPressed(button:)), for: .touchUpInside)
    }
    
    override public func expandButtons() {
        updateToggle3DButtonTitle()
        super.expandButtons()
    }
    
    // MARK: - Private Methods
    
    private func updateToggle3DButtonTitle() {
        guard let viewModel = viewModel else { return }
        
        let buttonTitle = toggle3DButton.title(for: .normal)
        let newTitle = viewModel.iconToggle3D
        if buttonTitle == newTitle { return }
        toggle3DButton.animateTitleChange(to: newTitle, withDuration: SYUIExpandableButtonsView.buttonAnimationInterval, andDirection: viewModel.is3D ? .left : .right)
    }
    
    private func setupRecognizers() {
        let zoomInRecognizer = UILongPressGestureRecognizer.init(target: self, action: #selector(zoomInLongRecognized(recognizer:)))
        zoomInRecognizer.minimumPressDuration = 0.2
        
        let zoomOutRecognizer = UILongPressGestureRecognizer.init(target: self, action: #selector(zoomOutLongRecognized(recognizer:)))
        zoomOutRecognizer.minimumPressDuration = 0.2
        
        zoomInButton.addGestureRecognizer(zoomInRecognizer)
        zoomOutButton.addGestureRecognizer(zoomOutRecognizer)
    }
    
    @objc private func toggle3DButtonPressed(button: SYUIExpandableButton) {
        delegate?.zoomControl(wants: .toggle3D)
        updateToggle3DButtonTitle()
    }
    
    @objc private func zoomInButtonPressed(button: SYUIExpandableButton) {
        delegate?.zoomControl(wants: .zoomIn)
    }
    
    @objc private func zoomOutButtonPressed(button: SYUIExpandableButton) {
        delegate?.zoomControl(wants: .zoomOut)
    }
    
    @objc private func zoomInLongRecognized(recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began:
            delegate?.zoomControl(wants: .startZoomIn)
        case .ended:
            delegate?.zoomControl(wants: .stopZooming)
        default:
            return
        }
    }
    
    @objc private func zoomOutLongRecognized(recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began:
            delegate?.zoomControl(wants: .startZoomOut)
        case .ended:
            delegate?.zoomControl(wants: .stopZooming)
        default:
            return
        }
    }
    
}
