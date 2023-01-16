//
//  PresentationLink.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 7.06.22.
//

import SwiftUI

/// A view that looks like NavigationLink but in fact presents modal.
@available(*, deprecated, message: "Does not work well with iOS 16 navigation.")
public struct PresentationLink<Label: View>: View {
    
    private let label: () -> Label
    @Binding private var isPresentingModal: Bool
    
    public init(
        isPresentingModal: Binding<Bool>,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self._isPresentingModal = isPresentingModal
        self.label = label
    }
    
    public var body: some View {
        NavigationLink(isActive: binding, destination: { EmptyView() }, label: label)
            .accessibilityAction {
                isPresentingModal = true
            }
    }
    
    private var binding: Binding<Bool> {
        Binding {
            return false
        } set: { _ in
            isPresentingModal = true
        }
        
    }
}

struct PresentationLink_Previews: PreviewProvider {
    static var previews: some View {
        PresentationLink(isPresentingModal: .constant(false)) {
            Text("add stats")
        }
    }
}
