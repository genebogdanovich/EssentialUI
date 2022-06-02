//
//  EmptyStateView.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 22.05.22.
//

import SwiftUI

public struct EmptyStateView: View {
    private let title: LocalizedStringKey?
    private let text: LocalizedStringKey?
    private let image: Image
    private let imageSize: CGSize
    
    public init(
        title: LocalizedStringKey? = nil,
        text: LocalizedStringKey? = nil,
        image: Image,
        imageSize: CGSize = .init(width: 100, height: 100)
    ) {
        self.title = title
        self.text = text
        self.image = image
        self.imageSize = imageSize
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            image
                .resizable()
                .scaledToFit()
                .frame(width: imageSize.width, height: imageSize.height)
                .accessibilityHidden(true)
            
            if let title = title {
                Text(title)
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
            }
            
            if let text = text {
                Text(text)
                    .font(.body.weight(.medium))
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
            title: title,
            text: text,
            image: Image(systemName: "person"),
            imageSize: .init(width: 64, height: 64)
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
