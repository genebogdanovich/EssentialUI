//
//  SubscribeButton.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 28.05.22.
//

import SwiftUI

// MARK: - SubscribeButtonState

public enum SubscribeButtonState {
    case loading
    case available
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
            .frame(minHeight: 50)
            .background(state == .subscribed ? Color.green : Color.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.99 : 1.0)
    }
}

// MARK: - SubscribeButton

public struct SubscribeButton: View {
    private let state: SubscribeButtonState
    private let title: String
    private let subtitle: String?
    private let action: () -> Void
    
    public init(
        state: SubscribeButtonState,
        title: String,
        subtitle: String?,
        action: @escaping () -> Void
    ) {
        self.state = state
        self.title = title
        self.subtitle = subtitle
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            VStack {
                if let titleText = _title {
                    Text(titleText)
                        .font(.callout.weight(.bold))
                } else {
                    ProgressView()
                        .tint(.white)
                }
                
                if let subtitleText = _subtitle {
                    Text(subtitleText)
                        .font(.caption)
                }
            }
        }
        .buttonStyle(SubscribeButtonStyle(with: state))
        .disabled(state != .available)
    }
    
    private var _title: String? {
        switch state {
        case .pending:
            return "Pending"
        case .subscribed:
            return "Subscribed"
        case .unavailable:
            return "Unavailable"
        case .loading:
            return nil
        default:
            return title
        }
    }
    
    private var _subtitle: String? {
        switch state {
        case .available:
            return subtitle
        case .unavailable:
            return "please try back later"
        default:
            return nil
        }
    }
}

struct SubscribeButton_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            SubscribeButton(
                state: .loading,
                title: "Subscribe for $1.99 per month",
                subtitle: "after the 7-day free trial"
            ) {}
            
            SubscribeButton(
                state: .available,
                title: "Subscribe for $1.99 per month",
                subtitle: nil
            ) {}
            
            SubscribeButton(
                state: .available,
                title: "Subscribe for $1.99 per month",
                subtitle: "after the 7-day free trial"
            ) {}
            
            SubscribeButton(
                state: .pending,
                title: "Subscribe for $1.99 per month",
                subtitle: "after the 7-day free trial"
            ) {}
            
            SubscribeButton(
                state: .subscribed,
                title: "Subscribe for $1.99 per month",
                subtitle: "after the 7-day free trial"
            ) {}
            
            SubscribeButton(
                state: .unavailable,
                title: "Subscribe for $1.99 per month",
                subtitle: "after the 7-day free trial"
            ) {}
        }
            .previewLayout(.sizeThatFits)
            .padding()
            .preferredColorScheme(.dark)
//            .dynamicTypeSize(.accessibility5)
    }
}

