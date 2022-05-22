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
        @ViewBuilder label: () -> Label,
        action: @escaping () -> Void
    ) {
        self.label = label()
        self.action = action
    }
    
    public var body: some View {
        NavigationLink(destination: { EmptyView() }) {
            label
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: action)
    }
}

struct OnTapLink_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                OnTapLink(label: { Label("People", systemImage: "person") }) {
                    print("link")
                }
            }
            .environment(\.editMode, .constant(.active))
        }
    }
}
