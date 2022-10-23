//
//  ContentView.swift
//  handful
//
//  Created by Ritesh Kanchi on 10/22/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewRouter: ViewRouter
    
    
    var body: some View {
        switch viewRouter.currentPage {
        case .home:
            HomeView(viewRouter: viewRouter)
        case .profile:
            Text("Profile")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter())
    }
}

struct TabBar: View {
    
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        
        HStack(spacing: 20) {
            Spacer()
            TabBarIcon(viewRouter: viewRouter, icon: "gamecontroller.fill", text: "Home", page: .home)
            Spacer()
            Divider().frame(height: 40).background(.white)
            Spacer()
            TabBarIcon(viewRouter: viewRouter, icon: "person.fill", text: "Profile", page: .profile)
                .disabled(true)
            Spacer()
        }
        .padding()
        .frame(maxWidth:.infinity)
        .foregroundColor(.white)
        .background(.black)
        .clipShape(Capsule())
        .overlay {
            Capsule()
                .fill(.clear)
                .border(.white.opacity(0.1))
        }
        .shadow(radius: 10)
        .padding()
        
    }
}

struct TabBarIcon: View {
    @StateObject var viewRouter: ViewRouter
    var icon: String
    var text: String
    var page: Page
    
    var body: some View {
        Button(action: {
            withAnimation {
                viewRouter.currentPage = page
            }
        }) {
            VStack(spacing: 5) {
                Image(systemName: icon)
                    .imageScale(.large)
                Text(text)
                    .font(.footnote)
                    .fontWeight(.medium)
            }
            .foregroundColor(.white)
            .opacity(viewRouter.currentPage == page ? 1 : 0.5)
        }
    }
}
