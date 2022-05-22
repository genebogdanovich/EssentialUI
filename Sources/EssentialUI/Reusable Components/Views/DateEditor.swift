//
//  DateEditor.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 22.05.22.
//

import SwiftUI

public struct DateEditor: View {
    @Environment(\.dismiss) private var dismiss
    @Binding private var date: Date
    private let title = "Edit Date"
    
    public init(date: Binding<Date>) {
        UIDatePicker.appearance().minuteInterval = 1
        self._date = date
    }
    
    public var body: some View {
        NavigationView {
            VStack {
                DatePicker(title, selection: $date, in: ...Date.now)
                    .datePickerStyle(.graphical)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    DoneButton {
                        dismiss()
                    }
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DateEditor_Previews: PreviewProvider {
    static var previews: some View {
        DateEditor(date: .constant(.now))
    }
}
