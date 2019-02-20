import Foundation


/// Compass controller delegate protocol.
public protocol SYUICompassDelegate: class {
    
    /// Delegate informs, that was tapped on compass.
    ///
    /// - Parameter compass: compass reference, which was tapped.
    func compassDidTap(_ compass: SYUICompass)
}

/// View controller, that manage compass view.
open class SYUICompassController {
    
    // MARK: - Public Properties
    
    /// View, that compass controller manage.
    public var compass = SYUICompass()
    
    /// Sets angle of a compass in degrees.
    ///
    /// If course is 0 degrees, compass is hidden with animation. You can override this behavior in inherited class.
    public var course: Double {
        didSet {
            course = course.truncatingRemainder(dividingBy: 360.0)
            compass.rotateArrow(CGFloat(course) * .pi / halfRotation)
            compass.animateVisibility(shouldBeVisible())
        }
    }
    
    /// Auto hide sets possibility to hide compass, if course is 0, which is north.
    public var autoHide: Bool
    
    /// Compass controller delegate.
    public weak var delegate: SYUICompassDelegate?
    
    // MARK: - Private Properties
    
    private let halfRotation = CGFloat(180.0)
    
    // MARK: - Public Methods
    
    public init(course: Double = 0.0, autoHide: Bool = true) {
        self.course = course
        self.autoHide = autoHide
        
        createTapGestureRecognizer()
    }
    
    // MARK: - Private Methods
    
    private func shouldBeVisible() -> Bool {
        return course.rounded() != 0 || !autoHide
    }
    
    // MARK: Actions
    private func createTapGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.compassClicked))
        compass.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func compassClicked(_ rg: UITapGestureRecognizer) {
        delegate?.compassDidTap(compass)
    }
}
