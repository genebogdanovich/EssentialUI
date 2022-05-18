//
//  TextFieldAlertConfig.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 18.05.22.
//

import UIKit

/// An struct that holds info to configure `UIAlertController` with `UITextField`.
public struct TextFieldAlertConfig {
    internal let title: String
    internal let message: String?
    internal let placeholder: String
    internal let text: String?
    internal let cancellationTitle: String
    internal let confirmationTitle: String
    internal let autocapitalizationType: UITextAutocapitalizationType
    internal let validationRule: ((String) -> Bool)?
    internal let onSubmit: (String?) -> Void
    
    public init(
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
