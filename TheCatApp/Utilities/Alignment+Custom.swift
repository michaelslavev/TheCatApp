//
//  CatBreedListView.swift
//  TheCatApp
//
//  Created by Michael Slavev on 07.06.2023.
//

import SwiftUI

extension HorizontalAlignment {
    struct HorizontalInfoAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[.leading]
        }
    }
    
    static let horizontalInfoAlignment: HorizontalAlignment = HorizontalAlignment(HorizontalInfoAlignment.self)
}
