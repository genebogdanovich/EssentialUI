//
//  TextFieldAlertConfig.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 18.05.22.
//

import UIKit

/// An struct that holds info to configure `UIAlertController` with `UITextField`.
public struct TextFieldAlertConfig {
    let title: String
    let message: String?
    let placeholder: String
    let text: String?
    let cancellationTitle: String
    let confirmationTitle: String
    let autocapitalizationType: UITextAutocapitalizationType
    let validationRule: ((String) -> Bool)?
    let onSubmit: (String?) -> Void
    
    init(
        title: String,
        message: String? = nil,
        placeholder: String = "",
        text: String? = nil,
        cancellationTitle: String = "Cancel",
        confirmationTitle: String = "OK",
        autocapitalizationType: UITextAutocapitalizationType = .none,
        validationRule: ((String) -> Bool)? = nil,
        onSubmit: @escaping (String?) -> Void
    ) {
        self.title = title
        self.message = message
        self.placeholder = placeholder
        self.text = text
        self.cancellationTitle = cancellationTitle
        self.confirmationTitle = confirmationTitle
        self.autocapitalizationType = autocapitalizationType
        self.validationRule = validationRule
        self.onSubmit = onSubmit
    }
}
