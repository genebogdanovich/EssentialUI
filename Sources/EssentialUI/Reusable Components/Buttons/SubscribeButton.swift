//
//  SubscribeButton.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 18.05.22.
//

import SwiftUI

// MARK: - SubscribeButtonState

public enum SubscribeButtonState {
    case loading
    case regular
    case pending
}

// MARK: - SubscribeButtonStyle

struct SubscribeButtonStyle: ButtonStyle {
    private let state: SubscribeButtonState
    
    init(with state: SubscribeButtonState) {
        self.state = state
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.99 : 1.0)
    }
}

// MARK: - SubscribeButton

public struct SubscribeButton: View {
    private let state: SubscribeButtonState
    private let title: String
    private let action: () -> Void
    
    public init(
        state: SubscribeButtonState,
        title: String,
        action: @escaping () -> Void
    ) {
        self.state = state
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            if state == .loading {
                ProgressView()
                    .tint(.white)
            } else {
                Text(state == .regular ? title : "Pending")
                    .fontWeight(state == .regular ? .bold : .medium)
            }
        }
        .buttonStyle(SubscribeButtonStyle(with: state))
        .disabled(state != .regular)
    }
}

// MARK: - SubscribeButton_Previews

struct SubscribeButton_Previews: PreviewProvider {
    @State static var isEligibleForIntroOffer = true
    static var previews: some View {
        SubscribeButton(state: .pending, title: isEligibleForIntroOffer ? "Try It Free" : "Subscribe") {}
            .previewLayout(.sizeThatFits)
    }
}
