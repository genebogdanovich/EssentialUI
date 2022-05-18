//
//  UIAlertController+.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 18.05.22.
//

import UIKit

extension UIAlertController {
    convenience init(with config: TextFieldAlertConfig) {
        self.init(title: config.title, message: config.message, preferredStyle: .alert)
        
        addTextField { textField in
            textField.placeholder = config.placeholder
            textField.autocapitalizationType = config.autocapitalizationType
        }
        
        addAction(UIAlertAction(title: config.cancellationTitle, style: .cancel, handler: { _ in
            config.onSubmit(nil)
        }))
        
        addAction(UIAlertAction(title: config.confirmationTitle, style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            config.onSubmit(self.textFields?.first?.text)
        }))
    }
}
