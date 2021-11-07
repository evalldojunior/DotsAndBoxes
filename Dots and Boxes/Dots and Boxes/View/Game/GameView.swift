//
//  GameView.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 14/04/21.
//

import SwiftUI

public struct GameView: View {
    @ObservedObject var environment: GameEnvironment
    
    var rowCount = 9
    var colCount = 9
    var maxFrameGame = CGFloat(UIScreen.main.bounds.height*0.625)
    var boxSize = CGFloat(UIScreen.main.bounds.height*0.069)
    @State var startGame = false
    @State var endGame = false
    
    
    public init(player1Name: String, player2Name: String, player1Color: Color, player2Color: Color, nOrder: Int) {
        // 3 <= nOrder <= 9
        if nOrder < 3 {
            self.rowCount = 3
            self.colCount = 3
        } else if nOrder > 9 {
            self.rowCount = 9
            self.colCount = 9
        } else {
            self.rowCount = nOrder
            self.colCount = nOrder
        }
        
        self.environment = GameEnvironment(rowCount: self.rowCount, colCount: self.colCount, player1Name: player1Name, player2Name: player2Name, player1Color: player1Color, player2Color: player2Color)
    }
    
    public var body: some View {
        VStack(alignment: .center) {
        
            // game
            if !environment.endGame {
                ZStack {
                    Rectangle()
                        .frame(width: boxSize*CGFloat(colCount)+CGFloat((20-colCount)), height: boxSize*CGFloat(rowCount)+CGFloat((20-rowCount)))
                        .foregroundColor(Color.darkGreyColor)
                        .cornerRadius(11)
                        .shadow(color: Color.black.opacity(0.2),radius: 20)
                    
                    // boxes and lines
                    VStack{
                        ForEach(0..<rowCount) { indexX in
                            HStack{
                                ForEach(0..<colCount) { indexY in
                                    
                                    BoxView(environment: environment, indexX: indexX, indexY: indexY, box: environment.allBoxes[indexX][ indexY])
                                        .frame(width: boxSize, height: boxSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .padding(-7)
                                    
                                }
                            }
                        }
                    }
                    .opacity(self.environment.pause! ? 0 : 1)
                    
                    // dots
                    VStack{
                        ForEach(0..<rowCount+1) { indexX in
                            HStack{
                                ForEach(0..<colCount+1) { indexY in
                                    Dot()
                                        .padding(-2)
                                    if (indexY < colCount) {
                                        Spacer().frame(width: boxSize-15)
                                    }
                                }
                            }
                            if (indexX < rowCount) {
                                Spacer().frame(height: boxSize-15)
                            }
                        }
                    }.opacity(self.environment.pause! ? 0 : 1)
                    
                    // game paused
                    ZStack{
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width-100, height: UIScreen.main.bounds.width-100)
                            .foregroundColor(Color.darkGreyColor)
                            .cornerRadius(11)
                            
                        
                        VStack{
                            Text("game paused")
                                .font(.custom("Bebas Neue", size: 40))
                                .foregroundColor(Color.whiteColor)
                                .multilineTextAlignment(.center)
                            Spacer().frame(height: 20)
                            Text("you can't see the arena\n when the game is paused")
                                .font(.custom("Raleway-Regular", size: 14))
                                .foregroundColor(Color.whiteColor)
                                .multilineTextAlignment(.center)
                                .lineSpacing(10)
                        }.padding(.bottom, -50)
                        
                    }
                    
                    .opacity(self.environment.pause! ? 0 : 0)
                    .onTapGesture {
                        self.environment.pauseGame()
                    }
                    
                    
                }
                .frame(width: maxFrameGame, height: maxFrameGame)
                .disabled(environment.endGame)
                Spacer().frame(height: 40)
                
                // score and timer
                ZStack{
                    ScoreView(environment: environment)
                    TimerView(environment: environment)
                }
            }
            
            if environment.endGame {
                Spacer().frame(height: 40)
                EndGame(environment: environment, restartGame: $endGame)
                    .opacity(self.endGame ? 1 : 0)
            }
            
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color.darkColor.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        .onAppear(){
            self.environment.pause = true
        }
        .onChange(of: self.startGame) { _ in
            self.environment.pauseGame()
        }
        .onChange(of: environment.endGame){ _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeOut(duration: 1.5)){
                    self.endGame = true
                }
            }
        }
        .overlay(StartView(startGame: $startGame, player1Color: environment.player1Color, player2Color: environment.player2Color).opacity(self.startGame ? 0 : 0).animation(.easeInOut(duration: 0.3)))
        
    }
}

