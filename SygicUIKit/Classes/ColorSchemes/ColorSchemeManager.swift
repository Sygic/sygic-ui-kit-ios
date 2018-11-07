import Foundation
import RxSwift
//import SygicNavi
//import RxSygic

public enum ColorSchemeSetting {
    // TODO: toto sa neskor prenesie niekam do settingsov
    case automatic
    case day
    case night
}

public enum ColorScheme {
    case day
    case night
}

public class ColorSchemeManager: NSObject {

    public static let sharedInstance = ColorSchemeManager()
    
    public var currentColorPalette: ColorPalette = DefaultColorPalette()
    public let currentColorScheme = Variable<ColorScheme>(.day)
    public let brightnessMultiplier: (lighter: CGFloat, darker: CGFloat) = (lighter: 1.25, darker: 0.9)
    public let highlightedNavigationBarButtonAlpha: CGFloat = 0.3
    public var isNight: Bool {
        return currentColorScheme.value == .night
    }
    
    public var colorSchemeSetting: ColorSchemeSetting = .day {
        didSet {
            if colorSchemeSetting != oldValue {
                switch colorSchemeSetting {
                case .day:
                    setNewColorScheme(.day)
                    timer.invalidate()
                    break
                case .night:
                    setNewColorScheme(.night)
                    timer.invalidate()
                    break
                    // TODO: vyhodit zmenu day night skinu z UIKitu
//                case .automatic:
//                    scheduleAndFireTimer()
                default:
                    print("TODO: unhandled color scheme")
                }
            }
        }
    }
    
    private var dayColorPalette: ColorPalette?
    private var nightColorPalette: ColorPalette?
//    private let sunStateUtils = SunStateUtils()
    private var timer: Timer!
    
    override init() {
        super.init()
//        scheduleAndFireTimer()
    }
    
    // MARK: - Setting Day & Night palettes
    
    public func setDefaultColorPalettes(dayColorPalette: ColorPalette? = DefaultColorPalette(), nightColorPalette: ColorPalette? = NightColorPalette()) {
        self.dayColorPalette = dayColorPalette
        self.nightColorPalette = nightColorPalette
        
        setNewColorScheme(currentColorScheme.value)
    }
    
    // MARK: - Brightness
    
    public func brightnessMultiplier(for backgroundColor: UIColor, foregroundColor: UIColor) -> CGFloat {
        return backgroundColor.isLighter(than: foregroundColor) ? brightnessMultiplier.darker : brightnessMultiplier.lighter
    }
    
//    // MARK: - Checking for day & night
//    
//    private func scheduleAndFireTimer() {
//        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true, block: { [weak self] _ in
//            DispatchQueue.global().async {
//                self?.checkForDayNightChange()
//            }
//        })
//        timer.fire()
//    }
//
//    public func checkForDayNightChange(location: SYPosition? = SYPositioning.shared().lastKnownLocation, date: Date = Date()) {
//        guard SYContext.isInitialized() else { return }
//
//        if self.colorSchemeSetting != .automatic {
//            self.timer.invalidate()
//            return
//        } else if RxNavigation.shared.isNavigating.value == false {
//            self.setNewColorScheme(.day)
//            return
//        }
//
//        // TODO: datum by bolo vhodne zistit nezavisle na case nastavenom v device, najlepsie z GPS. Mozno SDK by nam ho mohlo nejak vratit
//        let sunState = self.sunStateUtils.getSunState(forLocation: location, andDate: date)
//        switch sunState {
//        case .day, .polarDay:
//            self.setNewColorScheme(.day)
//            break
//        case .night, .polarNight:
//            self.setNewColorScheme(.night)
//            break
//        case .unknown:
//            if self.timer.isValid {
//                // if we didn't get valid sunState for some reason (for example nil location was passed to getSunState method) try again in 1 second
//                self.timer.fireDate = Date(timeIntervalSinceNow: 1)
//            }
//            self.setNewColorScheme(self.currentColorScheme.value)
//        }
//    }
    
    // MARK: Setting new scheme
    
    private func setNewColorScheme(_ colorScheme: ColorScheme) {
        setCurrentColorPalette(for: colorScheme)
        
        if colorScheme != currentColorScheme.value {
            currentColorScheme.value = colorScheme
        }
    }
    
    private func setCurrentColorPalette(for colorScheme: ColorScheme) {
        let newColorPalette = colorScheme == .day ? dayColorPalette : nightColorPalette
        
        if let newColorPalette = newColorPalette {
            currentColorPalette = newColorPalette
        }
    }
}
