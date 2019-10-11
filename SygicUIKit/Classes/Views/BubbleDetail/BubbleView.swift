//// SYUIBubbleView.swift
//
// Copyright (c) 2019 Sygic a.s.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit


public protocol SYUIBubbleViewDelegate: class {
    func bubbleView(_ view: SYUIBubbleView, didScrollHeader pageIndex: Int)
}

public extension SYUIBubbleViewDelegate {
    func bubbleView(_ view: SYUIBubbleView, didScrollHeader pageIndex: Int) {}
}


public class SYUIBubbleView: UIView {

    // MARK: Public properties
    
    /// Default BubbleView margin constant
    public static let margin: CGFloat = 8
    
    public weak var delegate: SYUIBubbleViewDelegate?
    
    /// Paging indicates if headers will resize automatically according bubbleView width and headerScrollView paging is activated
    public var paging: Bool = true {
        didSet {
            headerScrollView.isPagingEnabled = paging
        }
    }
    
    /// Width constraint created and modified by `addToView(_:landscapeLayout:animated:completion:)`
    public var widthConstraint: NSLayoutConstraint?
    
    /// Trailing constraint created by `addToView(_:landscapeLayout:animated:completion:)`
    public var trailingConstraint: NSLayoutConstraint?
    
    /// StackView container for multiple header views.
    /// Recomended to use `addHeader(with title:, _ description:)` or `addHeader(_ view:)` methods to manage headerStackView content.
    public let headerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    /// StackView for additional dragable expanding content
    public let contentContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    /// StackView container for action buttons inside dragable expanding contentContainer
    public lazy var contentActionsContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = margin
        return stack
    }()
    
    /// StackView container for main action buttons
    public lazy var buttonsContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = margin
        return stack
    }()
    
    // MARK: Private properties
    
    private var margin: CGFloat { SYUIBubbleView.margin }
    private var minConstant: CGFloat { !pager.isHidden ? margin*3 : margin*2 }
    private var maxConstant: CGFloat { contentHeight == 0 ? minConstant : contentHeight + minConstant + margin*2 }
    private var contentHeight: CGFloat { contentContainer.bounds.size.height }
    private var startOffset: CGFloat = 0
    private var topConstraint: NSLayoutConstraint?
    private var variableConstraint: NSLayoutConstraint?
    
    private let dragIndicator: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.widthAnchor.constraint(equalToConstant: 82).isActive = true
        view.heightAnchor.constraint(equalToConstant: 6).isActive = true
        return view
    }()
    
    private lazy var headerScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isPagingEnabled = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.delegate = self
        return scroll
    }()
    
    private let pager: UIPageControl = {
        let pager = UIPageControl()
        pager.currentPageIndicatorTintColor = .accentPrimary
        pager.pageIndicatorTintColor = .powderBlue
        pager.hidesForSinglePage = true
        return pager
    }()
    
    private let gradient = SYUIGradientView()
    
    // MARK: Public methods
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        dragIndicator.isHidden = contentHeight == 0
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        let isLandscape = SYUIDeviceOrientationUtils.isLandscapeLayout(traitCollection)
        updateConstraints(landscapeLayout: isLandscape)
        updateGradientColors()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        updateDragIndicatorColor(true)
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        updateDragIndicatorColor(false)
    }
    
    /// Creates and adds `SYUIBubbleHeader` with provided attributes into headerStackView
    public func addHeader(with title: String?, _ description: String?) {
        let header = SYUIBubbleHeader()
        header.titleLabel.text = title
        header.descriptionLabel.text = description
        addHeader(header)
    }
    
    /// Adds provided UIView as subview into headerStackView. When `paging`property of bubbleView is true width constraint od header view is activated.
    /// - Parameter headerView: header view
    public func addHeader(_ headerView: UIView) {
        headerStackView.addArrangedSubview(headerView)
        if paging {
            headerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        }
        let oldPages = pager.numberOfPages
        let newPages = headerStackView.arrangedSubviews.count
        pager.numberOfPages = newPages
        if newPages > 1 && oldPages <= 1 {
            variableConstraint?.constant = minConstant
        }
    }
    
    /// Creates and adds `SYUIBubbleContentActionButton` with provided attributes inside expandable content container
    /// - Parameter title: title string
    /// - Parameter icon: icon image
    /// - Parameter isEnabled: enables user interactions with button
    /// - Parameter action: touchUpInside event action block
    public func addContentActionButton(title: String, icon: UIImage?, enabled isEnabled: Bool = true, action: SYUIActionBlock?) {
        let button = SYUIBubbleContentActionButton()
        button.titleLabel.text = title
        button.imageView.image = icon
        button.isEnabled = isEnabled
        button.action = action
        if contentActionsContainer.arrangedSubviews.count == 0 {
            contentContainer.setCustomSpacing(margin, after: contentActionsContainer)
        }
        contentActionsContainer.addArrangedSubview(button)
    }
    
    /// Creates and adds `SYUIBubbleContentRow` with provided attributes inside expandable content container
    /// - Parameter icon: icon image
    /// - Parameter title: title string
    /// - Parameter subtitle: subtitle string
    public func addContent(with icon: UIImage, title: String, subtitle: String?, action: SYUIActionBlock? = nil) {
        let view = SYUIBubbleContentRow(with: icon, title: title, subtitle: subtitle)
        view.action = action
        contentContainer.addArrangedSubview(view)
    }
    
    /// Adds provided button inside buttons container
    /// - Parameter button: action button
    public func addActionButton(_ button: SYUIActionButton) {
        buttonsContainer.addArrangedSubview(button)
    }
    
    public func updateHeaderCurrentPage(_ pageIndex: Int, animated: Bool = true) {
        guard paging else { return }
        let pageWidth = headerScrollView.bounds.size.width
        headerScrollView.setContentOffset(CGPoint(x: pageWidth*CGFloat(pageIndex), y: 0), animated: animated)
        pager.currentPage = pageIndex
    }
    
    // MARK: Private methods
    
    private func setupUI() {
        backgroundColor = .accentBackground
        layer.cornerRadius = 24
        clipsToBounds = true
        layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        setupDragIndicator()
        setupHeaderContainers()
        setupContentContainer()
        setupButtonsContainer()
        
        variableConstraint = buttonsContainer.topAnchor.constraint(equalTo: headerScrollView.bottomAnchor, constant: minConstant)
        variableConstraint?.isActive = true
        
        gradient.locations = [0, 1]
        gradient.translatesAutoresizingMaskIntoConstraints = false
        updateGradientColors()
        addSubview(gradient)
        gradient.heightAnchor.constraint(equalToConstant: margin*2).isActive = true
        gradient.bottomAnchor.constraint(equalTo: buttonsContainer.topAnchor).isActive = true
        gradient.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        gradient.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        let contentCover = UIView()
        contentCover.backgroundColor = .accentBackground
        contentCover.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentCover)
        contentCover.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentCover.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        contentCover.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentCover.topAnchor.constraint(equalTo: buttonsContainer.topAnchor).isActive = true
        
        pager.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pager)
        pager.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pager.topAnchor.constraint(equalTo: headerScrollView.bottomAnchor, constant: -margin).isActive = true
        
        bringSubviewToFront(buttonsContainer)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized(_:)))
        addGestureRecognizer(panGestureRecognizer)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized(_:)))
        headerStackView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupDragIndicator() {
        dragIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dragIndicator)
        dragIndicator.topAnchor.constraint(equalTo: topAnchor, constant: margin).isActive = true
        dragIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        updateDragIndicatorColor(false)
    }
    
    private func setupHeaderContainers() {
        headerScrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerScrollView)
        headerScrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        headerScrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        headerScrollView.topAnchor.constraint(equalTo: topAnchor, constant: margin*3).isActive = true
        
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerScrollView.addSubview(headerStackView)
        headerStackView.coverWholeSuperview()
        headerStackView.heightAnchor.constraint(equalTo: headerScrollView.heightAnchor, multiplier: 1.0).isActive = true
    }
    
    private func setupContentContainer() {
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentContainer)
        contentContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
        contentContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
        contentContainer.topAnchor.constraint(equalTo: headerScrollView.bottomAnchor, constant: minConstant).isActive = true
        contentContainer.addArrangedSubview(contentActionsContainer)
    }
    
    private func setupButtonsContainer() {
        buttonsContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonsContainer)
        buttonsContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
        buttonsContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
        buttonsContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin).isActive = true
    }
    
    @objc private func tapGestureRecognized(_ recognizer: UITapGestureRecognizer) {
        guard let constraint = variableConstraint else { return }
        let expanded = constraint.constant > minConstant
        animateViewHeight(!expanded)
        updateDragIndicatorColor(false)
    }
    
    @objc private func panGestureRecognized(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: recognizer.view)
        switch recognizer.state {
        case .began,
             .possible:
            guard let constraint = variableConstraint else { return }
            startOffset = constraint.constant
            updateDragIndicatorColor(true)
        case .changed:
            let offset = startOffset-translation.y
            variableConstraint?.constant = min(maxConstant, max(minConstant, offset))
            setNeedsLayout()
            break
        case .ended,
             .cancelled,
             .failed:
            let expanding = translation.y < 0
            animateViewHeight(expanding)
            updateDragIndicatorColor(false)
            break
        default:
            break
        }
    }
    
    private func animateViewHeight(_ expand: Bool) {
        guard let variableConstraint = variableConstraint else { return }
        variableConstraint.constant = expand ? maxConstant : minConstant
        UIView.animate(withDuration: SYUIConstants.animationDuration, delay: 0, options: [.beginFromCurrentState, .curveEaseOut], animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func updateDragIndicatorColor(_ active: Bool) {
        let alpha: CGFloat = active ? 0.3 : 0.1
        dragIndicator.backgroundColor = UIColor.accentSecondary.withAlphaComponent(alpha)
    }
    
    private func updateGradientColors() {
        guard let color = backgroundColor else { return }
        gradient.colors = [color.withAlphaComponent(0), color]
    }
}

extension SYUIBubbleView: UIScrollViewDelegate {
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x/scrollView.bounds.size.width)
        pager.currentPage = pageIndex
        delegate?.bubbleView(self, didScrollHeader: pageIndex)
    }
}

