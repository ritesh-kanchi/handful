//
//  Typography.swift
//  handful
//
//  Created by Ritesh Kanchi on 10/22/22.
//

import SwiftUI

struct GeneralTitle: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.semibold)
            .kerning(-1.5)
    }
}
