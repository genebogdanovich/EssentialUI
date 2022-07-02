//
//  CountDownTimerPicker.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 2.07.22.
//

import SwiftUI

public struct CountDownTimerPicker: UIViewRepresentable {
    
    // MARK: - Properties
    
    @Binding private var countDownDuration: TimeInterval
    private let minuteInterval: Int
    
    // MARK: - Initialization
    
    public init(countDownDuration: Binding<TimeInterval>, minuteInterval: Int = 1) {
        _countDownDuration = countDownDuration
        self.minuteInterval = minuteInterval
    }
    
    // MARK: - UIViewRepresentable
    
    public func makeUIView(context: Context) -> UIDatePicker {
        let picker = UIDatePicker()
        picker.datePickerMode = .countDownTimer
        picker.minuteInterval = minuteInterval
        
        picker.addTarget(
            context.coordinator,
            action: #selector(context.coordinator.countDownDurationChanged),
            for: .valueChanged
        )
        
        return picker
    }
    
    public func updateUIView(_ uiView: UIDatePicker, context: Context) {
        uiView.countDownDuration = countDownDuration
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // MARK: - Coordinator
    
    public final class Coordinator {
        private let datePicker: CountDownTimerPicker
        
        init(_ datePicker: CountDownTimerPicker) {
            self.datePicker = datePicker
        }
        
        @objc func countDownDurationChanged(_ sender: UIDatePicker) {
            datePicker.countDownDuration = sender.countDownDuration
        }
    }
}
