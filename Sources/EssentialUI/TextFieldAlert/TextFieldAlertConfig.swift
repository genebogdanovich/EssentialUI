//
//  TextFieldAlertConfig.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 18.05.22.
//

import UIKit

/// An struct that holds info to configure `UIAlertController` with `UITextField`.
public struct TextFieldAlertConfig {
    public let title: String
    public let message: String?
    public let placeholder: String
    public let text: String?
    public let cancellationTitle: String
    public let confirmationTitle: String
    public let autocapitalizationType: UITextAutocapitalizationType
    public let validationRule: ((String) -> Bool)?
    public let onSubmit: (String?) -> Void
    
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
