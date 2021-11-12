//
//  EndGame.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 15/04/21.
//

import SwiftUI

public struct EndGame: View {
    @EnvironmentObject var viewManager: ViewManager
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
                
                Text(!environment.endExtraLife ? "you just won a battle with \((environment.winner == .player1 ? environment.player1Points : environment.player2Points)!) boxes :)" : "unfortunately \((environment.winner == .player1 ? environment.player2Name : environment.player1Name)) lost all extra lives, so you just won a battle with \((environment.winner == .player1 ? environment.player1Points : environment.player2Points)!) boxes :)")
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
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color.darkColor.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)){
                viewManager.pages = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                environment.resetGame()
                restartGame = false
            }
        }
    }
}
