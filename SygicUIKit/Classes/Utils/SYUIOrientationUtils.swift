
public enum SYUIDeviceOrientation {
    case portrait
    case landscape
    
    public func isPortrait() -> Bool {
        return self == .portrait
    }
    
    public func isLandscape() -> Bool {
        return !isPortrait()
    }
}

public class SYUIDeviceOrientationUtils {
    
    public static func orientation(for size: CGSize) -> SYUIDeviceOrientation {
        return size.height > size.width ? .portrait : .landscape
    }
    
    public static func orientationSize(for portrait: CGFloat, landscape: CGFloat, traitCollection: UITraitCollection) -> CGFloat {
        return self.isLandscape(traitCollection) ? landscape : portrait
    }
    
    public static func orientationSize(for portrait: CGFloat, landscape: CGFloat) -> CGFloat {
        guard let traitCollection = self.currentTraitCollection() else { return portrait }
        return self.orientationSize(for: portrait, landscape: landscape, traitCollection: traitCollection)
    }
    
    public static func currentTraitCollection() -> UITraitCollection? {
        return UIApplication.shared.keyWindow?.traitCollection
    }
    
    public static func isLandscape(_ traitCollection: UITraitCollection) -> Bool {
        return UIApplication.shared.statusBarOrientation.isLandscape
    }
    
    public static func isLandscape() -> Bool {
        guard let traitCollection = self.currentTraitCollection() else { return false }
        return self.isLandscape(traitCollection)
    }
    
    public static func isPortrait(_ traitCollection: UITraitCollection) -> Bool {
        return (traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass != traitCollection.horizontalSizeClass);
    }
    
    public static func isPortrait() -> Bool {
        if let traitCollection = self.currentTraitCollection() {
            return self.isPortrait(traitCollection)
        }
        return false
    }
    
    public static func currentOrientation() -> UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
}
