//
//  SectionStepper.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 10.06.22.
//

import SwiftUI

public struct RemarkStyle: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .font(.callout.weight(.light).italic())
            .foregroundColor(.secondary)
    }
}

public extension View {
    func remarkStyle() -> some View {
        modifier(RemarkStyle())
    }
}

// MARK: - SectionStepper

public struct SectionStepper<V, Header>: View where V: Strideable, Header: View {
    
    private var header: Header? = nil
    
    @Binding private var value: V
    private let step: V.Stride
    private let title: LocalizedStringKey
    private let remark: LocalizedStringKey
    private let formatter: Formatter
    
    private var displayString: String? {
        if let interval = value as? TimeInterval, let dateComponentsFormatter = formatter as? DateComponentsFormatter {
            return dateComponentsFormatter.string(from: interval)
        } else if let number = value as? NSNumber, let numberFormatter = formatter as? NumberFormatter {
            return numberFormatter.string(from: number)
        } else {
            return formatter.string(for: value)
        }
    }
    
    public var body: some View {
        Section {
            HStack {
                Text(title)
                
                Spacer()
                
                if let string = displayString {
                    Text(string)
                }
            }
            .font(.headline)
            
            Stepper(value: $value, step: step) {
                Text(remark)
                    .remarkStyle()
            }
        } header: {
            if let header = header {
                header
            } else {
                EmptyView()
            }
        }
    }
}



// Init for creating SectionStepper without header.

public extension SectionStepper where Header == EmptyView {
    init(
        title: LocalizedStringKey,
        remark: LocalizedStringKey,
        value: Binding<V>,
        step: V.Stride = 1,
        formatter: Formatter
    ) {
        self._value = value
        self.step = step
        
        self.title = title
        self.remark = remark
        
        self.formatter = formatter
        
    }
}

// // Init for creating SectionStepper with header.

public extension SectionStepper {
    init(
        title: LocalizedStringKey,
        remark: LocalizedStringKey,
        value: Binding<V>,
        step: V.Stride = 1,
        formatter: Formatter,
        @ViewBuilder header: () -> Header
    ) {
        self._value = value
        self.step = step
        
        self.title = title
        self.remark = remark
        
        self.formatter = formatter
        
        self.header = header()
    }
}




// MARK: - SectionStepper_Previews

struct SectionStepper_Previews: PreviewProvider {
    @State static var duration: TimeInterval = 180
    
    @State static var number: Int16 = 5000
    
    static let timeDurationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        
        return formatter
    }()
    
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        return formatter
    }()
    
    static var previews: some View {
        Form {
            SectionStepper(
                title: "Session Duration",
                remark: "How long was your session?",
                value: $duration,
                formatter: timeDurationFormatter) {
                    Text("Fighting Stats")
                }
            
            SectionStepper(
                title: "Total Rounds",
                remark: "How many rounds there were in your session?",
                value: $number,
                formatter: numberFormatter
            )
        }
    }
}
