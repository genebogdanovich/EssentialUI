//
//  NumberedRow.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 22.05.22.
//

import SwiftUI

public struct NumberedRow: View {
    private let title: String
    private let icon: Image?
    private let count: Int
    
    
    public init(
        withTitle title: String,
        icon: Image? = nil,
        count: Int
    ) {
        self.title = title
        self.icon = icon
        self.count = count
    }
    
    public init(
        withTitle title: String,
        icon: Image? = nil,
        count: Int64
    ) {
        self.init(withTitle: title, icon: icon, count: Int(count))
    }
    
    public var body: some View {
        HStack {
            if let icon = icon {
                Label {
                    Text(title)
                } icon: {
                    icon
                }
            } else {
                Text(title)
            }
            
            Spacer()
            
            Text("\(count)")
                .foregroundColor(.secondary)
        }
        .accessibilityElement(children: .combine)
    }
}

struct NumberedRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NumberedRow(withTitle: "Guests", icon: Image(systemName: "person.fill"), count: 5)
            NumberedRow(withTitle: "Pneumonoultramicroscopicsilicovolcanoconiosis", count: Int64(5))
        }
        .padding()
        .previewLayout(.sizeThatFits)
        .dynamicTypeSize(.accessibility5)
    }
}
