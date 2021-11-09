//
//  Dots_and_BoxesApp.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 25/06/21.
//

import SwiftUI

var viewManager = ViewManager()
var views: some View = ViewManagerClass().environmentObject(viewManager)

@main
struct Dots_and_BoxesApp: App {
    
    
    var body: some Scene {
        WindowGroup {
            views
        }
    }
}
