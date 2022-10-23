//
//  Buttons.swift
//  handful
//
//  Created by Ritesh Kanchi on 10/22/22.
//

import Foundation
import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var color: Color
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
            .foregroundColor(color)
        }
    }
}

struct RoundedButton: View {
    
    var foregroundColor: Color
    var background: Color
    var text: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(text)
            Spacer()
        }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(foregroundColor)
            .background(background)
            .clipShape(Capsule())
            .fontWeight(.medium)
            .kerning(-1)
            .contentShape(Rectangle())
    }
}

struct CloseButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var color: Color
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "xmark")
                Text("Close")
            }
            .fontWeight(.medium)
            .foregroundColor(color)
        }
    }
}
