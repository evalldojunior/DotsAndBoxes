//
//  EndGame.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 15/04/21.
//

import SwiftUI

public struct EndGame: View {
    @ObservedObject var environment: GameEnvironment
    @Binding var restartGame: Bool
    
    public var body: some View {
        ZStack{
            VStack{
                ZStack{
                    // box
                    Rectangle()
                        .foregroundColor(environment.winner == .player1 ? environment.player1Color : environment.player2Color)
                        .frame(width: 105, height: 105, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(6)
                    
                    Image(systemName: "crown.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.white)
                        .shadow(color: Color.black.opacity(0.4),radius: 6)
                    Rectangle()
                        .frame(width: 120, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.clear)
                        .border(environment.winner == .player1 ? environment.player1Color : environment.player2Color, width: 3)
                        .cornerRadius(6)
                    // dots
                    VStack{
                        HStack{
                            Circle()
                                .foregroundColor(Color.whiteColor)
                                .frame(width: 13, height: 13, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Spacer()
                            Circle()
                                .foregroundColor(Color.whiteColor)
                                .frame(width: 13, height: 13, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                        Spacer()
                        HStack{
                            Circle()
                                .foregroundColor(Color.whiteColor)
                                .frame(width: 13, height: 13, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Spacer()
                            Circle()
                                .foregroundColor(Color.whiteColor)
                                .frame(width: 13, height: 13, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                    }.frame(width: 130, height: 130, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                
                Spacer().frame(height:20)
                
                Text("congratulations, \(environment.winner == .player1 ? environment.player1Name : environment.player2Name)!")
                    .font(.custom("Bebas Neue", size: 30))
                    .foregroundColor(Color.whiteColor)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text(!environment.endExtraLife ? "you just won a battle with \((environment.winner == .player1 ? environment.player1Points : environment.player2Points)!) boxes :)\n now try to challenge other players." : "unfortunately \((environment.winner == .player1 ? environment.player2Name : environment.player1Name)) lost all extra lives, so you just won a battle with \((environment.winner == .player1 ? environment.player1Points : environment.player2Points)!) boxes :)\n\n now try to challenge other players.")
                    .font(.custom("Raleway", size: 20))
                    .foregroundColor(Color.whiteColor)
                    .multilineTextAlignment(.center)
                    .lineSpacing(environment.endExtraLife ? 10.0 : 15.0)
                    .frame(width: 400)
                    .padding(.bottom)
                
                if !environment.endExtraLife {
                    HStack{
                        Text("\(environment.player1Points!)")
                            .font(.custom("Bebas Neue", size: 90))
                            .foregroundColor(environment.player1Color)
                            .multilineTextAlignment(.trailing)
                            .padding(.bottom, -20)
                        Text("VS")
                            .font(.custom("Bebas Neue", size: 30))
                            .foregroundColor(Color.whiteColor)
                            .multilineTextAlignment(.center)
                            .padding()
                            .padding(.bottom, -15)
                        Text("\(environment.player2Points!)")
                            .font(.custom("Bebas Neue", size: 90))
                            .foregroundColor(environment.player2Color)
                            .multilineTextAlignment(.trailing)
                            .padding(.bottom, -20)
                    }
                }
            }.frame(width: 470, height: 470, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.darkGreyColor)
            .cornerRadius(11)
            .shadow(color: Color.black.opacity(0.1),radius: 15)
            
            VStack{
                Spacer()
                Text("tap to try again")
                    .font(.custom("Raleway", size: 17))
                    .foregroundColor(Color.whiteColor)
                    .multilineTextAlignment(.center)
                    .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    .padding()
                Spacer().frame(height: 130)
            }
            
            VStack {
                Spacer()
                HStack{
                    Image(systemName: "lightbulb.fill")
                        .resizable()
                        .frame(width: 15, height: 23, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.lightGreyColor)
                    
                    Text("modify the attributes on the left side for a new and different game")
                        .font(.custom("Raleway-Regular", size: 16))
                        .foregroundColor(Color.lightGreyColor)
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                }
                Spacer()
                    .frame(height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
        .background(Color.darkColor)
        .onTapGesture {
            // restart game
            environment.resetGame()
            restartGame = false
        }
    }
}
