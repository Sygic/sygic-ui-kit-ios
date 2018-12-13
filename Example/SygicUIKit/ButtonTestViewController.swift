import UIKit
import SygicUIKit
import MapKit

class ButtonTestViewController: UIViewController {

    let buttonStack = UIStackView()
    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.coverWholeSuperview()

        view.backgroundColor = .bar
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.alignment = .center
        buttonStack.axis = .vertical
        buttonStack.spacing = 16.0
        buttonStack.distribution = .equalSpacing

        scrollView.addSubview(buttonStack)
        buttonStack.coverWholeSuperview(withMargin: 16)
        buttonStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        setupButtons()
    }

    private func setupButtons() {
        // BLURRED with map background
        let blurredActionButton = blurredButton
        setConstraint(for: blurredActionButton, width: 56.0)

        let mapBackgroundView = MKMapView()
        setConstraint(for: mapBackgroundView, width: 160.0)
        mapBackgroundView.heightAnchor.constraint(equalToConstant: 160.0).isActive = true

        mapBackgroundView.addSubview(blurredActionButton)
        blurredActionButton.centerXAnchor.constraint(equalTo: mapBackgroundView.centerXAnchor).isActive = true
        blurredActionButton.centerYAnchor.constraint(equalTo: mapBackgroundView.centerYAnchor).isActive = true
        buttonStack.addArrangedSubview(mapBackgroundView)

        // Primary, secondary, alert, error...
        let array = [primaryButton,
                     primarySubtitledButton,
                     secondaryButton,
                     primaryButton2,
                     secondaryButton2,
                     primaryButton3,
                     secondaryButton3,
                     primaryButton4,
                     secondaryButton4,
                     loadingButton,
                     primaryButton6,
                     secondaryButton6,
                     primaryProgressBarButton,
                     secondaryProgressBarButton,
                     plainButton]

        for button in array {
            addButton(button)
        }

        // Icons, progress - 56x56
        setConstraint(for: primaryButton5, width: 56.0)
        buttonStack.addArrangedSubview(primaryButton5)

        setConstraint(for: secondaryButton5, width: 56.0)
        buttonStack.addArrangedSubview(secondaryButton5)

        setConstraint(for: progressRoundButton, width: 56.0)
        buttonStack.addArrangedSubview(progressRoundButton)
    }

    private func addButton(_ actionButton: SYUIActionButton) {
        setConstraint(for: actionButton)
        buttonStack.addArrangedSubview(actionButton)
    }

    private func setConstraint(for view: UIView, width: CGFloat = 320.0) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    private var primaryButton: SYUIActionButton {
        let button = SYUIActionButton()
        button.icon = ""
        button.title = "primary"
        button.style = SYUIActionButtonStyle.primary
        button.isEnabled = true

        return button
    }

    private var primarySubtitledButton: SYUIActionButton {
        let button = SYUIActionButton()
        button.icon = ""
        button.title = "primary"
        button.subtitle = "Subtitle"
        button.style = SYUIActionButtonStyle.primary
        button.isEnabled = true
        return button
    }

    private var secondaryButton: SYUIActionButton {
        let button = SYUIActionButton()
        button.icon = ""
        button.title = "secondary"
        button.style = SYUIActionButtonStyle.secondary
        button.isEnabled = true
        return button
    }

    private var primaryButton2: SYUIActionButton {
        let button = SYUIActionButton()
        button.icon = SYUIIcon.directionsAction
        button.title = "Get directions Get directions"
        button.style = SYUIActionButtonStyle.primary
        button.isEnabled = true
        return button
    }

    private var secondaryButton2: SYUIActionButton {
        let button = SYUIActionButton()
        button.icon = SYUIIcon.pinPlace
        button.title = "Add waypoint"
        button.style = SYUIActionButtonStyle.secondary
        button.isEnabled = true
        return button
    }

    private var blurredButton: SYUIActionButton {
        let button = SYUIActionButton()
        button.icon = SYUIIcon.close
        button.title = ""
        button.style = SYUIActionButtonStyle.blurred
        button.isEnabled = true
        return button
    }

    private var primaryButton3: SYUIActionButton {
        let button = SYUIActionButton()
        button.icon = SYUIIcon.directionsAction
        button.title = "Done"
        button.style = SYUIActionButtonStyle.primary
        button.isEnabled = true
        button.height = 40
        return button
    }

    private var secondaryButton3: SYUIActionButton {
        let button = SYUIActionButton()
        button.icon = SYUIIcon.pinPlace
        button.title = "Add waypoint"
        button.style = SYUIActionButtonStyle.secondary
        button.isEnabled = true
        button.height = 40
        return button
    }

    private var primaryButton4: SYUIActionButton {
        let button = SYUIActionButton()
        button.icon = ""
        button.title = "Label"
        button.style = SYUIActionButtonStyle.primary
        button.isEnabled = false
        return button
    }

    private var secondaryButton4: SYUIActionButton {
        let button = SYUIActionButton()
        button.icon = SYUIIcon.directionsAction
        button.title = "Label"
        button.style = SYUIActionButtonStyle.secondary
        button.isEnabled = false
        return button
    }

    private var loadingButton: SYUIActionButton {
        let button = SYUIActionButton()
        button.icon = ""
        button.title = "Calculating route"
        button.style = SYUIActionButtonStyle.loading
        button.isEnabled = false
        return button
    }

    private var primaryButton5: SYUIActionButton {
        let button = SYUIActionButton()
        button.icon = SYUIIcon.directionsAction
        button.title = ""
        button.style = SYUIActionButtonStyle.primary
        button.isEnabled = true
        return button
    }

    private var secondaryButton5: SYUIActionButton {
        let button = SYUIActionButton()
        button.icon = SYUIIcon.directionsAction
        button.title = ""
        button.style = SYUIActionButtonStyle.secondary
        button.isEnabled = true
        return button
    }

    private var primaryButton6: SYUIActionButton {
        let button = SYUIActionButton()
        button.icon = ""
        button.title = "Error"
        button.style = SYUIActionButtonStyle.error
        button.isEnabled = true
        return button
    }

    private var secondaryButton6: SYUIActionButton {
        let button = SYUIActionButton()
        button.icon = ""
        button.title = "Alert"
        button.style = SYUIActionButtonStyle.alert
        button.isEnabled = true
        return button
    }

    private var progressRoundButton: SYUIActionButton {
        let button = SYUIActionButton()
        button.icon = SYUIIcon.close
        button.title = ""
        button.style = SYUIActionButtonStyle.secondary
        button.isEnabled = true
        button.countdown = 9.0
        return button
    }

    private var primaryProgressBarButton: SYUIActionButton {
        let button = SYUIActionButton()
        button.icon = ""
        button.title = "Start"
        button.style = SYUIActionButtonStyle.primary
        button.isEnabled = true
        button.countdown = 9.0
        return button
    }

    private var secondaryProgressBarButton: SYUIActionButton {
        let button = SYUIActionButton()
        button.icon = ""
        button.title = "Resume"
        button.style = SYUIActionButtonStyle.secondary
        button.isEnabled = true
        button.countdown = 9.0
        return button
    }

    private var plainButton: SYUIActionButton {
        let button = SYUIActionButton()
        button.icon = ""
        button.title = "Forgot password"
        button.style = SYUIActionButtonStyle.plain
        button.isEnabled = true
        return button
    }
}
