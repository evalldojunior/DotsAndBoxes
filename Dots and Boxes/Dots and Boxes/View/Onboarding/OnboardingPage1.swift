//
//  OnboardingPage1.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 16/04/21.
//

import SwiftUI

public struct OnboardingPage1: View {
    @EnvironmentObject var onboarding: Onboarding

    @State var dotsMultiply = false
    @State var textHidden = false
    @State var offset = 0
    @State var textAnimation = false
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .center) {
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
            
            VStack{
                Spacer()
                if self.dotsMultiply {
                    VStack{
                        Text("…and the DOT started to multiply.")
                            .font(.custom("Raleway-Regular", size: 24))
                            .foregroundColor(Color.whiteColor)
                            .frame(width: 470)
                            .multilineTextAlignment(.center)
                            .lineSpacing(8)
                        Spacer().frame(height:30)
                        Text("nobody knows what they are.")
                            .font(.custom("Raleway-Regular", size: 24))
                            .foregroundColor(Color.whiteColor)
                            .frame(width: 470)
                            .multilineTextAlignment(.center)
                            .lineSpacing(8)
                    }.opacity(self.textAnimation ? 1 : 0)
                } else {
                    Text("in the beginning was the DOT…")
                        .font(.custom("Raleway-Regular", size: 24))
                        .foregroundColor(Color.whiteColor)
                        .frame(width: 470)
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                        .opacity(self.textHidden ? 0 : 1)
                }
                Spacer()
                    .frame(height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
            VStack {
                Spacer()
                HStack{
                    Image(systemName: "lightbulb.fill")
                        .resizable()
                        .frame(width: 15, height: 23, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.lightGreyColor)

                    Text("you can use tap gesture to interact with the playground")
                        .font(.custom("Raleway-Regular", size: 16))
                        .foregroundColor(Color.lightGreyColor)
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                }
                Spacer()
                    .frame(height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
        }
        .frame(width: 770, height: 1000)
        .background(Color.darkColor)
        .onTapGesture {
            if !self.dotsMultiply {
                AudioPlayer.shared.play(name: "discoveredSound", volume: 0.4, delay: 0.0)
                self.textHidden = true
                withAnimation(.easeOut(duration: 2.0)) {
                    self.dotsMultiply = true
                    self.offset = 105
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation() {
                        self.textAnimation = true
                    }
                }
            } else {
               // go to next page of onboarding
                if self.dotsMultiply {
                    onboarding.page = 1
                }
            }
        }
    }
}


