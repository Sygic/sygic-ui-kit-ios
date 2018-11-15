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
        let blurredActionButton = SYUIActionButton()
        blurredActionButton.setup(with: blurredButtonViewModel)
        setConstraint(for: blurredActionButton, width: 56.0)

        let mapBackgroundView = MKMapView()
        setConstraint(for: mapBackgroundView, width: 160.0)
        mapBackgroundView.heightAnchor.constraint(equalToConstant: 160.0).isActive = true

        mapBackgroundView.addSubview(blurredActionButton)
        blurredActionButton.centerXAnchor.constraint(equalTo: mapBackgroundView.centerXAnchor).isActive = true
        blurredActionButton.centerYAnchor.constraint(equalTo: mapBackgroundView.centerYAnchor).isActive = true
        buttonStack.addArrangedSubview(mapBackgroundView)

        // Primary, secondary, alert, error...
        let array = [primaryButtonViewModel, primarySubtitledButtonViewModel, secondaryButtonViewModel, primaryButtonViewModel2, secondaryButtonViewModel2, primaryButtonViewModel3, secondaryButtonViewModel3, primaryButtonViewModel4, secondaryButtonViewModel4, loadingButtonViewModel, primaryButtonViewModel6, secondaryButtonViewModel6, primaryProgressBarButtonViewModel, secondaryProgressBarButtonViewModel, plainButtonViewModel]

        for button in array {
            addButton(with: button)
        }

        // Icons, progress - 56x56
        let primaryActionButton5 = SYUIActionButton(frame: .zero)
        primaryActionButton5.setup(with: primaryButtonViewModel5)
        setConstraint(for: primaryActionButton5, width: 56.0)
        buttonStack.addArrangedSubview(primaryActionButton5)

        let secondaryActionButton5 = SYUIActionButton(frame: .zero)
        secondaryActionButton5.setup(with: secondaryButtonViewModel5)
        setConstraint(for: secondaryActionButton5, width: 56.0)
        buttonStack.addArrangedSubview(secondaryActionButton5)

        let progressActionButton = SYUIActionButton(frame: .zero)
        progressActionButton.setup(with: progressRoundButtonViewModel)
        setConstraint(for: progressActionButton, width: 56.0)
        buttonStack.addArrangedSubview(progressActionButton)
    }

    private func addButton(with viewModel: SYUIActionButtonViewModel) {
        let actionButton = SYUIActionButton(frame: .zero)
        actionButton.setup(with: viewModel)
        setConstraint(for: actionButton)
        buttonStack.addArrangedSubview(actionButton)
    }

    private func setConstraint(for view: UIView, width: CGFloat = 320.0) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    private var primaryButtonViewModel: SYUIActionButtonViewModel {
        let icon = ""
        let title = "primary"
        let style = SYUIActionButtonStyle.primary
        let isEnabled = true

        let buttonViewModel = SYUIActionButtonViewModel(title: title, icon: icon, style: style, isEnabled: isEnabled)
        return buttonViewModel
    }

    private var primarySubtitledButtonViewModel: SYUIActionButtonViewModel {
        let icon = ""
        let title = "primary"
        let subtitle = "Subtitle"
        let style = SYUIActionButtonStyle.primary
        let isEnabled = true

        let buttonViewModel = SYUIActionButtonViewModel(title: title, subtitle: subtitle, icon: icon, style: style, isEnabled: isEnabled)
        return buttonViewModel
    }

    private var secondaryButtonViewModel: SYUIActionButtonViewModel {
        let icon = ""
        let title = "secondary"
        let style = SYUIActionButtonStyle.secondary
        let isEnabled = true

        let buttonViewModel = SYUIActionButtonViewModel(title: title, icon: icon, style: style, isEnabled: isEnabled)
        return buttonViewModel
    }

    private var primaryButtonViewModel2: SYUIActionButtonViewModel {
        let icon = SygicIcon.directionsAction
        let title = "Get directions Get directions"
        let style = SYUIActionButtonStyle.primary
        let isEnabled = true

        let buttonViewModel = SYUIActionButtonViewModel(title: title, icon: icon, style: style, isEnabled: isEnabled)
        return buttonViewModel
    }

    private var secondaryButtonViewModel2: SYUIActionButtonViewModel {
        let icon = SygicIcon.pinPlace
        let title = "Add waypoint"
        let style = SYUIActionButtonStyle.secondary
        let isEnabled = true

        let buttonViewModel = SYUIActionButtonViewModel(title: title, icon: icon, style: style, isEnabled: isEnabled)
        return buttonViewModel
    }

    private var blurredButtonViewModel: SYUIActionButtonViewModel {
        let icon = SygicIcon.close
        let title = ""
        let style = SYUIActionButtonStyle.blurred
        let isEnabled = true

        let buttonViewModel = SYUIActionButtonViewModel(title: title, icon: icon, style: style, isEnabled: isEnabled)
        return buttonViewModel
    }

    private var primaryButtonViewModel3: SYUIActionButtonViewModel {
        let icon = SygicIcon.directionsAction
        let title = "Done"
        let style = SYUIActionButtonStyle.primary
        let isEnabled = true

        let buttonViewModel = SYUIActionButtonViewModel(title: title, icon: icon, style: style, height: 40, isEnabled: isEnabled)
        return buttonViewModel
    }

    private var secondaryButtonViewModel3: SYUIActionButtonViewModel {
        let icon = SygicIcon.pinPlace
        let title = "Add waypoint"
        let style = SYUIActionButtonStyle.secondary
        let isEnabled = true

        let buttonViewModel = SYUIActionButtonViewModel(title: title, icon: icon, style: style, height: 40, isEnabled: isEnabled)
        return buttonViewModel
    }

    private var primaryButtonViewModel4: SYUIActionButtonViewModel {
        let icon = ""
        let title = "Label"
        let style = SYUIActionButtonStyle.primary
        let isEnabled = false

        let buttonViewModel = SYUIActionButtonViewModel(title: title, icon: icon, style: style, isEnabled: isEnabled)
        return buttonViewModel
    }

    private var secondaryButtonViewModel4: SYUIActionButtonViewModel {
        let icon = SygicIcon.directionsAction
        let title = "Label"
        let style = SYUIActionButtonStyle.secondary
        let isEnabled = false

        let buttonViewModel = SYUIActionButtonViewModel(title: title, icon: icon, style: style, isEnabled: isEnabled)
        return buttonViewModel
    }

    private var loadingButtonViewModel: SYUIActionButtonViewModel {
        let icon = ""
        let title = "Calculating route"
        let style = SYUIActionButtonStyle.loading
        let isEnabled = false

        let buttonViewModel = SYUIActionButtonViewModel(title: title, icon: icon, style: style, isEnabled: isEnabled)
        return buttonViewModel
    }

    private var primaryButtonViewModel5: SYUIActionButtonViewModel {
        let icon = SygicIcon.directionsAction
        let title = ""
        let style = SYUIActionButtonStyle.primary
        let isEnabled = true

        let buttonViewModel = SYUIActionButtonViewModel(title: title, icon: icon, style: style, isEnabled: isEnabled)
        return buttonViewModel
    }

    private var secondaryButtonViewModel5: SYUIActionButtonViewModel {
        let icon = SygicIcon.directionsAction
        let title = ""
        let style = SYUIActionButtonStyle.secondary
        let isEnabled = true

        let buttonViewModel = SYUIActionButtonViewModel(title: title, icon: icon, style: style, isEnabled: isEnabled)
        return buttonViewModel
    }

    private var primaryButtonViewModel6: SYUIActionButtonViewModel {
        let icon = ""
        let title = "Error"
        let style = SYUIActionButtonStyle.error
        let isEnabled = true

        let buttonViewModel = SYUIActionButtonViewModel(title: title, icon: icon, style: style, isEnabled: isEnabled)
        return buttonViewModel
    }

    private var secondaryButtonViewModel6: SYUIActionButtonViewModel {
        let icon = ""
        let title = "Alert"
        let style = SYUIActionButtonStyle.alert
        let isEnabled = true

        let buttonViewModel = SYUIActionButtonViewModel(title: title, icon: icon, style: style, isEnabled: isEnabled)
        return buttonViewModel
    }

    private var progressRoundButtonViewModel: SYUIActionButtonViewModel {
        let icon = SygicIcon.close
        let title = ""
        let style = SYUIActionButtonStyle.secondary
        let isEnabled = true
        let duration = 9.0

        let buttonViewModel = SYUIActionButtonViewModel(title: title, icon: icon, style: style, isEnabled: isEnabled, countdown: duration)

        return buttonViewModel
    }

    private var primaryProgressBarButtonViewModel: SYUIActionButtonViewModel {
        let icon = ""
        let title = "Start"
        let style = SYUIActionButtonStyle.primary
        let isEnabled = true
        let duration = 9.0

        let buttonViewModel = SYUIActionButtonViewModel(title: title, icon: icon, style: style, isEnabled: isEnabled, countdown: duration)
        return buttonViewModel
    }

    private var secondaryProgressBarButtonViewModel: SYUIActionButtonViewModel {
        let icon = ""
        let title = "Resume"
        let style = SYUIActionButtonStyle.secondary
        let isEnabled = true
        let duration = 9.0

        let buttonViewModel = SYUIActionButtonViewModel(title: title, icon: icon, style: style, isEnabled: isEnabled, countdown: duration)
        return buttonViewModel
    }

    private var plainButtonViewModel: SYUIActionButtonViewModel {
        let icon = ""
        let title = "Forgot password"
        let style = SYUIActionButtonStyle.plain
        let isEnabled = true

        let buttonViewModel = SYUIActionButtonViewModel(title: title, icon: icon, style: style, isEnabled: isEnabled)
        return buttonViewModel
    }
}
