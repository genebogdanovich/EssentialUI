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
        
        textField.keyboardType = keyboardType
        textField.placeholder = placeholder
        textField.font = font
        textField.textAlignment = textAlignment
        
        textField.becomeFirstResponder()
        
        return textField
    }
    
    // SwiftUI -> UIKit
    public func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    public func makeCoordinator() -> some UITextFieldDelegate {
        UITextField.Delegate(text: $text)
    }
}

// MARK: - UITextFieldDelegate

extension UITextField.Delegate: UITextFieldDelegate {
    // UIKit -> StringUI
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        self.text = text
    }
}

// MARK: - UITextField.Delegate

extension UITextField {
    final class Delegate: NSObject {
        @Binding private var text: String
        
        public init(text: Binding<String>) {
            self._text = text
        }
    }
}
