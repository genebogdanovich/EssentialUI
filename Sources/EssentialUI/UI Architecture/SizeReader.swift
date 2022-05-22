//
//  SizeReader.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 22.05.22.
//

import SwiftUI

private struct SizePreferenceKey: PreferenceKey {
    // Default value is used when there is no explicit value for this view.
    static var defaultValue: CGSize = .zero
    // Reduce function combines the key values found in the tree with a new one.
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

public extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}
