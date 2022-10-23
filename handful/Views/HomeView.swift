//
//  HomeView.swift
//  handful
//
//  Created by Ritesh Kanchi on 10/22/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text("Let's play...")
                            .kerning(-1.5)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.top)
                    VStack(spacing: 0) {
                        NavigationLink(destination: GameStartView()) {
                            GameCard()
                        }
                        Text("More coming soon...")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .offset(y:-20)
                    }
                  Divider()
                        .padding(.vertical,5)
                    Image("handful-logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 84)
                        .opacity(0.5)
                }
                .padding()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct GameCard: View {
    
    func getRandomRPS() -> String {
        let decision = Int.random(in: 1..<4)
        switch decision {
        case 1:
            return "rock"
        case 2:
            return "paper"
        case 3:
            return "scissors"
        default:
            return "undefined"
        }
    }
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading,spacing:10) {
                    Text("Rock\nPaper\nScissors")
                        .kerning(-1.5)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.primary)
                    Text("I’ll play \(getRandomRPS()) 😉")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .opacity(0.75)
                    
                }
                
                Spacer()
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "#FFC3FC"), Color(hex:"#FFC0FC").opacity(0.15)]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 20, style:.continuous)
                    .stroke(Color("System-Invert").opacity(0.15))
            }
            HStack {
                Spacer()
                Image("rps-graphic")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 140)
                    .offset(x: -20, y:-30)
                    .rotationEffect(Angle(degrees: 10))
            }
        }
        .offset(y:-20)
    }
}
