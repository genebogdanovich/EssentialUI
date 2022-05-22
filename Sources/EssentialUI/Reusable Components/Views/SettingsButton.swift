//
//  SettingsButton.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 22.05.22.
//

import SwiftUI

public struct SettingsButton: View {
    private let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Label("Settings", systemImage: "gear.circle")
        }
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton() {}
    }
}
