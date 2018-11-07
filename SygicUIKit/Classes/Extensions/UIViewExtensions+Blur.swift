import RxSwift

public extension UIView {
    
    @discardableResult public func blur(with color: UIColor?, style: UIBlurEffectStyle, margin: CGFloat = 0.0) -> UIVisualEffectView {
        let effectView = blurEffectView(with: style)
        if let color = color, color != .clear {
            let colorOverlay = colorOverlayView(with: color)
            effectView.contentView.addSubview(colorOverlay)
            colorOverlay.coverWholeSuperview()
        }
        addSubview(effectView)
        sendSubview(toBack: effectView)
        effectView.coverWholeSuperview(withMargin: margin)
        return effectView
    }
    
    public func addBlurViewWithMapControlsBlurStyle(margin: CGFloat = 0.0, disposedBy disposeBag: DisposeBag) -> UIVisualEffectView? {
        let effectView = blur(with: nil, style: .light, margin: margin)
        let colorOverlayView = self.colorOverlayView(with: .mapInfoBackground)
        
        ColorSchemeManager.sharedInstance.currentColorScheme.asDriver().drive(onNext: { _ in
            colorOverlayView.backgroundColor = .mapInfoBackground
        }).disposed(by: disposeBag)
        
        effectView.contentView.addSubview(colorOverlayView)
        colorOverlayView.coverWholeSuperview()
        return effectView
    }
    
// MARK: Private
    private func blurEffectView(with style: UIBlurEffectStyle) -> UIVisualEffectView {
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        effectView.translatesAutoresizingMaskIntoConstraints = false
        effectView.contentView.layer.cornerRadius = layer.cornerRadius
        effectView.layer.cornerRadius = layer.cornerRadius
        effectView.clipsToBounds = true
        effectView.isUserInteractionEnabled = false
        return effectView
    }
    private func colorOverlayView(with color: UIColor) -> UIView {
        let transparentView = UIView()
        transparentView.translatesAutoresizingMaskIntoConstraints = false
        transparentView.layer.cornerRadius = layer.cornerRadius
        transparentView.backgroundColor = color
        transparentView.isUserInteractionEnabled = false
        return transparentView
    }
}

