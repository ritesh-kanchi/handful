//
//  GameOverView.swift
//  handful
//
//  Created by Ritesh Kanchi on 10/23/22.
//

import SwiftUI

struct GameOverView: View {
    
    @Binding var gameRounds: Int
    @Binding var userWins: Int
    @Binding var cpuWins: Int
    @Binding var ties: Int
    
    @Binding var gameOver: Bool
    
    @Binding var cpuOption: RPSType
    @Binding var userOption: RPSType
    
    @Binding var whoWon: RPSUserOutcome
    
    @Binding var openGame: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer()
            Text(getEmojiFromWin())
                .font(.system(size: 128))
            Text(getTextFromWin())
                .font(.largeTitle)
                .fontWeight(.bold)
                .kerning(-1.5)
            HStack(alignment: .top, spacing: 30) {
                Spacer()
                ScoreItem(number: userWins, text: "Wins")
                ScoreItem(number: cpuWins, text: "Losses")
                if(ties > 0) {
                    ScoreItem(number: ties, text: "Ties")
                }
                Spacer()
            }
            Spacer()
            VStack(spacing: 20) {
                Button(action: {
                    resetGame()
                }) {
                    RoundedButton(foregroundColor: .black, background: Color(hex: "#FFC0FC"), text: "Play again")
                }
                Button(action: {
                    openGame = false
                }) {
                    RoundedButton(foregroundColor: .black, background: Color(hex: "#E9F5C7"), text: "Quit game")
                }
            }
            .frame(width: 200)
            Spacer()
        }
        .padding()
    }
    
    func getEmojiFromWin() -> String {
        
        if userWins > cpuWins {
            return "🎉"
        }
        
        if cpuWins > userWins {
            return "😢"
        }
        
        if ties == 3 {
            return "🙃"
        }
        
        return "🤖"
    }
    
    func getTextFromWin() -> String {
        if userWins > cpuWins {
            return "You won!"
        }
        
        if cpuWins > userWins {
            return "Better luck next time!"
        }
        
        if ties == 3 {
            return "That's lucky."
        }
        
        return "Uh..."
    }
    
    func resetGame() {
        gameRounds = 0
        userWins = 0
        cpuWins = 0
        ties = 0
        
        gameOver = false
        whoWon = .undefined
        
        userOption = .undefined
        cpuOption = .undefined
    }
}

//struct GameOverView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameOverView()
//    }
//}

private struct ScoreItem: View {
    var number: Int
    var text: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("\(number)")
                .font(.title)
                .fontWeight(.bold)
            Text(text)
                .fontWeight(.medium)
                .foregroundColor(.gray)
        }
    }
}