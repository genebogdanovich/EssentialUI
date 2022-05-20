//
//  ListAddButton.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 20.05.22.
//

import SwiftUI

public struct ListAddButton: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    private let title: LocalizedStringKey
    private let action: () -> Void
    
    
    public init(title: LocalizedStringKey, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        Label {
            Text(title)
        } icon: {
            Image(systemName: "plus.circle.fill")
                .renderingMode(.original)
                .font(dynamicTypeSize.isAccessibilitySize ? .system(size: 42) : .title2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .onTapGesture(perform: action)
    }
}

struct ListAddButton_Previews: PreviewProvider {
    static let fruits = ["Apple", "Orange"]
    static var previews: some View {
        Form {
            ListAddButton(title: "add fruit") {
                print("add item")
            }
            ForEach(fruits, id: \.self) { fruit in
                Text(fruit)
            }
            .onDelete(perform: { _ in })
        }
        .environment(\.editMode, .constant(.active))
//        .dynamicTypeSize(.accessibility5)
    }
}
