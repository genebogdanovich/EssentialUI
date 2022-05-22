//
//  RatingView.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 22.05.22.
//

import SwiftUI

public struct RatingView: View {
    @Binding private var rating: Int
    
    private let label: String
    private let maxRating: Int
    
    private let offImage: Image?
    private let onImage: Image
    
    private let offColor: Color
    private let onColor: Color
    
    public init(
        rating: Binding<Int>,
        label: String = "",
        maxRating: Int = 5,
        offImage: Image? = nil,
        onImage: Image = Image(systemName: "star.fill"),
        offColor: Color = .gray,
        onColor: Color = .yellow
    ) {
        self._rating = rating
        self.label = label
        self.maxRating = maxRating
        self.offImage = offImage
        self.onImage = onImage
        self.offColor = offColor
        self.onColor = onColor
    }
    
    public var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            
            ForEach(1..<maxRating + 1, id: \.self) { number in
                image(for: number)
                    .font(.callout)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        adjustRating(forNumber: number)
                    }
            }
        }
    }
    
    private func adjustRating(forNumber number: Int) {
        if rating == 1 && number == 1 {
            rating = 0
        } else {
            rating = number
        }
    }
    
    private func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(3))
    }
}
