//
//  FilterMenu.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 22.05.22.
//

import SwiftUI

public struct FilterMenu<Content: View>: View {
    private let content: () -> Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        Menu(content: content) {
            Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
        }
    }
}

struct FilterMenu_Previews: PreviewProvider {
    static var previews: some View {
        FilterMenu() {}
    }
}
