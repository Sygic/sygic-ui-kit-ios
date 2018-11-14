import Foundation
import UIKit

public protocol SYUICompassProperties {
    var compassCourse: Double { get set }
    var compassAutoHide: Bool { get set }
}

public protocol SYUICompassDelegate: class {
    func compassDidTap(_ compass: SYUICompass)
}

public class SYUICompass: UIView {
    public weak var delegate: SYUICompassDelegate?
    private let halfRotation = CGFloat(180.0)
    private let COMPASS_BACKGROUND_SIZE = 44.0
    private let COMPASS_BORDER_SIZE = 46.0
    private let compassArrow = SYUICompassArrow()
    private let backgroundView = UIView()
    private let borderView = UIView()
    
    public var viewModel: SYUICompassProperties! {
        didSet {
            if oldValue.compassCourse != viewModel.compassCourse {
                let rotation = CGFloat(viewModel.compassCourse) * .pi / halfRotation
                compassArrow.layer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(rotation)))
                
                if viewModel.compassCourse != oldValue.compassCourse && !isHidden {
                    handleViewAlpha()
                }
            }
            //
            //    private var orientationMode: OrientationMode = .free {
            //        didSet {
            //            if orientationMode != oldValue {
            //                handleViewAlpha()
            //            }
            //        }
            //    }
        }
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        viewModel = SYUICompassViewModel(course: 0, autoHide: false)
        initDefault()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.fullRoundCorners()
        borderView.fullRoundCorners()
    }
    
//    public func setupRx(with mapViewModel: MapViewModel) {
//        mapViewModel.rotation.asDriver()
//            .distinctUntilChanged()
//            .drive(onNext: { [unowned self] rotation in
//                //some imprecision in SYMapView rotation
//                if self.deltaRotation(rotation: rotation) < 0.01 || self.deltaRotation(rotation: rotation) > 359.5 {
//                    self.viewRotation = 0.0
//                } else {
//                    self.viewRotation = rotation
//                }
//            })
//            .disposed(by: disposeBag)
//
//        mapViewModel.orientationMode.asDriver()
//            .distinctUntilChanged()
//            .drive(onNext: { [unowned self] orientationMode in
//                self.orientationMode = orientationMode
//            })
//            .disposed(by: disposeBag)
//    }
//
    private func shouldBeVisible() -> Bool {
        return viewModel.compassCourse != 0 && !viewModel.compassAutoHide
    }
    
    //MARK: - UI
    private func initDefault() {
        alpha = 1
        accessibilityLabel = "native.compas"
        translatesAutoresizingMaskIntoConstraints = false
        let compassSize = CGSize(width: COMPASS_BACKGROUND_SIZE, height: COMPASS_BACKGROUND_SIZE)
        NSLayoutConstraint.activate(widthAndHeightConstraints(with: compassSize))
        createBorderView()
        createBackgroundView()
        createCompassArrow()
        createTapGestureRecognizer()
        
        self.borderView.backgroundColor = UIColor(red:0.09, green:0.11, blue:0.15, alpha:0.1)
        self.backgroundView.backgroundColor = .white
        self.compassArrow.setNeedsDisplay()
        self.setupDefaultShadow()
    }
    
    private func createBackgroundView() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .background
        addSubview(backgroundView)
        backgroundView.coverWholeSuperview()
    }
    
    private func createBorderView() {
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = .iconBackground
        addSubview(borderView)
        borderView.coverWholeSuperview(withMargin: -1.0)
    }
    
    private func createCompassArrow() {
        compassArrow.translatesAutoresizingMaskIntoConstraints = false
        compassArrow.layer.shouldRasterize = true
        compassArrow.backgroundColor = .clear
        
        addSubview(compassArrow)
        compassArrow.coverWholeSuperview()
    }
    
    // MARK: - Actions
    private func createTapGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.compassClicked))
        addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func compassClicked(_ rg: UITapGestureRecognizer) {
        delegate?.compassDidTap(self)
    }
 
    private func handleViewAlpha() {
        if shouldBeVisible() && alpha == 0.0  {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut, .beginFromCurrentState], animations: {
                self.alpha = 1.0
            })
        } else if !shouldBeVisible() && alpha == 1.0 {
            UIView.animate(withDuration: 0.2, delay: 1.0, options: [.curveEaseInOut, .beginFromCurrentState], animations: {
                self.alpha = 0.0
            })
        }
    }
    
    // MARK: - UIViewGeometry
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if (alpha == 0) {
            return false
        }
        var bounds: CGRect = self.bounds
        let hitOffset = CGFloat(10.0)
        bounds = CGRect(x: CGFloat(bounds.origin.x - hitOffset), y: CGFloat(bounds.origin.y - hitOffset), width: CGFloat(bounds.size.width + 2 * hitOffset), height: CGFloat(bounds.size.height + 2 * hitOffset))
        return bounds.contains(point)
    }
    
    private func deltaRotation(rotation: CGFloat) -> CGFloat{
        let delta = halfRotation - abs(rotation - halfRotation)
        return delta
    }
}

//extension Compass: Animating {
//    public func shouldAnimateAlpha() -> Bool {
//        return shouldBeVisible()
//    }
//}
