//
//  TextFieldAlert.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 18.05.22.
//

import SwiftUI

struct TextFieldAlert<Content: View>: UIViewControllerRepresentable {
    @Binding private var isPresented: Bool
    private let config: TextFieldAlertConfig
    private let content: Content
    
    init(
        isPresented: Binding<Bool>,
        config: TextFieldAlertConfig,
        @ViewBuilder content: () -> Content
    ) {
        self._isPresented = isPresented
        self.config = config
        self.content = content()
    }
    
    func makeUIViewController(context: Context) -> UIHostingController<Content> {
        UIHostingController(rootView: content)
    }
    
    func updateUIViewController(_ uiViewController: UIHostingController<Content>, context: Context) {
        uiViewController.rootView = content
        
        if isPresented && uiViewController.presentedViewController == nil {
            let alert = UIAlertController(with: config)
            
            if config.validationRule != nil {
                alert.textFields?.first?.addTarget(
                    context.coordinator,
                    action: #selector(context.coordinator.textChanged),
                    for: .editingChanged
                )
                
                let confirmationAction = alert.actions.first { $0.title == config.confirmationTitle }
                confirmationAction?.isEnabled = false
                context.coordinator.alertActionToEnable = confirmationAction
            }
            
            uiViewController.present(alert, animated: true)
        }
    }
    
    class Coordinator: NSObject {
        let parent: TextFieldAlert
        var alertActionToEnable: UIAlertAction!
        
        init(_ textFieldAlert: TextFieldAlert) {
            parent = textFieldAlert
        }
        
        @objc func textChanged(_ sender: UITextField) {
            if let text = sender.text, let validate = parent.config.validationRule {
                alertActionToEnable.isEnabled = validate(text)
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

struct TextFieldAlertModifier<T: Any>: ViewModifier {
    @Binding private var isPresented: Bool
    private let config: TextFieldAlertConfig
    
    init(
        isPresented: Binding<Bool>,
        config: TextFieldAlertConfig
        
    ) {
        self._isPresented = isPresented
        self.config = config
    }
    
    init(
        item: Binding<T?>,
        config: TextFieldAlertConfig
    ) {
        self._isPresented = Binding<Bool>(get: {
            item.wrappedValue != nil
        }, set: { newValue in
            item.wrappedValue = nil
        })
        self.config = config
    }
    
    func body(content: Content) -> some View {
        TextFieldAlert(isPresented: $isPresented, config: config) {
            content
        }
    }
}

extension View {
    public func textFieldAlert(
        isPresented: Binding<Bool>,
        config: TextFieldAlertConfig
    ) -> some View {
        self.modifier(TextFieldAlertModifier<Any>(isPresented: isPresented, config: config))
    }
    
    public func textFieldAlert<T: Identifiable>(
        item: Binding<T?>,
        config: TextFieldAlertConfig
    ) -> some View {
        self.modifier(TextFieldAlertModifier(item: item, config: config))
    }
}
