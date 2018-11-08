import UIKit

public protocol ActionButtonsDelegate: class {
    func actionButtonPressed(_ button:SYUIActionButton, at index:Int)
}

public class ActionButtonsView: UIView {

    public weak var delegate: ActionButtonsDelegate?
    public private(set) var buttonsStack = UIStackView()
    
    public var buttons: [SYUIActionButton] {
        let buttons = buttonsStack.arrangedSubviews.filter { $0 is SYUIActionButton } as? [SYUIActionButton]
        return buttons ?? [SYUIActionButton]()
    }
    
    private var topConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    private var leftConstraint: NSLayoutConstraint?
    private var rightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(with viewModel: ActionButtonsViewModel) {
        buttonsStack.removeAll()
        buttonsStack.spacing = viewModel.buttonsMargin
        
        viewModel.buttonsViewModels.forEach { buttonsStack.addArrangedSubview(actionButton(with: $0)) }
        
        topConstraint?.constant = viewModel.edgeInsets.top
        bottomConstraint?.constant = viewModel.edgeInsets.bottom
        leftConstraint?.constant = viewModel.edgeInsets.left
        rightConstraint?.constant = viewModel.edgeInsets.right
        superview?.layoutIfNeeded()
    }
    
    private func actionButton(with viewModel: ActionButtonViewModel) -> SYUIActionButton {
        let button = SYUIActionButton()
        button.setup(with: viewModel)
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        button.accessibilityIdentifier = viewModel.accessibilityIdentifier ?? "actionButton"
        return button
    }
    
    @objc private func buttonPressed(sender:SYUIActionButton) {
        if let index = buttonsStack.arrangedSubviews.index(of: sender) {
            delegate?.actionButtonPressed(sender, at: index)
        }
    }
}
