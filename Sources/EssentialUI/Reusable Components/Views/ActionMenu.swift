//
//  ActionMenu.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 22.05.22.
//

import SwiftUI

public struct ActionMenu<Content: View>: View {
    private let content: () -> Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        Menu(content: content) {
            Label("Actions", systemImage: "ellipsis.circle")
        }
    }
}

struct ActionMenu_Previews: PreviewProvider {
    static var previews: some View {
        ActionMenu() {}
    }
}
