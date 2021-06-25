//
//  OnboardingPage3.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 16/04/21.
//

import SwiftUI

public struct OnboardingPage3: View {
    @EnvironmentObject var onboarding: Onboarding
    
    @State var discoveredBox = false
    @State var textHidden = true
    @State var offset = 105
    @State var boxIsComplete = false
    @State var afterDiscoveredBox = false
    @State var textAnimation = false
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .center) {
            // box
            BoxTutorial(isComplete: $boxIsComplete)
                .frame(width: 215, height: 215, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(-7)
            
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
            
            // text
            VStack{
                Spacer()
                if self.discoveredBox {
                    VStack{
                        Text("they discovered the BOX…")
                            .font(.custom("Raleway-Regular", size: 24))
                            .foregroundColor(Color.whiteColor)
                            .frame(width: 470)
                            .multilineTextAlignment(.center)
                            .lineSpacing(6)
                        Spacer().frame(height:30)
                        Text("…and the BOX is the future.")
                            .font(.custom("Raleway-Regular", size: 24))
                            .foregroundColor(Color.whiteColor)
                            .frame(width: 470)
                            .multilineTextAlignment(.center)
                            .lineSpacing(6)
                    }.opacity(self.textAnimation ? 1 : 0)
                        
                } else {
                    Text(!self.afterDiscoveredBox ? "you can try to connect them too,\n just tap between the DOTS" : "now everyone wants to\n conquer the BOXES,\n\n but the DOTS are limited.")
                        .font(.custom("Raleway-Regular", size: 24))
                        .foregroundColor(Color.whiteColor)
                        .frame(width: 470)
                        .multilineTextAlignment(.center)
                        .lineSpacing(10)
                        .opacity(self.textHidden ? 0 : 1)
                }
                Spacer()
                    .frame(height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
            // logo
            VStack{
                Image(uiImage: UIImage(imageLiteralResourceName: "logoWithoutBox"))
                    .resizable()
                    .frame(width: 190, height: 190, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .opacity(self.textHidden ? 1 : 0)
            }
            
        }
        .frame(width: 770, height: 1000)
        .background(Color.darkColor)
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                withAnimation(){
                    self.textHidden = false
                }
            }
        }
        .onChange(of: self.boxIsComplete) {_ in
            self.textHidden = true
            self.discoveredBox = true
            AudioPlayer.shared.play(name: "boxSound", volume: 0.4, delay: 0.0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeOut(duration: 1.5)) {
                    self.textAnimation = true
                }
            }
        }
        .onTapGesture {
            if self.boxIsComplete {
                if !self.afterDiscoveredBox {
                    self.discoveredBox = false
                    self.afterDiscoveredBox = true
                    withAnimation(){
                        self.textHidden = false
                    }
                } else {
                    // go to next page of onboarding
                    onboarding.page = 3
                }
            }
        }
    }
}

public struct BoxTutorial: View {
    
    @State var colorTop = Color.whiteColor.opacity(0.02)
    @State var colorBottom = Color.whiteColor.opacity(0.02)
    @State var colorLeft = Color.whiteColor.opacity(0.02)
    @State var colorRight = Color.whiteColor.opacity(0.02)
    
    @Binding var isComplete: Bool
    
    var box: Box = Box()
    
    func tapped(line: chosenLineType) {
        AudioPlayer.shared.play(name: "tapLine", volume: 0.3, delay: 0.0)
        if line == .top {
            if !box.top! {
                box.top = true
                withAnimation(){
                    colorTop = Color.whiteColor
                }
            }
        } else if line == .bottom {
            if !box.bottom! {
                box.bottom = true
                withAnimation(){
                    colorBottom = Color.whiteColor
                }
            }
        } else if line == .left {
            if !box.left! {
                box.left = true
                withAnimation(){
                    colorLeft = Color.whiteColor
                }
            }
        } else {
            if !box.right! {
                box.right = true
                withAnimation(){
                    colorRight = Color.whiteColor
                }
            }
        }
    
        if self.box.checkCompleteBox(colorBox: Color.whiteColor) {
            withAnimation(){
                isComplete = true
            }
        }
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack{
                Rectangle()
                    .foregroundColor(isComplete ? Color.whiteColor : Color.darkColor)
                    .cornerRadius(5)
                    .padding(10.5)
                
                VStack{
                    Line()
                        .foregroundColor(colorTop)
                        .frame(width: geometry.size.width, height: 5)
                        .onTapGesture {
                            tapped(line: .top)
                        }
                    Spacer()
                    Line()
                        .foregroundColor(colorBottom)
                        .frame(width: geometry.size.width, height: 5)
                        .onTapGesture {
                            tapped(line: .bottom)
                        }
                }
                HStack{
                    Line()
                        .foregroundColor(colorLeft)
                        .frame(width: 5, height: geometry.size.height)
                        .onTapGesture {
                            tapped(line: .left)
                        }
                    Spacer()
                    Line()
                        .foregroundColor(colorRight)
                        .frame(width: 5, height: geometry.size.height)
                        .onTapGesture {
                            tapped(line: .right)
                        }
                }
            }
        }
    }
}
