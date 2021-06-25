//
//  OnboardingPage5.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 17/04/21.
//

import SwiftUI

public struct OnboardingPage5: View {
    @EnvironmentObject var onboarding: Onboarding
    
    @State var firstTextAnimation = false
    @State var secondTextAnimation = false
    @State var finalScreenOnboarding = false
    @State var textHidden = false
    @State var offset = 105
    @State var showArenaExemples = false
    @State var afterDiscoveredArena = false
    @State var showBox = false
    @State var timerFloat = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @State var boxAnimation: CGFloat = 0.0
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .center) {
            // box
            ZStack{
                Rectangle()
                    .frame(width: 190, height: 190, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.whiteColor)
                    .cornerRadius(5)
                    .opacity(self.showBox ? 1 : 0)
                Rectangle()
                    .trim(from: 0.0, to: self.boxAnimation)
                    .stroke(Color.whiteColor, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                    .frame(width: 210, height: 210, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }.opacity(self.secondTextAnimation ? 0 : 1)
            
            Rectangle()
                .frame(width: 190, height: 190, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.whiteColor)
                .cornerRadius(5)
                .opacity(self.showBox ? 1 : 0)
            
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
            }.frame(width: 230, height: 230)
            .opacity(self.secondTextAnimation ? 0 : 1)
            
            // text
            VStack{
                Spacer()
                if self.finalScreenOnboarding {
                    VStack{
                        HStack{
                            Text("welcome to")
                                .font(.custom("Raleway-Regular", size: 24))
                                .foregroundColor(Color.whiteColor)
                                .multilineTextAlignment(.center)
                                .lineSpacing(6)
                            Text("DOTS and BOXES")
                                .font(.custom("Raleway-Bold", size: 24))
                                .foregroundColor(Color.whiteColor)
                                .multilineTextAlignment(.center)
                                .lineSpacing(6)
                            Text("playground")
                                .font(.custom("Raleway-Regular", size: 24))
                                .foregroundColor(Color.whiteColor)
                                .multilineTextAlignment(.center)
                                .lineSpacing(6)
                        }
                        Spacer().frame(height:20)
                        Text("please go to the next page to try the game")
                            .font(.custom("Raleway-Regular", size: 17))
                            .foregroundColor(Color.whiteColor)
                            .frame(width: 550)
                            .multilineTextAlignment(.center)
                            .lineSpacing(8)
                    }.opacity(self.secondTextAnimation ? 1 : 0)
                } else {
                    Text("it's your time to conquer the BOXES \n and be part of the future too.")
                        .font(.custom("Raleway-Regular", size: 24))
                        .foregroundColor(Color.whiteColor)
                        .frame(width: 550)
                        .multilineTextAlignment(.center)
                        .lineSpacing(8)
                        .opacity(self.textHidden ? 0 : 1)
                }
                Spacer()
                    .frame(height: 130, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
            // logo
            VStack{
                Image(uiImage: UIImage(imageLiteralResourceName: "logoWithoutBox"))
                    .resizable()
                    .frame(width: 190, height: 190, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .opacity(self.secondTextAnimation ? 1 : 0)
            }
            
        }
        .opacity(self.firstTextAnimation ? 1 : 0)
        .frame(width: 770, height: 1000)
        .background(Color.darkColor)
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                withAnimation(){
                    self.firstTextAnimation = true
                }
            }
        }
        .onTapGesture {
            if self.showBox {
                self.textHidden = true
                self.finalScreenOnboarding = true
                AudioPlayer.shared.play(name: "discoveredSound", volume: 0.4, delay: 0.0)
                withAnimation(.easeOut(duration: 0.5)) {
                    self.secondTextAnimation = true
                }
            } else {
                // end of onboarding
            }
        }
        .onReceive(self.timerFloat) { _ in
            withAnimation(){
                if boxAnimation < 1 {
                    boxAnimation += 0.25
                } else {
                    self.timerFloat.upstream.connect().cancel()
                    self.showBox = true
                }
            }
        }
    }
}


