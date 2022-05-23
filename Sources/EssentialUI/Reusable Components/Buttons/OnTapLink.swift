//
//  OnTapLink.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 20.05.22.
//

import SwiftUI

public struct OnTapLink<Label: View>: View {
    
    private let label: Label
    private let action: () -> Void
    
    public init(
        action: @escaping () -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.action = action
        self.label = label()
    }
    
    public var body: some View {
        NavigationLink(destination: { EmptyView() }) {
            label
        }
        .accessibilityAction {
            action()
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: action)
    }
}

struct OnTapLink_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                OnTapLink {
                    print("tapped link")
                } label: {
                    Label("People", systemImage: "person")
                }
            }
            .environment(\.editMode, .constant(.active))
        }
    }
}
