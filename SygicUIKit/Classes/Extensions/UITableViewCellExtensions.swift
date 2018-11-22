import UIKit

// MARK: - Highlighting

public extension UITableViewCell {
    
    internal var highlightingView: FadingHighlightedBackgroundView? {
        for subview in subviews {
            if let highView = subview as? FadingHighlightedBackgroundView {
                return highView
            }
        }
        return nil
    }
    
    public func setupHighlightingView() {
        selectedBackgroundView = UIView()
        
        let highlightedView = FadingHighlightedBackgroundView(frame: .zero)
        highlightedView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(highlightedView)
        sendSubview(toBack: highlightedView)
        highlightedView.coverWholeSuperview()
    }
    
    public func highlightCell(_ highlighted: Bool, backgroundColor: UIColor?, foregroundColor: UIColor?) {
        guard let backgroundColor = backgroundColor, let foregroundColor = foregroundColor, let highlightingView = highlightingView else { return }
        let multiplier = ColorSchemeManager.sharedInstance.brightnessMultiplier(for: backgroundColor, foregroundColor: foregroundColor)
        highlightingView.highlightColor = backgroundColor.adjustBrightness(with: multiplier)
        highlightingView.showHighlight(highlighted)
    }
}
