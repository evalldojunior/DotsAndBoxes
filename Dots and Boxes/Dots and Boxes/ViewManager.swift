//
//  ViewManager.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 09/11/21.
//

import SwiftUI

public struct ViewManagerClass: View {
    @EnvironmentObject var viewManager: ViewManager

    public init() {}
    
    public var body: some View {
        Group {
            if viewManager.pages == 0 {
                ConfigView().environmentObject(viewManager)
            } else if viewManager.pages == 1 {
                ContentView().environmentObject(viewManager)
            }
        }
    }
}
