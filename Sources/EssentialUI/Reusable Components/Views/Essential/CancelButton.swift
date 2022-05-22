//
//  CancelButton.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 22.05.22.
//

import SwiftUI

public struct CancelButton: View {
    private let title: LocalizedStringKey
    private let action: () -> Void
    
    public init(
        title: LocalizedStringKey = "Cancel",
        action: @escaping () -> Void
    ) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        Button("Cancel", role: .cancel, action: action)
    }
}

struct CancelButton_Previews: PreviewProvider {
    static var previews: some View {
        CancelButton() {}
    }
}
