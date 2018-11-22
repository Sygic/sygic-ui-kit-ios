import UIKit

public protocol SYUIPoiDetailAddressDataSource {
    var title: String { get }
    var subtitle: String? { get }
//    var rating: Double { get }
}

public struct SYUIPoiDetailAddressViewModel: SYUIPoiDetailAddressDataSource {
    public var title: String
    public var subtitle: String?
}

public class PoiDetailAddressCell: UITableViewCell {
    
    public static let verticalFrameOffset: CGFloat = 13.0
    
    private let titleLabelHeight:       CGFloat = 28
    private let subtitleLabelHeight:    CGFloat = 22
    private let ratingLabelHeight:      CGFloat = 19
    private let ratingStarFontSize:     CGFloat  = 12
    private let fuelIconFontSize:       CGFloat  = 15
    private let horizontalFrameOffset:  CGFloat = 24
    private var addressCellHeight: CGFloat { return 2 * PoiDetailAddressCell.verticalFrameOffset + titleLabelHeight + subtitleLabelHeight }
    
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    private var ratingLabel: UILabel!
    
    private var ratingLabelHeightConstraint: NSLayoutConstraint!
    private var heightConstraint: NSLayoutConstraint!
    
    private var rating:    Double?
    private let maxRating: Int    = 5
    private var fuelPrice: String = ""
    
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        backgroundColor = .bar
        contentView.backgroundColor = .bar
        titleLabel.textColor = .textTitle
        subtitleLabel.textColor = .textBody
        ratingLabel.textColor = .textBody
    }

 // MARK: - Public Methods
    public func update(with viewModel: SYUIPoiDetailAddressDataSource) {
        update(titleText: viewModel.title)
        update(subtitleText: viewModel.subtitle)
    }
    
    
 // MARK: - Private Methods
    private func setupLayout() {
        backgroundColor = .bar
        contentView.backgroundColor = .bar
        selectionStyle = .none
        
        initializeTitleLabel()
        initializeSubtitleLabel()
        initializeRatingLabel()
        createConstraints()
        
        titleLabel.accessibilityIdentifier = "PoiDetailAddressCell.titleLabel"
    }
    
    private func createLabel(with font: UIFont, color: UIColor) -> UILabel! {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = font
        label.textColor = color
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        
        return label
    }
    
    private func initializeTitleLabel() {
        guard let font = SygicFonts.with(SygicFonts.semiBold, size: SygicFontSize.heading) else { return }
        titleLabel = createLabel(with:font, color: .textTitle)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(margin)-[title]-(>=margin)-|",
                                                                   options: [],
                                                                   metrics: ["margin" : horizontalFrameOffset],
                                                                   views: ["title" : titleLabel]))
    }
    
    private func initializeSubtitleLabel() {
        guard let font = SygicFonts.with(SygicFonts.regular, size: SygicFontSize.body) else { return }
        subtitleLabel = createLabel(with: font, color: .textBody)
        contentView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(margin)-[subtitleLabel]-(>=margin)-|",
                                                                   options: [],
                                                                   metrics: ["margin" : horizontalFrameOffset],
                                                                   views: ["subtitleLabel" : subtitleLabel]))
    }
    
    private func initializeRatingLabel() {
        guard let font = SygicFonts.with(SygicFonts.regular, size: SygicFontSize.bodyOld) else { return }
        ratingLabel = createLabel(with: font, color: .textBody)
        ratingLabel.baselineAdjustment = .alignCenters
        contentView.addSubview(ratingLabel)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(margin)-[ratingLabel]-(>=margin)-|",
                                                                   options: [],
                                                                   metrics: ["margin" : horizontalFrameOffset],
                                                                   views: ["ratingLabel" : ratingLabel]))
        
        ratingLabelHeightConstraint = ratingLabel.heightAnchor.constraint(equalToConstant: 0)
        ratingLabelHeightConstraint.isActive = true
    }
    
    
    private func createConstraints() {
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(offset)-[title][subtitle][rating]",
                                                                   options: [],
                                                                   metrics: ["offset": PoiDetailAddressCell.verticalFrameOffset],
                                                                   views: ["title": titleLabel, "subtitle": subtitleLabel, "rating": ratingLabel]))
        
        heightConstraint = contentView.heightAnchor.constraint(equalToConstant: addressCellHeight)
        heightConstraint.priority = UILayoutPriority(rawValue: 900)
        heightConstraint.isActive = true
    }
    
    private func update(titleText title: String) {
        titleLabel.text = title
    }
    
    private func update(subtitleText subtitle: String?) {
        subtitleLabel.text = subtitle
    }
    
    private func update(ratingValue rating: Double) {
        if rating>=0 {
            self.rating = rating
            updateRatingLabelText()
        }
    }
    
    private func update(fuelPriceText fuelPrice: String) {
        if !fuelPrice.isEmpty {
            self.fuelPrice = fuelPrice
            updateRatingLabelText()
        }
    }
    
    private func showRatingLabel() {
        ratingLabelHeightConstraint.constant = ratingLabelHeight
        heightConstraint.constant = addressCellHeight + ratingLabelHeight
        ratingLabel.alpha = 0
        UIView.animate(withDuration: SYUIConstants.animationDuration, delay: 0, options: .curveEaseInOut, animations: { [unowned self] in
            self.ratingLabel.alpha = 1
        }, completion:nil)
    }
    
    private func hideRatingLabel() {
        rating = nil
        ratingLabelHeightConstraint.constant = 0
        heightConstraint.constant = addressCellHeight
    }
    
    private func ratingsAttributedString() -> NSAttributedString {
        let ratingValue = rating ?? 0.0
        let starsWithText = NSMutableAttributedString()
        
        starsWithText.append(NSAttributedString.starRating(with: ratingValue, outOfTotal: maxRating, fontSize: ratingStarFontSize))
        starsWithText.append(NSAttributedString(string: String(format: "%.1", ratingValue), attributes:textAttributes()))
        
        return starsWithText
    }
    
    private func fuelPriceAttributedString() -> NSAttributedString {
        let attributetText = NSMutableAttributedString()
        attributetText.append(NSAttributedString(string: SygicIcon.fuelPrices, attributes: fuelPriceIconAttributes()))
        attributetText.append(NSAttributedString(string: " \(fuelPrice)", attributes: textAttributes()))
        return attributetText
    }
    
    private func textAttributes() -> [NSAttributedStringKey: Any] {
        guard let font = SygicFonts.with(SygicFonts.regular, size: SygicFontSize.bodyOld) else { return [:] }
        return [.font: font, .foregroundColor: UIColor.textBody]
    }
    
    private func fuelPriceIconAttributes() -> [NSAttributedStringKey: Any] {
        guard let font = SygicFonts.iconFontWith(size: fuelIconFontSize) else { return [:] }
        return [.font: font, .foregroundColor: UIColor.textBody, .baselineOffset: -2.5]
    }
    
    private func clearRatingIfVisible() {
        rating = nil
        updateRatingLabelText()
    }
    
    private func clearFuelPriceIfVisible() {
        fuelPrice = ""
        updateRatingLabelText()
    }
    
    private func updateRatingLabelText() {
        guard rating != nil || !fuelPrice.isEmpty else { return }
        let fuelTypeWasSelected = false //CoreSettings.GetFuelPricesSettings().m_bDefaultFuelChanged;
        let attributetText = NSMutableAttributedString()
        if let _ = rating {
            attributetText.append(ratingsAttributedString())
        }
        if (!fuelPrice.isEmpty && fuelTypeWasSelected) {
            if attributetText.length > 0 {
                attributetText.append(NSAttributedString(string: " "))
            }
            attributetText.append(fuelPriceAttributedString())
        }
        ratingLabel.attributedText = attributetText;
    }
}
