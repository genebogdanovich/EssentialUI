//
//  NSMutableAttributedString+.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 23.05.22.
//

// See: https://stackoverflow.com/questions/43723345/nsattributedstring-change-the-font-overall-but-keep-all-other-attributes

import UIKit

public extension NSMutableAttributedString {
    func setFontWhilePreservingSymbolicTraits(_ font: UIFont) {
        beginEditing()
        self.enumerateAttribute(
            .font,
            in: NSRange(location: 0, length: self.length)
        ) { (value, range, stop) in
            
            if let f = value as? UIFont,
               let newFontDescriptor = f.fontDescriptor
                .withFamily(font.familyName)
                .withSymbolicTraits(f.fontDescriptor.symbolicTraits) {
                
                let newFont = UIFont(
                    descriptor: newFontDescriptor,
                    size: font.pointSize
                )
                removeAttribute(.font, range: range)
                addAttribute(.font, value: newFont, range: range)
                
            }
        }
        endEditing()
    }
}
