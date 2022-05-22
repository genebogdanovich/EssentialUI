//
//  DismissButton.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 22.05.22.
//

import SwiftUI

public struct DismissButton: View {
    private let title: LocalizedStringKey
    private let action: () -> Void
    
    public init(
        _ title: LocalizedStringKey = "Dismiss",
        action: @escaping () -> Void
    ) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Label {
                Text(title)
            } icon: {
                icon
            }
        }
    }
    
    private var icon: some View {
        Image(systemName: "xmark")
            .foregroundColor(.secondary)
            .font(.caption.bold())
            .padding(6)
            .background(Color(.secondarySystemFill))
            .cornerRadius(.infinity)
        
    }
}

struct DismissButton_Previews: PreviewProvider {
    static var previews: some View {
        DismissButton() {}
    }
}
