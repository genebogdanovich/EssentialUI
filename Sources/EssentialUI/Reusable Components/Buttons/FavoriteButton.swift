//
//  FavoriteButton.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 22.05.22.
//

import SwiftUI

public struct FavoriteButton: View {
    @Binding private var isFavorite: Bool
    
    public init(isFavorite: Binding<Bool>) {
        self._isFavorite = isFavorite
    }
    
    public var body: some View {
        Button {
            isFavorite.toggle()
        } label: {
            Label {
                Text(isFavorite ? "Unfavorite" : "Mark as Favorite")
            } icon: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
            }
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isFavorite: .constant(false))
    }
}
