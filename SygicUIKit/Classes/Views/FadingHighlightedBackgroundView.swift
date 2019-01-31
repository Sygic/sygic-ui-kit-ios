import UIKit


/// Fading highligted background.
internal class FadingHighlightedBackgroundView: UIView {
    
    // MARK: - Public Properties
    
    /// Value of higlighted color.
    public var highlightColor: UIColor?
    
    // MARK: - Public Methods
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Shows highligted background.
    ///
    /// - Parameters:
    ///   - show: Boolean value, whether show highlight or not.
    ///   - animated: Boolean value, whether highlighting is animated or not.
    public func showHighlight(_ show: Bool, animated: Bool = true) {
        let color = show ? highlightColor : .clear
        if animated {
            UIView.animate(withDuration: SYUIConstants.highlightDuration) {
                self.backgroundColor = color
            }
        } else {
            backgroundColor = color
        }
    }
    
    /// Sets background color back to `UIColor.clear` value.
    public func reset() {
        backgroundColor = .clear
    }
}
