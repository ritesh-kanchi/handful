//
//  GameStartView.swift
//  handful
//
//  Created by Ritesh Kanchi on 10/22/22.
//

import SwiftUI

struct GameStartView: View {
    
    @State private var startGame = false
    @State private var openGame = false
    
    var body: some View {
        VStack(spacing: 40) {
            HeroView()
                .padding(.horizontal)
            RulesView()
                .padding(.horizontal)
            FriendsView()
            Spacer()
            Button(action: {
                startGame = true
            }) {
                RoundedButton(foregroundColor: .black, background: Color(hex: "#FFC0FC"), text: "Start game →")
                    .frame(width: 200)
            }
            .fullScreenCover(isPresented: $openGame, content: {GameView(openGame: $openGame)})
//            NavigationLink(destination: GameView(), isActive: $openGame) {
//            }
        }
        .padding(.bottom)
        .padding(.vertical)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "#FFC0FC"),Color.white]), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.primary)
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: $startGame, onDismiss: didDismiss, content: {ScanInfoView(startGame: $startGame)})
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton(color: .black)
            }
        }
        
    }
    
    func didDismiss() {
      openGame = true
    }
}

struct GameStartView_Previews: PreviewProvider {
    static var previews: some View {
        GameStartView()
    }
}

private struct HeroView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 40) {
            Text("Rock\nPaper\nScissors")
                .font(.largeTitle)
                .fontWeight(.bold)
                .kerning(-1.5)
                .fixedSize()
            Spacer()
            Image("dogcow")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(.black.opacity(0.1))
                }
                .frame(width: 128, height: 128)
        }
    }
}

private struct RulesView: View {
    var body: some View {
        VStack(spacing: 20) {
            RulesItemView(iconAngle: Angle(degrees: 0), icon: "👊", main: "Rock", weakness: "Scissors")
            RulesItemView(iconAngle: Angle(degrees: 15), icon: "✋", main: "Paper", weakness: "Rock")
            RulesItemView(iconAngle: Angle(degrees: 15), icon: "✌️", main: "Scissors", weakness: "Paper")
        }
    }
}

private struct RulesItemView: View {
    var iconAngle: Angle
    var icon: String
    var main: String
    var weakness: String
    
    var body: some View {
        ZStack {
            HStack {
                Text(main)
                    .bold() + Text(" beats ") + Text(weakness)
                Spacer()
            }
            .font(.title2)
            .padding(.leading,20)
            .padding()
            .background(.white)
            .clipShape(Capsule())
            .padding(.horizontal)
            HStack {
                Text(icon)
                    .rotationEffect(iconAngle)
                Spacer()
            }
            .font(.system(size: 44))
        }
    }
}

private struct FriendsView: View {
    
    var body: some View {
        VStack {
            HStack {
                GeneralTitle(text: "Friends Online")
                Spacer()
            }
            .padding(.horizontal)
            ZStack(alignment: .center) {
                
                LinearGradient(gradient: Gradient(colors: [Color(hex: "#FEC2FA"), Color(hex: "#E9F5C7")]), startPoint: .leading, endPoint: .trailing)
                    .frame(height: 20)
                    .clipShape(Capsule())
                    .overlay {
                        Capsule()
                            .stroke(.black.opacity(0.05))
                    }
                    .offset(y:-10)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 20) {
                        ForEach(friends) { friend in
                            FriendProfileView(friend: friend)
                        }
                    }
                    .padding(.horizontal,40)
                }
              
            }
        }
    }
}

private struct FriendProfileView: View {
    
    var friend: FriendProfile
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Image(friend.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 64, height: 64)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(.black.opacity(0.1))
                }
            Text(friend.name)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

private struct FriendProfile: Identifiable {
    var id = UUID()
    var image: String
    var name: String
}

private let friends = [
    FriendProfile(image: "memoji-1", name: "Greg H."),
    FriendProfile(image: "memoji-2", name: "Susan B."),
    FriendProfile(image: "memoji-3", name: "Shrek S.")
]
