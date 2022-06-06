//
//  UITextField.View.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 5.06.22.
//

import SwiftUI

// MARK: - UITextField.View

extension UITextField {
    public struct View {
        @Binding private var text: String
        private let keyboardType: UIKeyboardType
        private let placeholder: String?
        private let font: UIFont
        private let textAlignment: NSTextAlignment
        
        public init(
            text: Binding<String>,
            keyboardType: UIKeyboardType = .default,
            placeholder: String? = nil,
            font: UIFont = .preferredFont(forTextStyle: .body),
            textAlignment: NSTextAlignment = .left
        ) {
            self._text = text
            self.keyboardType = keyboardType
            self.placeholder = placeholder
            self.font = font
            self.textAlignment = textAlignment
        }
    }
}

// MARK: - UIViewRepresentable

extension UITextField.View: UIViewRepresentable {
    public func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.addTarget(context.coordinator, action: #selector(context.coordinator.textChanged), for: .editingChanged)
        
        textField.keyboardType = keyboardType
        textField.placeholder = placeholder
        textField.font = font
        textField.textAlignment = textAlignment
        
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

// MARK: - UITextFieldDelegate

extension UITextField.Coordinator: UITextFieldDelegate {
    /*
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        
        guard let text = textField.text else { return true }
        let replacementText = (text as NSString).replacingCharacters(in: range, with: string)
        
        self.text = replacementText
        
        return true
    }
     */
}

// MARK: - UITextField.Delegate

extension UITextField {
    public final class Coordinator: NSObject {
        @Binding private var text: String
        
        public init(text: Binding<String>) {
            self._text = text
        }
        
        @objc func textChanged(_ sender: UITextField) {
            if let text = sender.text {
                self.text = text
            }
        }
    }
}
