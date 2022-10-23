//
//  GameView.swift
//  handful
//
//  Created by Ritesh Kanchi on 10/22/22.
//

import SwiftUI
import Pow

let maxGameRounds = 3

struct GameView: View {
    
    @Binding var openGame: Bool
    
    @State private var gameRounds = 0
    @State private var userWins = 0
    @State private var cpuWins = 0
    @State private var ties = 0
    
    @State private var gameOver = false
    @State private var whoWon: RPSUserOutcome = .undefined
    
    @State private var userOption: RPSType = .undefined
    @State private var cpuOption: RPSType = .undefined
    
    @State private var overlayPoints: [FingerJointPointCG] = []
    
    @State private var nextRound = false
    
    var body: some View {
        if(!gameOver) {
            ZStack {
                VStack(spacing: 0) {
                    HStack {
                        CloseButton(color: .black)
                        Spacer()
                        Text("Round \(gameRounds + 1)/\(maxGameRounds)")
                            .fontWeight(.bold)
                    }
                    .padding()
                    .offset(y:20)
                    ComputerView(cpuWins: $cpuWins, cpuOption: $cpuOption, whoWon: $whoWon)
                    UserView(gameRounds: $gameRounds, userWins: $userWins, cpuWins: $cpuWins, ties: $ties, gameOver: $gameOver, cpuOption: $cpuOption, userOption: $userOption, overlayPoints: $overlayPoints, whoWon: $whoWon, nextRound: $nextRound)
                }
                
                
                
                if nextRound {
                    
                    
                    VisualEffectView(effect: UIBlurEffect(style: .prominent))
                        .edgesIgnoringSafeArea(.all)
                        .transition(.movingParts.blur)
                    
                    
                    VStack(alignment: .center, spacing: 20) {
                        HStack(alignment: .center, spacing: 10) {
                            Text(getEmojiFromType(userOption))
                                .font(.largeTitle)
                                .rotationEffect(Angle(degrees: -15))
                            Text("VS")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text(getEmojiFromType(cpuOption))
                                .font(.largeTitle)
                                .rotationEffect(Angle(degrees: 15))
                        }
                        GeneralTitle(text: getTextFromRoundWin())
                        Button(action: {
                            withAnimation {
                                continueLogic()
                            }
                        }) {
                            RoundedButton(foregroundColor: .black, background: .white, text: gameRounds == 2 ? "Final score" : "Next round")
                                .frame(width: 200)
                        }
                    }
                    .padding(40)
                    .background(.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .frame(width: 350, height: 600)
                    .transition(.movingParts.pop(.black))
                    
                    
                }
                
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                VStack(spacing: 0) {
                    Color(hex: "#FFC0FC")
                    Color(hex: "#E9F5C7")
                }
                .edgesIgnoringSafeArea(.all)
            }  } else {
                GameOverView(gameRounds: $gameRounds, userWins: $userWins, cpuWins: $cpuWins, ties: $ties, gameOver: $gameOver, cpuOption: $cpuOption, userOption: $userOption, whoWon: $whoWon, openGame: $openGame)
            }
    }
    
    
    func getTextFromRoundWin() -> String {
        
        switch whoWon {
        case .win:
            return "You won this round!"
        case .lose:
            return "You lost this round."
        case .tie:
            return "You tied this round!"
        default:
            return "Who knows?"
        }
    }
    
    
    func continueLogic() {
        
        userOption = .undefined
        cpuOption = .undefined
        whoWon = .undefined
        
        
        gameRounds += 1
        
        if gameRounds >= maxGameRounds {
            gameOver = true
        }
        
        nextRound = false
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(openGame: .constant(true))
    }
}

struct ComputerView: View {
    
    @Binding var cpuWins: Int
    @Binding var cpuOption: RPSType
    @Binding var whoWon: RPSUserOutcome
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                VStack {
                    Text(getEmojiFromType(cpuOption))
                        .font(.system(size: 128))
                }
                .frame(width: 280, height: 280)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .fixedSize()
            }
            .frame(width: 300, height: 300)
            .overlay{
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .strokeBorder(.white.opacity(0.5), style: StrokeStyle(lineWidth: 20))
            }
            Spacer()
            
        }
        .padding()
    }
}

struct UserView: View {
    
    @Binding var gameRounds: Int
    @Binding var userWins: Int
    @Binding var cpuWins: Int
    @Binding var ties: Int
    
