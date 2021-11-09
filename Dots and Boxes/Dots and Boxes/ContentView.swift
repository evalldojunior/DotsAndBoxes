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
    let player1Name = "testeeeeeeeee"
    let player2Name = "testeeeeeeeeeeeeeeeee"

    // Colors
    // select the color following the example below
    let player1Color = Color(UIColor.systemTeal)
    let player2Color = Color(UIColor.systemIndigo)
      
      
    // The arena is a square matrix of order n (n-square matrix)
    // this playgrounds accepts 3 <= n <= 9 for better results
    let n = 3
    
    var body: some View {
        GameView(player1Name: player1Name, player2Name: player2Name, player1Color: player1Color, player2Color: player2Color, nOrder: n)
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
