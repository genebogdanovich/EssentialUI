//
//  DestructiveButton.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 22.05.22.
//

import SwiftUI

public struct DestructiveButton: View {
    private let title: LocalizedStringKey
    private let action: () -> Void
    
    public init(
        withTitle title: LocalizedStringKey = "Delete",
        action: @escaping () -> Void
    ) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        Button(role: .destructive, action: action) {
            Label {
                Text(title)
            } icon: {
                Image(systemName: "trash")
                    .renderingMode(.original)
            }
            
        }
    }
}

struct DestructiveButton_Previews: PreviewProvider {
    static var previews: some View {
        DestructiveButton(withTitle: "Remove") {}
    }
}
