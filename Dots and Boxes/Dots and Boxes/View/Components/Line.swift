//
//  Line.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 12/04/21.
//

import SwiftUI


public struct Line: View {
    //@ObservedObject var environment = GameEnvironment()
    
    enum lineType {
        case none, player1, player2
    }
    
    @State var colorLineEx = Color.darkColor //exemplo
    @State var colorLine: lineType = .none
    
    public init() {}
    
    public var body: some View {
        GeometryReader{ geometry in
            Rectangle()
                //.foregroundColor(colorLineEx)
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
