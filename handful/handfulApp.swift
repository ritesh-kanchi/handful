//
//  handfulApp.swift
//  handful
//
//  Created by Ritesh Kanchi on 10/22/22.
//

import SwiftUI

@main
struct handfulApp: App {
    
    @StateObject var viewRouter = ViewRouter()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewRouter: viewRouter)
                .preferredColorScheme(.light)
        }
    }
}
