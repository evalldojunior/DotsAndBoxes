//
//  BoxView.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 12/04/21.
//
import Foundation
import SwiftUI

public struct BoxView: View {
    @ObservedObject var environment: GameEnvironment

    @State var colorTop = Color.whiteColor.opacity(0.01)
    @State var colorBottom = Color.whiteColor.opacity(0.01)
    @State var colorLeft = Color.whiteColor.opacity(0.01)
    @State var colorRight = Color.whiteColor.opacity(0.01)
    
    var indexX: Int
    var indexY: Int
    var box: Box
    
    //public init() {}
    
    func tapped(line: chosenLineType) {
        environment.startCountDown()
        if line == .top {
            if !box.top! {
                box.top = true
                withAnimation(){
                    colorTop = environment.colorTurn!
                    
                }
                environment.updateBoxes(indexX: indexX, indexY: indexY, lineBox: line)
                self.environment.objectWillChange.send()
            }
        } else if line == .bottom {
            if !box.bottom! {
                box.bottom = true
                withAnimation(){
                    colorBottom = environment.colorTurn!
                }
                environment.updateBoxes(indexX: indexX, indexY: indexY, lineBox: line)
                self.environment.objectWillChange.send()
            }
        } else if line == .left {
            if !box.left! {
                box.left = true
                withAnimation(){
                    colorLeft = environment.colorTurn!
                }
                environment.updateBoxes(indexX: indexX, indexY: indexY, lineBox: line)
                self.environment.objectWillChange.send()
            }
        } else {
            if !box.right! {
                box.right = true
                withAnimation(){
                    colorRight = environment.colorTurn!
                }
                environment.updateBoxes(indexX: indexX, indexY: indexY, lineBox: line)
                self.environment.objectWillChange.send()
            }
        }
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack{
                Rectangle()
                    .foregroundColor(box.colorBox)
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

