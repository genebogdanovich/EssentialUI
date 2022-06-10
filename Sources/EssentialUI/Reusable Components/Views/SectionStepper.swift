//
//  SectionStepper.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 10.06.22.
//

import SwiftUI

public struct DataRow: View {
    private let title: LocalizedStringKey
    private let data: String?
    
    public init(
        title: LocalizedStringKey,
        data: String?
    ) {
        self.title = title
        self.data = data
    }
    
    public var body: some View {
        HStack {
            Text(title)
            
            Spacer()
            
            if let data = data {
                Text(data)
            }
        }
        .font(.headline)
    }
}

// MARK: - RemarkStyle

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
    
    private let isPresentingAdditionalControlView: Binding<Bool>?
    
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
            
            
            if let binding = isPresentingAdditionalControlView {
                PresentationLink(isPresentingModal: binding) {
                    DataRow(title: title, data: displayString)
                }
            } else {
                DataRow(title: title, data: displayString)
            }
            
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





public extension SectionStepper where Header == EmptyView {
    init(
        title: LocalizedStringKey,
        remark: LocalizedStringKey,
        value: Binding<V>,
        step: V.Stride = 1,
        formatter: Formatter,
        isPresentingAdditionalControlView: Binding<Bool>? = nil
    ) {
        self._value = value
        self.step = step
        
        self.title = title
        self.remark = remark
        
        self.formatter = formatter
        self.isPresentingAdditionalControlView = isPresentingAdditionalControlView
        
    }
}



public extension SectionStepper {
    init(
        title: LocalizedStringKey,
        remark: LocalizedStringKey,
        value: Binding<V>,
        step: V.Stride = 1,
        formatter: Formatter,
        isPresentingAdditionalControlView: Binding<Bool>? = nil,
        @ViewBuilder header: () -> Header
    ) {
        self._value = value
        self.step = step
        
        self.title = title
        self.remark = remark
        
        self.formatter = formatter
        
        self.isPresentingAdditionalControlView = isPresentingAdditionalControlView
        
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
