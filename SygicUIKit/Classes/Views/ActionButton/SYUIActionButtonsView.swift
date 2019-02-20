import UIKit


/// Action buttons delegate protocol.
public protocol SYUIActionButtonsDelegate: class {
    func actionButtonPressed(_ button: SYUIActionButton, at index:Int)
}

/// View that contains multiple action buttons.
public class SYUIActionButtonsView: UIView {
    
    // MARK: - Public Properties

    /// Action buttons delegate.
    public weak var delegate: SYUIActionButtonsDelegate?
    
    /// Array of action buttons in a view.
    public var buttons: [SYUIActionButton] = [SYUIActionButton]() {
        didSet {
            updateLayout()
        }
    }
    
    /// Stack of action buttons.
    public private(set) var buttonsStack = UIStackView()
    
    // MARK: - Private Properties
    
    private var buttonsMargin: CGFloat = 16.0
    private var edgeInsets = UIEdgeInsetsMake(20.0, 8.0, 0, -8.0)
    private var topConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    private var leftConstraint: NSLayoutConstraint?
    private var rightConstraint: NSLayoutConstraint?
    
    // MARK: - Public Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods.
    
    private func updateLayout() {
        buttonsStack.removeAll()
        buttonsStack.spacing = buttonsMargin
        
        buttons.forEach { button in
            buttonsStack.addArrangedSubview(button)
            button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        }
        
        topConstraint?.constant = edgeInsets.top
        bottomConstraint?.constant = edgeInsets.bottom
        leftConstraint?.constant = edgeInsets.left
        rightConstraint?.constant = edgeInsets.right
        superview?.layoutIfNeeded()
    }
    
    private func setup() {
        backgroundColor = .bar
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.alignment = .fill
        buttonsStack.axis = .vertical
        addSubview(buttonsStack)
        
        leftConstraint = buttonsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        leftConstraint?.isActive = true
        
        rightConstraint = buttonsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        rightConstraint?.isActive = true
        
        topConstraint = buttonsStack.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        topConstraint?.isActive = true
        
        bottomConstraint = buttonsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        bottomConstraint?.isActive = true
    }
    
    @objc private func buttonPressed(sender:SYUIActionButton) {
        if let index = buttonsStack.arrangedSubviews.index(of: sender) {
            delegate?.actionButtonPressed(sender, at: index)
        }
    }
}
