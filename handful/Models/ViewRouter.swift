//
//  ViewRouter.swift
//  handful
//
//  Created by Ritesh Kanchi on 10/23/22.
//

import Foundation
import SwiftUI

class ViewRouter: ObservableObject {
    
    @Published var currentPage: Page = .home
   
}

enum Page {
    case home
    case profile
}
