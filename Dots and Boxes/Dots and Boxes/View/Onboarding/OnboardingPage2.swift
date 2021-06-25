//
//  OnboardingPage2.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 16/04/21.
//

import SwiftUI

public struct OnboardingPage2: View {
    @EnvironmentObject var onboarding: Onboarding
  
    @State var textAnimation = false
    @State var secondtext = false
    @State var offset = 105
    @State var timerFloat = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var boxAnimation: CGFloat = 0.0
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .center) {
        
            Rectangle()
                .trim(from: 0.0, to: self.boxAnimation)
                .stroke(Color.whiteColor.opacity(0.5), style: StrokeStyle(lineWidth: 3, lineCap: .round))
                .frame(width: 210, height: 210, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
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
                Text("in an experiment, people tried to connect them…")
                    .font(.custom("Raleway-Regular", size: 24))
                    .foregroundColor(Color.whiteColor)
                    .frame(width: 540)
                    .multilineTextAlignment(.center)
                    .lineSpacing(8)
                    .opacity(self.textAnimation ? 1 : 0)
                Spacer().frame(height:30)
                Text("…and they discovered something totally new and valuable.")
                    .font(.custom("Raleway-Regular", size: 24))
                    .foregroundColor(Color.whiteColor)
                    .frame(width: 470)
                    .multilineTextAlignment(.center)
                    .lineSpacing(8)
                    .opacity(self.secondtext ? 1 : 0)
                Spacer()
                    .frame(height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
        }
        .frame(width: 770, height: 1000)
        .background(Color.darkColor)
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                withAnimation(){
                    self.textAnimation = true
                }
            }
        }
        .onTapGesture {
            if !self.secondtext {
                withAnimation(.easeOut(duration: 1.0)) {
                    self.secondtext = true
                }
            } else {
                // go to next page of onboarding
                onboarding.page = 2
            }
        }
        .onReceive(self.timerFloat) { _ in
            withAnimation(){
                if boxAnimation < 1 {
                    boxAnimation += 0.04
                    
                } else {
                    self.timerFloat.upstream.connect().cancel()
                    withAnimation(.easeOut(duration: 1.0)) {
                        self.secondtext = true
                    }
                }
            }
        }
    }
}

