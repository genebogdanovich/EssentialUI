//
//  UITextField.View.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 3.06.22.
//

import SwiftUI

// MARK: - UITextField.View

extension UITextField {
    public struct View {
        @Binding private var text: String
        
        public init(text: Binding<String>) {
            self._text = text
        }
    }
}

// MARK: - UIViewRepresentable

extension UITextField.View: UIViewRepresentable {
    public func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.backgroundColor = UIColor.green
        return textField
    }
    
    public func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    public func makeCoordinator() -> some UITextFieldDelegate {
        UITextField.Delegate(text: $text)
    }
}

// MARK: - UITextFieldDelegate

extension UITextField.Delegate: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        text = textField.text ?? ""
    }
}

// MARK: - UITextField.Delegate

extension UITextField {
    final class Delegate: NSObject {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
    }
}
