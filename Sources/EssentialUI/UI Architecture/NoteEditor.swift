//
//  NoteEditor.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 23.05.22.
//

import SwiftUI

public struct NoteEditor: View {
    @Environment(\.dismiss) private var dismiss
    @Binding private var note: NSAttributedString
    private let navigationTitle: String
    
    public init(note: Binding<NSAttributedString>, navigationTitle: String = "Note") {
        self._note = note
        self.navigationTitle = navigationTitle
    }
    
    public var body: some View {
        NavigationView {
            UITextView.View(text: $note)
                .padding(.horizontal, 4)
                .navigationTitle(navigationTitle)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension NoteEditor {
    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            DoneButton {
                dismiss()
            }
        }
    }
}

struct NoteEditor_Previews: PreviewProvider {
    static var previews: some View {
        NoteEditor(note: .constant(NSAttributedString(string: "")))
    }
}
