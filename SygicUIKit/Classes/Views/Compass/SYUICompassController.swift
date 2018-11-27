import Foundation


public protocol SYUICompassDelegate: class {
    func compassDidTap(_ compass: SYUICompass)
}

public class SYUICompassController: NSObject {
    public var compass = SYUICompass()
    public weak var delegate: SYUICompassDelegate?
    private let halfRotation = CGFloat(180.0)
    
    public var course: Double {
        didSet {
            course = course.truncatingRemainder(dividingBy: 360.0)
            compass.rotateArrow(CGFloat(course) * .pi / halfRotation)
            compass.animateVisibility(shouldBeVisible())
        }
    }
    
    public var autoHide: Bool
    
    public init(course: Double = 0.0, autoHide: Bool = true) {
        self.course = course
        self.autoHide = autoHide
        
        super.init()
        
        createTapGestureRecognizer()
    }
    
    private func shouldBeVisible() -> Bool {
        return course != 0 || !autoHide
    }
    
    // MARK: - Actions
    private func createTapGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.compassClicked))
        compass.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func compassClicked(_ rg: UITapGestureRecognizer) {
        delegate?.compassDidTap(compass)
    }
}
