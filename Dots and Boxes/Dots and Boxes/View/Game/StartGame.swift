//
//  StartView.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 15/04/21.
//

import SwiftUI

public struct StartView: View {
    @Binding var startGame: Bool
    @State var showText = false
    var player1Color: Color?
    var player2Color: Color?
    @State var offset = 115
    @State var showBox = false
    @State var boxAnimation: CGFloat = 0.0
    @State var timerFloat = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    
    
    public var body: some View {
        ZStack{
            // box
            ZStack{
                
                Rectangle()
                    .trim(from: 0.0, to: self.boxAnimation)
                    .stroke(Color.whiteColor, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                    .frame(width: 230, height: 230, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
            // dots
            ZStack{
                Circle()
                    .foregroundColor(Color.whiteColor)
                    .frame(width: 20, height: 20)
                    .shadow(radius: 3)
                    .offset(x: -CGFloat(self.offset), y: -CGFloat(self.offset))
                Circle()
                    .foregroundColor(Color.whiteColor)
                    .frame(width: 20, height: 20)
                    .shadow(radius: 3)
                    .offset(x: -CGFloat(self.offset), y: CGFloat(self.offset))
                Circle()
                    .foregroundColor(Color.whiteColor)
                    .frame(width: 20, height: 20)
                    .shadow(radius: 3)
                    .offset(x: CGFloat(self.offset), y: CGFloat(self.offset))
                Circle()
                    .foregroundColor(Color.whiteColor)
                    .frame(width: 20, height: 20)
                    .shadow(radius: 3)
                    .offset(x: CGFloat(self.offset), y: -CGFloat(self.offset))
            }.frame(width: 250, height: 250)
            
            ZStack(alignment: .bottomLeading){
                Image(uiImage: UIImage(imageLiteralResourceName: "logoWithoutDots"))
                    .resizable()
                    .frame(width: 210, height: 210, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Circle()
                    .foregroundColor(player2Color)
                    .frame(width: 43, height: 43)
                    .padding(.leading, 48)
                    .padding(.bottom, 13)
                
                Circle()
                    .foregroundColor(player1Color)
                    .frame(width: 43, height: 43)
                    .padding(.leading, 48)
                    .padding(.bottom, 65)
            }.opacity(self.showBox ? 1 : 0)
            
            VStack(alignment: .center){
                Spacer()
                Text("tap to start the game")
                    .foregroundColor(Color.whiteColor)
                    .font(.custom("Raleway-Regular", size: 17))
                    .opacity(showText ? 1 : 0)
                Spacer()
                    .frame(height: 170)
                
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color.darkColor.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        .onTapGesture {
//            AudioPlayer.shared.play(name: "discoveredSound", volume: 0.5, delay: 0.0)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                self.startGame = true
//            }
            withAnimation(.easeInOut(duration: 0.5)){
                self.startGame = true
            }
        }
        .onReceive(self.timerFloat) { _ in
            withAnimation(){
                if boxAnimation < 1 {
                    boxAnimation += 0.25
                } else {
                    self.timerFloat.upstream.connect().cancel()
                    self.showBox = true
                    AudioPlayer.shared.play(name: "boxSound", volume: 0.2, delay: 0.0)
                    withAnimation(.easeInOut(duration: 0.5)){
                        self.showText = true
                    }
                    
                }
            }
        }
    }
}