// MARK: - Layout Orientation

extension SYUIBubbleView {
    
    /// Interface to place and autolayout bubble view inside provided parentView
    /// - Parameter parentView: parentView to insert bubbleView as subview
    /// - Parameter landscapeLayout: if true, bubble view will stick to the side of parentView as compact layout
    /// - Parameter animated: simple alpha fade animation
    /// - Parameter completion: completion block called after all animations
    public func addToView(_ parentView: UIView, landscapeLayout: Bool = true, animated: Bool = false, completion: ((_ finished: Bool)->())? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(self)
        centerYAnchor.constraint(equalTo: parentView.safeBottomAnchor, constant: -margin*2).isActive = true
        leadingAnchor.constraint(equalTo: parentView.safeLeadingAnchor, constant: margin*2).isActive = true
        widthConstraint?.isActive = false
        widthConstraint = widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: 0.4)
        trailingConstraint = trailingAnchor.constraint(equalTo: parentView.safeTrailingAnchor, constant: -margin*2)
        updateConstraints(landscapeLayout: landscapeLayout)
        if animated {
            layoutIfNeeded()
            alpha = 0
            UIView.animate(withDuration: SYUIConstants.animationDuration, animations: {
                self.alpha = 1
            }) { finished in
                completion?(finished)
            }
        } else {
            completion?(true)
        }
    }
    
    /// Updates superview placement of bubbleView. Should be called when traitCollection does change
    /// - Parameter landscapeLayout: if true, bubble view will stick to the side of parentView as compact layout
    public func updateConstraints(landscapeLayout: Bool) {
        if landscapeLayout {
            trailingConstraint?.isActive = false
            widthConstraint?.isActive = true
        } else {
            widthConstraint?.isActive = false
            trailingConstraint?.isActive = true
        }
    }
}
