import UIKit

public class FadingHighlightedBackgroundView: UIView {
    public var highlightColor: UIColor?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func showHighlight(_ show: Bool, animated: Bool = true) {
        let color = show ? highlightColor : .clear
        if animated {
            UIView.animate(withDuration: ConstantsUI.highlightDuration) {
                self.backgroundColor = color
            }
        } else {
            backgroundColor = color
        }
    }
    
    public func reset() {
        backgroundColor = .clear
    }
}
