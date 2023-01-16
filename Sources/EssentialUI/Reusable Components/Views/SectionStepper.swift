//
//  SectionStepper.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 10.06.22.
//

import SwiftUI

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
    private let bounds: ClosedRange<V>
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
                Button {
                    binding.wrappedValue = true
                } label: {
                    HStack {
                        Row(title: title, data: displayString)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.callout.weight(.medium))
                            .foregroundColor(Color(uiColor: .secondaryLabel))
                    }
                }
                .tint(.primary)
            } else {
                Row(title: title, data: displayString)
            }
            
            Stepper(value: $value, in: bounds, step: step) {
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


extension SectionStepper {
    private struct Row: View {
        private let title: LocalizedStringKey
        private let data: String?
        
        init(
            title: LocalizedStringKey,
            data: String?
        ) {
            self.title = title
            self.data = data
        }
        
        var body: some View {
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
}


public extension SectionStepper where Header == EmptyView {
    init(
        title: LocalizedStringKey,
        remark: LocalizedStringKey,
        value: Binding<V>,
        in bounds: ClosedRange<V>,
        step: V.Stride = 1,
        formatter: Formatter,
        isPresentingAdditionalControlView: Binding<Bool>? = nil
    ) {
        self._value = value
        self.bounds = bounds
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
        in bounds: ClosedRange<V>,
        step: V.Stride = 1,
        formatter: Formatter,
        isPresentingAdditionalControlView: Binding<Bool>? = nil,
        @ViewBuilder header: () -> Header
    ) {
        self._value = value
        self.bounds = bounds
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
    
    @State static var isPresentingAdditionalControlView = false
    
    static var previews: some View {
        Form {
            SectionStepper(
                title: "Session Duration",
                remark: "How long was your session?",
                value: $duration,
                in: 0...1000,
                formatter: timeDurationFormatter,
                isPresentingAdditionalControlView: $isPresentingAdditionalControlView) {
                    Text("Fighting Stats")
                }
            
            SectionStepper(
                title: "Total Rounds",
                remark: "How many rounds there were in your session?",
                value: $number,
                in: 0...Int16.max,
                formatter: numberFormatter
            )
        }
    }
}
