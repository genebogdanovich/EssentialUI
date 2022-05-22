//
//  EUEditButton.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 22.05.22.
//

import SwiftUI

public struct EUEditButton: View {
    private let title: LocalizedStringKey
    private let action: () -> Void
    
    public init(
        withTitle title: LocalizedStringKey = "Edit",
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
                Image(systemName: "pencil")
            }
            
        }
    }
}

struct EUEditButton_Previews: PreviewProvider {
    static var previews: some View {
        EUEditButton(withTitle: "Change") {}
    }
}
