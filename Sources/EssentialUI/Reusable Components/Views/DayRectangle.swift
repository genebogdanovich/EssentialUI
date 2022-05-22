//
//  DayRectangle.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 22.05.22.
//

import SwiftUI

public struct DayRectangle: View {
    private let date: Date
    
    public init(date: Date) {
        self.date = date
    }
    
    public var body: some View {
        VStack {
            Text(date.formatted(.dateTime.weekday()))
                .font(.caption)
                .foregroundColor(.secondary)
            Text(date.formatted(.dateTime.day()))
                .font(.system(.title2, design: .rounded))
                .bold()
        }
        .padding(2)
        .background(background)
    }
    
    private var background: some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(Color(.secondarySystemFill))
            .aspectRatio(1, contentMode: .fill)
    }
}

struct DayRectangle_Previews: PreviewProvider {
    static var previews: some View {
        DayRectangle(date: .now)
    }
}

