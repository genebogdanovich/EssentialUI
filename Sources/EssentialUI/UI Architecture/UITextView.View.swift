//
//  UITextView.View.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 23.05.22.
//

import SwiftUI

// MARK: - UITextView.View

extension UITextView {
    struct View {
        @Binding var text: NSAttributedString
    }
}

// MARK: - UIViewRepresentable

extension UITextView.View: UIViewRepresentable {
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.allowsEditingTextAttributes = true
        textView.font = UIFont.preferredFont(forTextStyle: .title3)
        
        // Adjust the font size for dynamic type while preserving symbolic traits.
        let nsMutableAttributedString = NSMutableAttributedString(attributedString: text)
        nsMutableAttributedString.setFontWhilePreservingSymbolicTraits(.preferredFont(forTextStyle: .title3))
        text = nsMutableAttributedString
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = text
    }
    
    func makeCoordinator() -> some UITextViewDelegate {
        UITextView.Delegate(text: $text)
    }
}

// MARK: - UITextViewDelegate

extension UITextView.Delegate: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        _text.wrappedValue = textView.attributedText
    }
}

// MARK: - UITextView.Delegate

extension UITextView {
    final class Delegate: NSObject {
        @Binding var text: NSAttributedString
        
        init(text: Binding<NSAttributedString>) {
            _text = text
        }
    }
}
