//
//  OnboardingPage4.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 16/04/21.
//

import SwiftUI

public struct OnboardingPage4: View {
    @EnvironmentObject var onboarding: Onboarding
    
    @State var firstTextAnimation = false
    @State var secondTextAnimation = false
    @State var discoveredArena = false
    @State var textHidden = false
    @State var showArenaExemples = false
    @State var afterDiscoveredArena = false
    
    let imageExemple = [UIImage(imageLiteralResourceName: "arenaExample1"), UIImage(imageLiteralResourceName: "arenaExample2"), UIImage(imageLiteralResourceName: "arenaExample3")]
    @State var indexImage = 0
    @State var imageTimer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .center) {
            // arena
            ZStack {
                Rectangle()
                    .frame(width: 500, height: 500, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.darkGreyColor)
                    .cornerRadius(11)
                    .shadow(color: Color.black.opacity(0.2),radius: 20)
                    //.opacity(self.isComplete ? 1 : 1)
                    .padding(.bottom, 190)
                
                VStack{
                    Image(uiImage: self.showArenaExemples ? imageExemple[indexImage] : UIImage(imageLiteralResourceName: "emptyArena"))
                        .resizable()
                        .scaledToFit()
                        .onReceive(imageTimer) {_ in
                            withAnimation(){
                                self.indexImage = (self.indexImage + 1) % self.imageExemple.count
                            }
                        }
                }
                .frame(width: 450, height: 450, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.bottom, 190)
            }
            
            VStack{
                Image(uiImage: self.showArenaExemples ? imageExemple[indexImage] : UIImage(imageLiteralResourceName: "emptyArena"))
                    .resizable()
                    .scaledToFit()
                    .onReceive(imageTimer) {_ in
                        withAnimation(){
                            self.indexImage = (self.indexImage + 1) % self.imageExemple.count
                        }
                    }
            }
            .frame(width: 450, height: 450, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding(.bottom, 190)
            
            // text
            VStack{
                Spacer()
                if self.discoveredArena {
                    VStack{
                        Text("two players take turns to connect the DOTS.")
                            .font(.custom("Raleway-Regular", size: 24))
                            .foregroundColor(Color.whiteColor)
                            .frame(width: 550)
                            .multilineTextAlignment(.center)
                            .lineSpacing(6)
                        Spacer().frame(height:30)
                        Text("a player who completes the fourth side of a 1×1 BOX earns the BOX and takes another turn.")
                            .font(.custom("Raleway-Regular", size: 24))
                            .foregroundColor(Color.whiteColor)
                            .frame(width: 550)
                            .multilineTextAlignment(.center)
                            .lineSpacing(8)
                    }.opacity(self.secondTextAnimation ? 1 : 0)
                } else {
                    Text(!self.afterDiscoveredArena ? "so they came up with a solution: \n\n an arena for people to battle against each other to conquer the BOXES." : "the goal is to conquer as many\n BOXES as possible.")
                        .font(.custom(!self.afterDiscoveredArena ? "Raleway-Regular" : "Raleway-SemiBold", size: 24))
                        .foregroundColor(Color.whiteColor)
                        .frame(width: 550)
                        .multilineTextAlignment(.center)
                        .lineSpacing(8)
                        .opacity(self.textHidden ? 0 : 1)
                }
                Spacer()
                    .frame(height: 130, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
        .onChange(of: self.showArenaExemples) {_ in
            self.textHidden = true
            self.discoveredArena = true
            withAnimation(.easeOut(duration: 1.0)) {
                self.secondTextAnimation = true
            }
        }
        .onTapGesture {
            if !self.showArenaExemples {
                self.imageTimer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
                withAnimation(){
                    self.showArenaExemples = true
                }
            } else {
                if !self.afterDiscoveredArena {
                    self.discoveredArena = false
                    self.afterDiscoveredArena = true
                    withAnimation(){
                        self.textHidden = false
                    }
                } else {
                    self.imageTimer.upstream.connect().cancel()
                    // go to next page of onboarding
                    onboarding.page = 4
                }
            }
        }
    }
}


