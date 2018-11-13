import UIKit
import QuartzCore

class SYUIPinViewBackground: UIView {

    public var pinColor: UIColor?
    {
        didSet {
            pinLabel.textColor = pinColor
            dropShadowLabel.textColor = pinColor
        }
    }
    
    private var pinLabel: UILabel = UILabel()
    
    // MARK: - Life cycle
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 80, height: 72))
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        pinLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        pinLabel.autoresizingMask = []
        pinLabel.text = SygicIcon.pin
        pinLabel.textColor = .textBody
        pinLabel.backgroundColor = .clear
        pinLabel.textAlignment = .center
        pinLabel.numberOfLines = 1
        pinLabel.alpha = 1
        pinLabel.font = SygicFonts.with(SygicFonts.iconFont, size: bounds.height)
        addSubview(pinLabel)
        
        addShadow(color: .shadow)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Shadow creation
    
    private var dropShadowLabel: UILabel = UILabel()

    public func addShadow(color: UIColor) {
        pinLabel.layer.shadowColor = color.cgColor
        pinLabel.layer.shadowOffset = CGSize(width: 0.1, height: 1.1)
        pinLabel.layer.shadowOpacity = 1.0
        pinLabel.layer.shadowRadius = 2
        pinLabel.layer.shouldRasterize = true
        pinLabel.layer.rasterizationScale = UIScreen.main.scale
        
        dropShadowLabel.frame = CGRect(x: 0, y: 18, width: bounds.width, height: bounds.height)
        dropShadowLabel.autoresizingMask = []
        dropShadowLabel.text = SygicIcon.pin
        dropShadowLabel.textColor = .textBody
        dropShadowLabel.backgroundColor = .clear
        dropShadowLabel.textAlignment = .center
        dropShadowLabel.numberOfLines = 1
        dropShadowLabel.font = pinLabel.font
        
        dropShadowLabel.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        dropShadowLabel.layer.shadowColor = color.cgColor
        dropShadowLabel.layer.shadowOffset = CGSize(width: 0.1, height: 44)
        dropShadowLabel.layer.shadowOpacity = 1.0
        dropShadowLabel.layer.shadowRadius = 6
        dropShadowLabel.transform = CGAffineTransform(scaleX: 0.98, y: 0.5)
        dropShadowLabel.layer.shouldRasterize = true
        dropShadowLabel.layer.rasterizationScale = UIScreen.main.scale
        
        insertSubview(dropShadowLabel, belowSubview: pinLabel)
    }
    
}
