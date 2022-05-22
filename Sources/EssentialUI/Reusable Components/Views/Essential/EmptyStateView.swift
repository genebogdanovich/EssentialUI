//
//  EmptyStateView.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 22.05.22.
//

import SwiftUI

public struct EmptyStateView: View {
    private let title: LocalizedStringKey
    private let text: LocalizedStringKey?
    private let image: Image?
    
    public init(
        withTitle title: LocalizedStringKey,
        text: LocalizedStringKey?,
        image: Image?
    ) {
        self.title = title
        self.text = text
        self.image = image
    }
    
    public var body: some View {
        VStack(spacing: 4) {
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .accessibilityHidden(true)
            }
            
            Text(title)
                .font(.system(.title2, design: .rounded))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            if let text = text {
                Text(text)
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }
            
        }
        .accessibilityElement(children: .combine)
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static let title: LocalizedStringKey = "Lorem Ipsum"
    static let text: LocalizedStringKey = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    
    static var previews: some View {
        EmptyStateView(
            withTitle: title,
            text: text,
            image: Image(systemName: "person")
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
