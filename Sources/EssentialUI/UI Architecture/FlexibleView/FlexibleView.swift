//
//  FlexibleView.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 26.05.22.
//

import SwiftUI

/// Facade of our view, its main responsibility is to get the available width
/// and pass it down to the real implementation, `_FlexibleView`.
public struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    let data: Data
    let spacing: CGFloat
    let horizontalAlignment: HorizontalAlignment
    let verticalAlignment: VerticalAlignment
    let content: (Data.Element) -> Content
    @State private var availableWidth: CGFloat = 0
    
    public init(
        data: Data,
        spacing: CGFloat,
        horizontalAlignment: HorizontalAlignment,
        verticalAlignment: VerticalAlignment = .center,
        content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.spacing = spacing
        self.verticalAlignment = verticalAlignment
        self.horizontalAlignment = horizontalAlignment
        self.content = content
    }
    
    public var body: some View {
        ZStack(alignment: Alignment(horizontal: horizontalAlignment, vertical: verticalAlignment)) {
            Color.clear
                .frame(height: 1)
                .readSize { size in
                    availableWidth = size.width
                }
            
            _FlexibleView(
                availableWidth: availableWidth,
                data: data,
                spacing: spacing,
                horizontalAlignment: horizontalAlignment,
                content: content
            )
        }
    }
}
