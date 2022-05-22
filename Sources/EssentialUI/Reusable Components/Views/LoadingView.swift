//
//  LoadingView.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 22.05.22.
//

import SwiftUI

public struct LoadingView: View {
    private let title: String
    
    public init(title: String = "Loading") {
        self.title = title
    }
    
    public var body: some View {
        ProgressView(title)
            .padding()
            .background(background)
    }
    
    private var background: some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(.ultraThickMaterial)
            .aspectRatio(1, contentMode: .fill)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
            .dynamicTypeSize(.accessibility5)
    }
}
