import UIKit
import QuartzCore

class SYUIPinViewIcon: UIView {
    
    public var icon: String? {
        didSet {
            iconLabel.text = icon
            iconLabel.font = SygicFonts.with(SygicFonts.iconFont, size: SygicFontSize.poiIcon)
        }
    }
    
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
    
    public var shouldShowShadow: Bool {
        set { layer.shadowOpacity = newValue ? 1 : 0 }
        get { return layer.shadowOpacity > 0 }
    }
    
    public var iconLabel: UILabel = UILabel()
    
    // MARK: - Life cycle
    
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
