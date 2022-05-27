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
    case subscribed
    case unavailable
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
            .background(state == .subscribed ? Color.green : Color.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.99 : 1.0)
    }
}

// MARK: - SubscribeButton

public struct SubscribeButton: View {
    private let state: SubscribeButtonState
    private let title: AttributedString
    private let action: () -> Void
    
    public init(
        state: SubscribeButtonState,
        title: AttributedString,
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
                Text(buttonTitle)
                    .font(.callout)
                    .fontWeight(state == .regular ? .bold : .medium)
            }
        }
        .buttonStyle(SubscribeButtonStyle(with: state))
        .disabled(state != .regular)
    }
    
    private var buttonTitle: AttributedString {
        switch state {
        case .pending:
            return "Pending"
        case .subscribed:
            return "Subscribed"
        case .unavailable:
            return "Unavailable"
        default:
            return title
        }
    }
}

// MARK: - SubscribeButton_Previews

struct SubscribeButton_Previews: PreviewProvider {
    @State static var isEligibleForIntroOffer = true
    static var previews: some View {
        SubscribeButton(state: .regular, title: isEligibleForIntroOffer ? "Week free then $1.99 per month" : "$1.99 per month") {}
            .previewLayout(.sizeThatFits)
    }
}
