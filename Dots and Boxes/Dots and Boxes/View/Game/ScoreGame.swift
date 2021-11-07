//
//  ScoreGame.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 14/04/21.
//

import SwiftUI

public struct ScoreView: View {
    @ObservedObject var environment: GameEnvironment
    
    public var body: some View {
        HStack {
            // player 01
            ZStack(alignment: .top){
                HStack{
                    VStack(alignment: .leading){
                        Text("\(environment.player1Points!)")
                            .font(.custom("Bebas Neue", size: 90))
                            .foregroundColor(environment.player1Color)
                            .multilineTextAlignment(.leading)
                        
                        Text("\(environment.player1Name)")
                            .font(.custom("Raleway-Regular", size: 20))
                            .foregroundColor(Color.whiteColor)
                            .multilineTextAlignment(.leading)
                        
                        HStack {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.height*0.020, height: UIScreen.main.bounds.height*0.020)
                                .foregroundColor(environment.player1ExtraLife![0] ? environment.player1Color : Color.lightGreyColor)
                            
                            Image(systemName: "heart.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.height*0.020, height: UIScreen.main.bounds.height*0.020)
                                .foregroundColor(environment.player1ExtraLife![1] ? environment.player1Color : Color.lightGreyColor)
                            
                            Image(systemName: "heart.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.height*0.020, height: UIScreen.main.bounds.height*0.020)
                                .foregroundColor(environment.player1ExtraLife![2] ? environment.player1Color : Color.lightGreyColor)
                        }.padding(.bottom)
                    }.padding(.horizontal)
                    Spacer()
                }
            }
            .frame(width: UIScreen.main.bounds.height*0.175, height: UIScreen.main.bounds.height*0.175)
            .background(Color.darkGreyColor)
            .cornerRadius(11)
            .overlay(
                RoundedRectangle(cornerRadius: 11)
                    .stroke((self.environment.turn == .player1) ? environment.colorTurn as! Color : Color.clear, lineWidth: 1.5)
            )
            .shadow(color: Color.black.opacity(0.2),radius: 20)
            
            Spacer()
            
            // player 02
            ZStack(alignment: .bottomTrailing){
                HStack{
                    Spacer()
                    VStack(alignment: .trailing){
                        Text("\(environment.player2Points!)")
                            .font(.custom("Bebas Neue", size: 90))
                            .foregroundColor(environment.player2Color)
                            .multilineTextAlignment(.trailing)
                        
                        Text("\(environment.player2Name)")
                            .font(.custom("Raleway-Regular", size: 20))
                            .foregroundColor(Color.whiteColor)
                            .multilineTextAlignment(.trailing)
                        
                        HStack {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.height*0.020, height: UIScreen.main.bounds.height*0.020)
                                .foregroundColor(environment.player2ExtraLife![0] ? environment.player2Color : Color.lightGreyColor)
                            
                            Image(systemName: "heart.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.height*0.020, height: UIScreen.main.bounds.height*0.020)
                                .foregroundColor(environment.player2ExtraLife![1] ? environment.player2Color : Color.lightGreyColor)
                            
                            Image(systemName: "heart.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.height*0.020, height: UIScreen.main.bounds.height*0.020)
                                .foregroundColor(environment.player2ExtraLife![2] ? environment.player2Color : Color.lightGreyColor)
                        }.padding(.bottom)
                    }.padding(.horizontal)
                }
            }
            .frame(width: UIScreen.main.bounds.height*0.175, height: UIScreen.main.bounds.height*0.175)
            .background(Color.darkGreyColor)
            .cornerRadius(11)
            .overlay(
                RoundedRectangle(cornerRadius: 11)
                    .stroke((self.environment.turn == .player2) ? environment.colorTurn as! Color : Color.clear, lineWidth: 1.5)
            )
            .shadow(color: Color.black.opacity(0.2),radius: 20)
        }
        .padding([.top, .horizontal],50)
        .frame(width: UIScreen.main.bounds.width)
    }
}

