//
//  Timer.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 15/04/21.
//

import SwiftUI

public struct TimerView: View {
    @ObservedObject var environment: GameEnvironment
    
    @State var colorStroke = Color.darkColor
    
    public var body: some View {
        VStack{
            ZStack{
                VStack{
                    ZStack{
                        Circle()
                            .foregroundColor(environment.colorTurn)
                            .frame(width: UIScreen.main.bounds.height*0.050, height: UIScreen.main.bounds.height*0.050)
                        
                        Circle()
                            .trim(from: 0.0, to: environment.secondsRemaining)
                            .stroke(colorStroke, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                            .frame(width: UIScreen.main.bounds.height*0.070, height: UIScreen.main.bounds.height*0.070)
                            .rotationEffect(Angle(degrees: -90))
                            .foregroundColor(Color.clear)
                        
                        Text("\(environment.secondsRemainingInt)")
                            .font(.custom("Bebas Neue", size: 35))
                            .foregroundColor(Color.whiteColor)
                            .multilineTextAlignment(.center)
                            .shadow(color: Color.black.opacity(0.6),radius: 6)
                            .offset(x: 0, y: 2)
                    }
                    
                    Text((self.environment.secondsRemaining <= 0.20) ? "second remaining": "seconds remaining")
                        .font(.custom("Raleway-Regular", size: 14))
                        .foregroundColor(Color.whiteColor)
                        .multilineTextAlignment(.center)
                }
                
                Button(action: {
                    environment.pauseGame()
                }, label: {
                    Image(systemName: environment.pause! ? "play.circle.fill" : "pause.circle.fill")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.height*0.025, height: UIScreen.main.bounds.height*0.025, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.lightGreyColor)
                })
                .padding(.top, UIScreen.main.bounds.height*0.135)
                
            }
        }
        .onAppear(){
            self.environment.timer.upstream.connect().cancel()
            self.environment.timerFloat.upstream.connect().cancel()
            self.colorStroke = environment.colorTurn!
        }
        .onReceive(environment.timer) { _ in
            withAnimation(){
                if environment.secondsRemainingInt > 0 {
                    environment.secondsRemainingInt -= 1
                }
            }
        }
        .onReceive(environment.timerFloat) { _ in
            withAnimation(){
                if environment.secondsRemaining > 0 {
                    environment.secondsRemaining -= 0.02
                }
                else {
                    environment.countDownExtraLife()
                }
            }
        }.onChange(of: environment.endGame){ _ in
            self.environment.timer.upstream.connect().cancel()
            self.environment.timerFloat.upstream.connect().cancel()
            withAnimation(){
                self.environment.secondsRemaining = 1.0
                self.environment.secondsRemainingInt = 0
            }
        }
        .onChange(of: environment.colorTurn) { _ in
            if environment.turn == .player1 && environment.player1ExtraLife![0] == false {
                colorStroke = Color.red
                
            } else if environment.turn == .player2 && environment.player2ExtraLife![2] == false {
                colorStroke = Color.red
            } else {
                colorStroke = environment.colorTurn!
            }
        }
        .onChange(of: environment.player1ExtraLife![0]) { _ in
            colorStroke = Color.red
            
        }
        .onChange(of: environment.player2ExtraLife![2]) { _ in
            colorStroke = Color.red
        }
    }
}

