//
//  Modifiers.swift
//  handful
//
//  Created by Ritesh Kanchi on 10/22/22.
//

import Foundation
import SwiftUI

struct DarkStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.bottom)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .foregroundColor(.white)
    }
}

extension View {
    func darkStyle() -> some View {
        modifier(DarkStyle())
    }
}
