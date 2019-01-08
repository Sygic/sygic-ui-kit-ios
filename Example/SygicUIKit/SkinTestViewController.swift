import UIKit
import SygicUIKit

class CustomTestColorPallete: SYUIColorPalette {
    var action: UIColor { return UIColor(red: 0.7, green: 0.13, blue: 0.18, alpha: 1) }
}

struct CustomTestFontFamily: SYUIFontFamily {
    public var semiBold: String { return "Oswald-Bold" }
}

class SkinTestViewController: UIViewController {
    
    let customSkin = SYUINightColorPalette()
    
    let defaultSkinButton = SYUIActionButton()
    let nightSkinButton = SYUIActionButton()
    let customSkinButton = SYUIActionButton()
    
    var defaultFontFamily: SYUIFontFamily!
    var customFontFamily: CustomTestFontFamily!
    
    private var poiDetailVC: SYUIPoiDetailViewController?
    private let poiDetailDataSource = PoiDetailTestViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtons()
        
        defaultFontFamily = SYUIFontManager.shared.currentFontFamily
        customFontFamily = CustomTestFontFamily()
        
        updateColors()
        NotificationCenter.default.addObserver(self, selector: #selector(updateColors), name: Notification.Name(ColorPaletteChangedNotification), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let poiDetailVC = SYUIPoiDetailViewController()
        poiDetailVC.dataSource = poiDetailDataSource
        poiDetailVC.presentPoiDetailAsChildViewController(to: self, bounce: true, completion: nil)
        self.poiDetailVC = poiDetailVC
    }
    
    // MARK: Color update
    
    @objc private func updateColors() {
        view.backgroundColor = .background
        navigationController?.navigationBar.tintColor = .action
    }
    
    // MARK: Color scheme switching
    
    @objc private func defaultSkinButtonPressed(_ sender: UIButton) {
        SYUIFontManager.shared.currentFontFamily = defaultFontFamily
        
        SYUIColorSchemeManager.shared.setDefaultColorPalettes()
        SYUIColorSchemeManager.shared.currentColorScheme = .day
    }
    
    @objc private func nightSkinButtonPressed(_ sender: UIButton) {
        SYUIColorSchemeManager.shared.setDefaultColorPalettes()
        SYUIColorSchemeManager.shared.currentColorScheme = .night
    }
    
    @objc private func customSkinButtonPressed(_ sender: UIButton) {
        SYUIFontManager.shared.currentFontFamily = customFontFamily
        
        SYUIColorSchemeManager.shared.setColorPalettes(dayColorPalette: CustomTestColorPallete(), nightColorPalette: nil)
        SYUIColorSchemeManager.shared.currentColorScheme = .day
    }
    
    // MARK: helpers
    
    private func setupButtons() {
        defaultSkinButton.translatesAutoresizingMaskIntoConstraints = false
        defaultSkinButton.title = "Default skin demo"
        defaultSkinButton.addTarget(self, action: #selector(defaultSkinButtonPressed(_:)), for: .touchUpInside)
        
        nightSkinButton.translatesAutoresizingMaskIntoConstraints = false
        nightSkinButton.title = "Night skin demo"
        nightSkinButton.style = .blurred
        nightSkinButton.addTarget(self, action: #selector(nightSkinButtonPressed(_:)), for: .touchUpInside)
        
        customSkinButton.translatesAutoresizingMaskIntoConstraints = false
        customSkinButton.title = "Custom skin demo"
        customSkinButton.style = .secondary
        customSkinButton.titleLabel?.font = UIFont(name: CustomTestFontFamily().semiBold, size: SYUIFontSize.heading)
        customSkinButton.addTarget(self, action: #selector(customSkinButtonPressed(_:)), for: .touchUpInside)
        
        view.addSubview(defaultSkinButton)
        view.addSubview(nightSkinButton)
        view.addSubview(customSkinButton)
        
        defaultSkinButton.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 8).isActive = true
        nightSkinButton.topAnchor.constraint(equalTo: defaultSkinButton.bottomAnchor, constant: 8).isActive = true
        customSkinButton.topAnchor.constraint(equalTo: nightSkinButton.bottomAnchor, constant: 8).isActive = true
        
        defaultSkinButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nightSkinButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        customSkinButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
