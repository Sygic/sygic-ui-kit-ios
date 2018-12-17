import UIKit
import SygicUIKit

class SkinTestViewController: UIViewController {
    
    let customSkin = SYUINightColorPalette()
    
    let defaultSkinButton = SYUIActionButton()
    let nightSkinButton = SYUIActionButton()
    let customSkinButton = SYUIActionButton()
    
    private let poiDetailVC = SYUIPoiDetailViewController()
    private let poiDetailDataSource = PoiDetailTestViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtons()
        
        updateColors()
        NotificationCenter.default.addObserver(self, selector: #selector(updateColors), name: Notification.Name(ColorPaletteChangedNotification), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        poiDetailVC.dataSource = poiDetailDataSource
        poiDetailVC.presentPoiDetailAsChildViewController(to: self, bounce: true, completion: nil)
    }
    
    // MARK: Color update
    
    @objc private func updateColors() {
        view.backgroundColor = .background
        
        defaultSkinButton.style = .primary
        nightSkinButton.style = .blurred
        customSkinButton.style = .secondary
        
        poiDetailVC.reloadData()
        
        navigationController?.navigationBar.tintColor = .action
    }
    
    // MARK: Color scheme switching
    
    @objc private func defaultSkinButtonPressed(_ sender: UIButton) {
        SYUIColorSchemeManager.shared.setDefaultColorPalettes()
        SYUIColorSchemeManager.shared.currentColorScheme = .day
    }
    
    @objc private func nightSkinButtonPressed(_ sender: UIButton) {
        SYUIColorSchemeManager.shared.setDefaultColorPalettes()
        SYUIColorSchemeManager.shared.currentColorScheme = .night
    }
    
    @objc private func customSkinButtonPressed(_ sender: UIButton) {
        SYUIColorSchemeManager.shared.setDefaultColorPalettes(dayColorPalette: CustomTestColorPallete(), nightColorPalette: nil)
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

class CustomTestColorPallete: SYUIColorPalette {
    var action: UIColor { return UIColor(red: 0.7, green: 0.13, blue: 0.18, alpha: 1) }
}
