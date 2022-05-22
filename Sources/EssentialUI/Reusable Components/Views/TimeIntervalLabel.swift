//
//  TimeIntervalLabel.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 22.05.22.
//

import SwiftUI

public struct TimeIntervalLabel: View {
    private let interval: DateInterval
    
    public init(with interval: DateInterval) {
        self.interval = interval
    }
    
    public var body: some View {
        Text("From \(start) to \(end)")
    }
    
    private var start: String {
        interval.start
            .formatted(date: .omitted, time: .shortened)
    }
    
    private var end: String {
        interval.end
            .formatted(date: .omitted, time: .shortened)
    }
}

struct TimeIntervalLabel_Previews: PreviewProvider {
    static var previews: some View {
        let hourBefore = Calendar.current.date(byAdding: .hour, value: -1, to: .now)!
        let interval = DateInterval(start: hourBefore, end: .now)
        TimeIntervalLabel(with: interval)
    }
}
