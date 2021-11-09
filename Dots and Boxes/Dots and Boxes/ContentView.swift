//
//  ContentView.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 25/06/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewManager: ViewManager
    
    /// user inputs
    // Names
    var player1Name = "player 01"
    var player2Name = "player 02"

    // Colors
    // select the color following the example below
    var player1Color = Color(UIColor.systemTeal)
    var player2Color = Color(UIColor.systemIndigo)
      
      
    // The arena is a square matrix of order n (n-square matrix)
    // this playgrounds accepts 3 <= n <= 9 for better results
    var n = 6
    
    var body: some View {
        GameView(player1Name: viewManager.player01Name, player2Name: viewManager.player02Name, player1Color: viewManager.player01Color, player2Color: viewManager.player02Color, nOrder: viewManager.nSquare)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (3rd generation)"))
//
//        ContentView()
//            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (5th generation)"))
//
//        ContentView()
//            .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
//
//        ContentView()
//            .previewDevice(PreviewDevice(rawValue: "iPad Pro (9.7-inch)"))
//
//        ContentView()
//            .previewDevice(PreviewDevice(rawValue: "iPad Mini (6th generation)"))
//
//        ContentView()
//            .previewDevice(PreviewDevice(rawValue: "iPad (9th generation)"))
    }
}
