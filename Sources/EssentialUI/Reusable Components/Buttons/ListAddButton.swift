//
//  ListAddButton.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 20.05.22.
//

import SwiftUI

public struct ListAddButtonLabel: View {
    private let title: LocalizedStringKey
    
    public init(title: LocalizedStringKey) {
        self.title = title
    }
    
    public var body: some View {
        Label {
            Text(title)
        } icon: {
            Image(systemName: "plus.circle.fill")
                .renderingMode(.original)
                .font(.title2)
        }
    }
}

public struct ListAddButton: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    private let title: LocalizedStringKey
    private let action: () -> Void
    
    public init(title: LocalizedStringKey, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        ListAddButtonLabel(title: title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .offset(x: -2)
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
        .dynamicTypeSize(.xxxLarge)
    }
}
