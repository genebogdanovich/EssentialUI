//
//  RatingView.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 24.05.22.
//

import SwiftUI

public struct RatingView: View {
    @Binding private var rating: Int
    private let label: String
    private let maximumRating: Int
    private let offImage: Image?
    private let onImage: Image
    private let offColor: Color
    private let onColor: Color
    
    public init(
        rating: Binding<Int>,
        label: String = "",
        maximumRating: Int = 5,
        offImage: Image? = nil,
        onImage: Image = Image(systemName: "star.fill"),
        offColor: Color = Color.gray,
        onColor: Color = Color.yellow
    ) {
        self._rating = rating
        self.label = label
        self.maximumRating = maximumRating
        self.offImage = offImage
        self.onImage = onImage
        self.offColor = offColor
        self.onColor = onColor
    }
    
    public init(
        rating: Binding<Int16>,
        label: String = "",
        maximumRating: Int = 5,
        offImage: Image? = nil,
        onImage: Image = Image(systemName: "star.fill"),
        offColor: Color = Color.gray,
        onColor: Color = Color.yellow
    ) {
        self.init(
            rating: Binding<Int>(get: { Int(rating.wrappedValue) }, set: { rating.wrappedValue = Int16($0) }),
            label: label,
            maximumRating: maximumRating,
            offImage: offImage,
            onImage: onImage,
            offColor: offColor,
            onColor: onColor
        )
    }
    
    public var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        adjustRating(for: number)
                    }
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Rating")
        .accessibilityValue("\(rating)")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                if rating < maximumRating { rating += 1 }
            case .decrement:
                if rating > 1 { rating -= 1 }
            default:
                break
            }
        }
    }
}

extension RatingView {
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
    func adjustRating(for number: Int) {
        rating = number
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(3))
    }
}
