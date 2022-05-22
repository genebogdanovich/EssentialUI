//
//  InfoView.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 22.05.22.
//

import SwiftUI

public struct InfoView: View {
    private let title: LocalizedStringKey
    private let text: LocalizedStringKey
    private let image: Image
    private let imageSize: CGSize
    
    public init(
        withTitle title: LocalizedStringKey,
        text: LocalizedStringKey,
        image: Image,
        imageSize: CGSize = .init(width: 20, height: 20)
    ) {
        self.title = title
        self.text = text
        self.image = image
        self.imageSize = imageSize
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 16) {
            image
                .resizable()
                .scaledToFit()
                .frame(width: imageSize.width, height: imageSize.height)
                .foregroundColor(.accentColor)
                .accessibilityHidden(true)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(.headline, design: .rounded))
                Text(text)
                    .foregroundColor(.secondary)
            }
            .accessibilityElement(children: .combine)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static let title = "Lorem Ipsum"
    static let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ultrices nunc ut consequat pulvinar. Proin nec nulla nec mi interdum tempor."
    
    static var previews: some View {
        InfoView(
            withTitle: LocalizedStringKey(title),
            text: LocalizedStringKey(text),
            image: .init(systemName: "person.fill")
        )
    }
}
