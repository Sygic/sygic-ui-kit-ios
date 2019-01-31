import UIKit
import QuartzCore


/// View class that manages pin icon.
class SYUIPinViewIcon: UIView {
    
    // MARK: - Public Properties
    
    /// Font string value of an icon.
    public var icon: String? {
        didSet {
            iconLabel.text = icon
            iconLabel.font = SYUIFont.with(SYUIFont.iconFont, size: SYUIFontSize.poiIcon)
        }
    }
    
    /// Color of an icon.
    public var iconColor: UIColor? {
        didSet {
            if isSelected {
                iconLabel.textColor = iconColor
                backgroundColor = .textInvert
            }
            else {
                iconLabel.textColor = .textInvert
                backgroundColor = iconColor
            }
        }
    }
    
    /// Boolean value whether pin icon is selected or not.
    public var isSelected: Bool {
        set {
            if newValue {
                backgroundColor = .textInvert
                iconLabel.textColor = iconColor
            }
            else {
                backgroundColor = iconColor
                iconLabel.textColor = .textInvert
            }
        }
        get { return iconLabel.textColor == iconColor }
    }
    
    /// Boolean value whether icon sould show shadow or not.
    public var shouldShowShadow: Bool {
        set { layer.shadowOpacity = newValue ? 1 : 0 }
        get { return layer.shadowOpacity > 0 }
    }
    
    public var iconLabel: UILabel = UILabel()
    
    // MARK: - Public Methods
    
    // MARK: Life cycle
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .textInvert
        clipsToBounds = false
        layer.cornerRadius = bounds.width/2
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        setupShadow(with: 8)

        iconLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        iconLabel.autoresizingMask = []
        iconLabel.backgroundColor = .clear
        iconLabel.textColor = .textBody
        iconLabel.textAlignment = .center
        iconLabel.numberOfLines = 1
        addSubview(iconLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
