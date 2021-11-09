//
//  Dots_and_BoxesApp.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 25/06/21.
//

import SwiftUI

//var viewManagerRoot = ViewManager()
//var views: some View = ViewManagerClass().environmentObject(viewManagerRoot)

@main
struct Dots_and_BoxesApp: App {
    @StateObject private var viewManagerRoot = ViewManager()
    
    var body: some Scene {
        WindowGroup {
            
            ViewManagerClass().environmentObject(viewManagerRoot)
        }
    }
}
