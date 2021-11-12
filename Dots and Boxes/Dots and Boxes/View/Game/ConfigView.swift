//
//  ConfigView.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 08/11/21.
//

import SwiftUI

struct ConfigView: View {
    @EnvironmentObject var viewManager: ViewManager
    
    @State var showColors = false
    var sizes = ["3x3 (9 squares)", "4x4 (16 squares)", "5x5 (25 squares)", "6x6 (36 squares)","7x7 (49 squares)", "8x8 (64 squares)", "9x9 (81 squares)"]
    @State var selectedSize = "6x6 (36 squares)"
    var boxSize = CGFloat(((UIScreen.main.bounds.width-200)/2)-96)
    @State var nSquare: Int = 6
    @State var updateArena: Bool = true
    @State var startGame: Bool = false
    @State var offset = 115
    
    var body: some View {
        VStack(spacing: 0) {
            
            if !startGame {
                Image(uiImage: UIImage(imageLiteralResourceName: "logoInvert"))
                    .resizable()
                    .frame(width: 210, height: 210, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .onTapGesture {self.endTextEditing()}
            
                Spacer()
                ZStack(alignment: .bottomLeading) {
                    HStack(alignment: .top, spacing: 0) {
                        VStack(alignment: .leading){
                            Text("arena size")
                                .font(.custom("Raleway", size: 20))
                                .foregroundColor(Color.whiteColor)
                                .multilineTextAlignment(.leading)
                            Picker("choose a size", selection: $selectedSize) {
                                ForEach(sizes, id: \.self) {
                                    Text($0)
                                }
                            }
                            .font(.custom("Raleway-Regular", size: 30))
                            .frame(width: ((UIScreen.main.bounds.width-200)/2)-96, alignment: .leading)
                            .accentColor(Color.whiteColor)
                            .foregroundColor(Color.whiteColor)
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                            .background(Color.lightGreyColor)
                            .cornerRadius(6)
                            
                        }
                        .padding(32)
                        Spacer()
                        
                        if updateArena {
                            VStack(spacing: 0){
                                ForEach(0..<viewManager.nSquare+1) { indexX in
                                    HStack(spacing: 0){
                                        ForEach(0..<viewManager.nSquare+1) { indexY in
                                            Circle()
                                                .foregroundColor(Color.whiteColor)
                                                .frame(width: 8, height: 8)
                                                .shadow(radius: 3)
                                            
                                            if (indexY < viewManager.nSquare) {
                                                Spacer().frame(width: (boxSize/CGFloat(viewManager.nSquare)))
                                            }
                                        }
                                    }
                                    if (indexX < viewManager.nSquare) {
                                        Spacer().frame(height: (boxSize/CGFloat(viewManager.nSquare)))
                                    }
                                }
                            }
                            .padding([.vertical, .trailing],32)
                        }
                        
                    }
                    
                    
                }
                .frame(width: (UIScreen.main.bounds.width-200+32), alignment: .leading)
                .background(Color.darkGreyColor)
                .cornerRadius(11)
                .shadow(color: Color.black.opacity(0.2),radius: 20)
                .onTapGesture {self.endTextEditing()}
                
                Spacer().frame(height: 32)
                
                HStack(spacing: 32) {
                    // player 01
                    ZStack(alignment: .bottomLeading){
                        VStack(alignment: .leading){
                            Text("player name")
                                .font(.custom("Raleway", size: 20))
                                .foregroundColor(Color.whiteColor)
                                .multilineTextAlignment(.leading)
                            
                            TextField("player 01", text: $viewManager.player01Name)
                                .font(.custom("Raleway-Regular", size: 18))
                                .foregroundColor(Color.whiteColor)
                                .padding()
                                .background(Color.lightGreyColor)
                                .cornerRadius(6)
                                .onTapGesture {
                                    if self.viewManager.player01Name == "player 01" {
                                        self.viewManager.player01Name = ""
                                    }
                                }
                            
                            Spacer().frame(height:22)
                            
                            Text("player color")
                                .font(.custom("Raleway", size: 20))
                                .foregroundColor(Color.whiteColor)
                                .multilineTextAlignment(.leading)
                            
                            
                            ColorPicker("choose a color", selection: $viewManager.player01Color, supportsOpacity: false)
                                .frame(maxWidth: .infinity)
                                .font(.custom("Raleway-Regular", size: 18))
                                .foregroundColor(Color.whiteColor)
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .background(Color.lightGreyColor)
                                .cornerRadius(6)
                        }
                        .padding(32)
                        
                    }
                    .frame(width: (UIScreen.main.bounds.width-200)/2)
                    .background(Color.darkGreyColor.onTapGesture {self.endTextEditing()})
                    .cornerRadius(11)
                    .overlay(
                        RoundedRectangle(cornerRadius: 11)
                            .stroke(viewManager.player01Color, lineWidth: 1.5)
                    )
                    .shadow(color: Color.black.opacity(0.2),radius: 20)
                    
                    //player 02
                    ZStack(alignment: .bottomLeading){
                        VStack(alignment: .leading){
                            Text("player name")
                                .font(.custom("Raleway", size: 20))
                                .foregroundColor(Color.whiteColor)
                                .multilineTextAlignment(.leading)
                            
                            TextField("player 02", text: $viewManager.player02Name)
                                .font(.custom("Raleway-Regular", size: 18))
                                .foregroundColor(Color.whiteColor)
                                .padding()
                                .background(Color.lightGreyColor)
                                .cornerRadius(6)
                                .onTapGesture {
                                    if self.viewManager.player02Name == "player 02" {
                                        self.viewManager.player02Name = ""
                                    }
                                }
                            
                            Spacer().frame(height:22)
                            
                            Text("player color")
                                .font(.custom("Raleway", size: 20))
                                .foregroundColor(Color.whiteColor)
                                .multilineTextAlignment(.leading)
                            
                            
                            ColorPicker("choose a color", selection: $viewManager.player02Color, supportsOpacity: false)
                            .frame(maxWidth: .infinity)
                            .font(.custom("Raleway-Regular", size: 18))
                            .foregroundColor(Color.whiteColor)
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(Color.lightGreyColor)
                            .cornerRadius(6)
                        }
                        .padding(32)
                        
                    }
                    .frame(width: (UIScreen.main.bounds.width-200)/2)
                    .background(Color.darkGreyColor.onTapGesture {self.endTextEditing()})
                    .cornerRadius(11)
                    .overlay(
                        RoundedRectangle(cornerRadius: 11)
                            .stroke(viewManager.player02Color, lineWidth: 1.5)
                    )
                    .shadow(color: Color.black.opacity(0.2),radius: 20)
                }
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            AudioPlayer.shared.play(name: "tapLine", volume: 0.2, delay: 0.0)
                            withAnimation(.easeInOut(duration: 0.75)) {
                                startGame = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                viewManager.pages = 1
                                if viewManager.player01Name == "" {
                                    viewManager.player01Name = "player 01"
                                }
                                if viewManager.player02Name == "" {
                                    viewManager.player02Name = "player 02"
                                }
                            }
                            
                        }, label: {
                            HStack {
                                Spacer()
                                Text("start game")
                                    .font(.custom("Bebas Neue", size: 24))
                                    .foregroundColor(Color.whiteColor)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 2)
                                Spacer()
                            }
                            
                        }).frame(width:200 , height: 50)
                        .clipped()
                        .background(Color.lightGreyColor)
                        .cornerRadius(50)
                        .shadow(radius: 6)
                        Spacer()
                    }
                    Spacer().frame(height:80)
                }
            } else {
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
                .opacity(startGame ? 1 : 0)
            }
            
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color.darkColor.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).onTapGesture {self.endTextEditing()})
        .padding(100)
//        .gesture(DragGesture().onChanged{_ in self.endTextEditing()})
//        .onTapGesture {self.endTextEditing()}
        .onChange(of: selectedSize) { _ in
            withAnimation {
                updateArena = false
            }
            let selectedIndex = selectedSize.index(selectedSize.startIndex, offsetBy: 0)
            let charVal = selectedSize[selectedIndex]
            if let intValue = charVal.wholeNumberValue {
                viewManager.nSquare = intValue
            } else {
                print("Not an integer")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                withAnimation {
                    updateArena = true
                }
            }
        }
        .onAppear {
            self.selectedSize = "\(viewManager.nSquare)x\(viewManager.nSquare) (\(viewManager.nSquare*viewManager.nSquare) squares)"
        }
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (3rd generation)"))

//        ConfigView()
//            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (5th generation)"))
//
//        ConfigView()
//            .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
//
//        ConfigView()
//            .previewDevice(PreviewDevice(rawValue: "iPad Pro (9.7-inch)"))
//
//        ConfigView()
//            .previewDevice(PreviewDevice(rawValue: "iPad Mini (6th generation)"))
//
//        ConfigView()
//            .previewDevice(PreviewDevice(rawValue: "iPad (9th generation)"))
    }
}
