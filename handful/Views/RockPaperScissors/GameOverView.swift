//
//  GameOverView.swift
//  handful
//
//  Created by Ritesh Kanchi on 10/23/22.
//

import SwiftUI

struct GameOverView: View {
    
    var userWins: Int
    var cpuWins: Int
    var ties: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer()
            Text("🎉")
                .font(.system(size: 128))
            Text("\(userWins)")
            Text("\(cpuWins)")
            Text("\(ties)")
          Text("You won!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .kerning(-1.5)
            Spacer()
            VStack(spacing: 20) {
                RoundedButton(foregroundColor: .black, background: Color(hex: "#FFC0FC"), text: "Play again")
                RoundedButton(foregroundColor: .black, background: Color(hex: "#E9F5C7"), text: "Quit game")
            }
            .frame(width: 200)
            Spacer()
        }
        .padding()
    }
}

//struct GameOverView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameOverView()
//    }
//}
