//
//  DoneButton.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 22.05.22.
//

import SwiftUI

public struct DoneButton: View {
    private let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button("Done", action: action)
    }
}

struct DoneButton_Previews: PreviewProvider {
    static var previews: some View {
        DoneButton() {}
    }
}
