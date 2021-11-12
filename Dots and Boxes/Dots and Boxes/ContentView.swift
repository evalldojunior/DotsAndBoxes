//
//  ContentView.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 25/06/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewManager: ViewManager
    
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