    @Binding var gameOver: Bool
    
    @Binding var cpuOption: RPSType
    @Binding var userOption: RPSType
    @Binding var overlayPoints: [FingerJointPointCG]
    
    @Binding var whoWon: RPSUserOutcome
    
    @Binding var nextRound: Bool
    
    @StateObject var camera = CameraModel()
    
    var body: some View {
        VStack {
            Spacer()
            DetectionView(option: gestureToOption(overlayPoints), hand: !overlayPoints.isEmpty, userWins: userWins, cpuWins: cpuWins)
            CameraGameView(overlayPoints: $overlayPoints)
            Spacer()
            Button(action: {
                withAnimation {
                    userOption = gestureToOption(overlayPoints)
                    gameLogic()
                }
            }) {
                RoundedButton(foregroundColor: .black, background: Color(hex: "#FFC0FC"), text: overlayPoints.isEmpty || getGesture(overlayPoints) == .undefined ? "Select an option" : "Confirm option")
                    .frame(width: 200)
            } .opacity(overlayPoints.isEmpty || getGesture(overlayPoints) == .undefined ? 0.5 : 1)
                .disabled(overlayPoints.isEmpty || getGesture(overlayPoints) == .undefined ? true : false)
            
                .padding([.top, .horizontal])
            Spacer()
        }
        .padding()
    }
    
    
    
    
    func computerDecision() -> RPSType {
        let decision = Int.random(in: 1..<4)
        switch decision {
        case 1:
            return .rock
        case 2:
            return .paper
        case 3:
            return .scissors
        default:
            return .undefined
        }
    }
    
    func gameLogic() {
        
        
        let outcome = whoWonTheGame()
        
        whoWon = outcome
        
        switch outcome {
        case .win:
            userWins += 1
        case .lose:
            cpuWins += 1
        case .tie:
            ties += 1
        default:
            break
        }
        
        nextRound = true
        
        
    }
    
    func whoWonTheGame() -> RPSUserOutcome {
        
        let compOption =  computerDecision()
        
        cpuOption = compOption
        
        if (userOption == compOption) {
            return .tie
        }
        
        if(userOption == .rock && compOption == .scissors) {
            return .win
        }
        
        if(userOption == .paper && compOption == .rock) {
            return .win
        }
        
        
        if(userOption == .scissors && compOption == .paper) {
            return .win
        }
        
        if(compOption == .rock && userOption == .scissors) {
            return .lose
        }
        
        if(compOption == .paper && userOption == .rock) {
            return .lose
        }
        
        
        if(compOption == .scissors && userOption == .paper) {
            return .lose
        }
        
        return .undefined
        
    }
    
}

struct DetectionView: View {
    
    var option: RPSType
    var hand: Bool
    
    var userWins: Int
    var cpuWins: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 5) {
                Text("\(userWins)")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("You")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            Spacer()
            if hand {
                if option == .undefined {
                    Text("No gesture found.\nTry matching one of the gestures.")
                } else {
                    Text("Detected:\n\(getEmojiFromType(option)), \(getTextFromType(option))")
                }
            } else {
                Text("We couldn't find your hand.\nPlease reposition your hand.")
            }
            Spacer()
            VStack(alignment: .center, spacing: 5) {
                Text("\(cpuWins)")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Robot")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
        .foregroundColor(.black)
        .fontWeight(.medium)
        .font(.footnote)
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .offset(y: -20)
    }
}

struct CameraGameView: View {
    
    @State private var animateGradient = true
    
    @Binding var overlayPoints: [FingerJointPointCG]
    
    @StateObject var camera = CameraModel()
    
    @State private var timeRemaining = 3
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            CameraView(camera: camera) {
                overlayPoints = $0
            }
            .overlay {
                CameraOverlayView(overlayPoints: overlayPoints)
                if(gestureToOption(overlayPoints) != .undefined) {
                    Text(getEmojiFromType(gestureToOption(overlayPoints)))
                        .font(.system(size: 128))
                        .position(x: 140, y: 140)
                }
            }
//                                    Rectangle()
//                                    .fill(.blue)
            .frame(width: 280, height: 280)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .fixedSize()
        }
        .frame(width: 300, height: 300)
        .overlay{
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .strokeBorder(.white.opacity(0.5), style: StrokeStyle(lineWidth: 20))
        }
        .onAppear(perform: {
            camera.Check()
            withAnimation(.linear(duration: 1).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        })
    }
    
}

