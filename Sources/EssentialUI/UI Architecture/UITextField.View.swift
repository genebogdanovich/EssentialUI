//
//  UITextField.View.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 6.06.22.
//

import SwiftUI

// MARK: - UITextField.View

extension UITextField {
    public struct View {
        @Binding private var text: String
        
        private let placeholder: String?
        private let font: UIFont?
        private let textAlignment: NSTextAlignment
        private let keyboardType: UIKeyboardType
        
        public init(
            text: Binding<String>,
            placeholder: String? = nil,
            font: UIFont? = .preferredFont(forTextStyle: .body),
            textAlignment: NSTextAlignment = .left,
            keyboardType: UIKeyboardType = .default
            
        ) {
            self._text = text
            self.placeholder = placeholder
            self.font = font
            self.textAlignment = textAlignment
            self.keyboardType = keyboardType
        }
    }
}

// MARK: - UIViewRepresentable

extension UITextField.View: UIViewRepresentable {
    public func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        
        textField.addTarget(context.coordinator, action: #selector(context.coordinator.textChanged), for: .editingChanged)
        
        textField.placeholder = placeholder
        textField.font = font
        textField.textAlignment = textAlignment
        textField.keyboardType = keyboardType
        
        textField.becomeFirstResponder()
        
        return textField
    }
    
    public func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    public func makeCoordinator() -> UITextField.Coordinator {
        UITextField.Coordinator(text: $text)
    }
}

// MARK: - UITextField.Coordinator

extension UITextField {
    public final class Coordinator: NSObject {
        @Binding private var text: String
        
        public init(text: Binding<String>) {
            self._text = text
        }
        
        @objc func textChanged(_ sender: UITextField) {
            guard let text = sender.text else { return }
            self.text = text
        }
    }
}
