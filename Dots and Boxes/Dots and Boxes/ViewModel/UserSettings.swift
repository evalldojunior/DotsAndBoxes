//
//  UserSettings.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 16/04/21.
//

import SwiftUI

public class Onboarding: ObservableObject {
    public init() {}
    @Published public var page = 0
}

public class ViewManager: ObservableObject {
    
    @Published public var pages = 0
    @Published public var player01Name: String = "player 01"
    @Published public var player02Name: String = "player 02"
    @Published public var player01Color: Color = Color(UIColor.systemTeal)
    @Published public var player02Color: Color = Color(UIColor.systemYellow)
    @Published public var nSquare: Int = 6
}
