//
//  OnTapButton.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 23.05.22.
//

import SwiftUI

public struct OnTapButton<Label: View>: View {
    private let action: () -> Void
    private let label: Label
    
    public init(
        action: @escaping () -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.action = action
        self.label = label()
    }
    
    public var body: some View {
        label
            .foregroundColor(.accentColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .onTapGesture(perform: action)
    }
}

struct OnTapButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnTapButton {
            } label: {
                Label("Add Image", systemImage: "photo")
            }
            OnTapButton {
            } label: {
                Text("Add URL")
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
