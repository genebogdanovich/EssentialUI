//
//  BottomSheetViewController.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 18.05.22.
//

import SwiftUI

class BottomSheetViewController<Content: View>: UIViewController, UISheetPresentationControllerDelegate {
    
    // MARK: Properties
    
    @Binding private var isPresented: Bool
    
    private let detents: [UISheetPresentationController.Detent]
    private let largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?
    private let prefersGrabberVisible: Bool
    private let prefersScrollingExpandsWhenScrolledToEdge: Bool
    private let prefersEdgeAttachedInCompactHeight: Bool
    @Binding private var selectedDetentIdentifier: UISheetPresentationController.Detent.Identifier?
    private let widthFollowsPreferredContentSizeWhenEdgeAttached: Bool
    private let preferredCornerRadius: CGFloat?
    
    private let contentView: UIHostingController<Content>
    
    // MARK: Initialization
    
    init(
        isPresented: Binding<Bool>,
        detents: [UISheetPresentationController.Detent] = [.medium(), .large()],
        largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = nil,
        prefersGrabberVisible: Bool = false,
        prefersScrollingExpandsWhenScrolledToEdge: Bool = true,
        prefersEdgeAttachedInCompactHeight: Bool = false,
        selectedDetentIdentifier: Binding<UISheetPresentationController.Detent.Identifier?> = Binding.constant(nil),
        widthFollowsPreferredContentSizeWhenEdgeAttached: Bool = false,
        isModalInPresentation: Bool = false,
        preferredCornerRadius: CGFloat? = nil,
        content: Content
    ) {
        _isPresented = isPresented
        
        self.detents = detents
        self.largestUndimmedDetentIdentifier = largestUndimmedDetentIdentifier
        self.prefersGrabberVisible = prefersGrabberVisible
        self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
        self.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
        self._selectedDetentIdentifier = selectedDetentIdentifier
        self.widthFollowsPreferredContentSizeWhenEdgeAttached = widthFollowsPreferredContentSizeWhenEdgeAttached
        self.preferredCornerRadius = preferredCornerRadius
        
        self.contentView = UIHostingController(rootView: content)
        
        super.init(nibName: nil, bundle: nil)
        self.isModalInPresentation = isModalInPresentation
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(contentView)
        view.addSubview(contentView.view)
        
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.view.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = detents
            presentationController.largestUndimmedDetentIdentifier = largestUndimmedDetentIdentifier
            presentationController.prefersGrabberVisible = prefersGrabberVisible
            presentationController.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
            presentationController.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
            presentationController.selectedDetentIdentifier = selectedDetentIdentifier
            presentationController.widthFollowsPreferredContentSizeWhenEdgeAttached = widthFollowsPreferredContentSizeWhenEdgeAttached
            presentationController.preferredCornerRadius = preferredCornerRadius
            presentationController.delegate = self
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        isPresented = false
    }
    
    // MARK: Helpers
    
    func updateSelectedDetentIdentifier(_ selectedDetentIdentifier: UISheetPresentationController.Detent.Identifier?) {
        self.sheetPresentationController?.animateChanges {
            self.sheetPresentationController?.selectedDetentIdentifier = selectedDetentIdentifier
        }
    }
    
    // MARK: UISheetPresentationControllerDelegate
    
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        self.selectedDetentIdentifier = sheetPresentationController.selectedDetentIdentifier
    }
}
