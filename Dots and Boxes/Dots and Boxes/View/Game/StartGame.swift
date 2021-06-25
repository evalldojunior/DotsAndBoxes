//
//  StartView.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 15/04/21.
//

import SwiftUI

public struct StartView: View {
    @Binding var startGame: Bool
    @State var showColors = false
    var player1Color: Color?
    var player2Color: Color?
    
    public var body: some View {
        ZStack{
            
            ZStack(alignment: .bottomLeading){
                Image(uiImage: UIImage(imageLiteralResourceName: "logoWithoutDots"))
                    .resizable()
                    .frame(width: 210, height: 210, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Circle()
                    .foregroundColor(showColors ? player1Color : Color.darkColor)
                    .frame(width: 43, height: 43)
                    .padding(.leading, 48)
                    .padding(.bottom, 13)
                
                Circle()
                    .foregroundColor(showColors ? player2Color : Color.darkColor)
                    .frame(width: 43, height: 43)
                    .padding(.leading, 48)
                    .padding(.bottom, 65)
            }
            
            VStack(alignment: .center){
                Spacer()
                Text(self.showColors ? "..." : "tap to start the game")
                    .foregroundColor(Color.whiteColor)
                    .font(.custom("Raleway-Regular", size: 17))
                Spacer()
                    .frame(height: 170)
                
            }
        }
        .frame(width: 770, height: 1000)
        .background(Color.darkColor)
        .onTapGesture {
            AudioPlayer.shared.play(name: "discoveredSound", volume: 0.5, delay: 0.0)
            withAnimation(){
                self.showColors = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.startGame = true
                
            }
        }
    }
}
