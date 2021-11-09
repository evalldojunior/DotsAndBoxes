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
    public init() {}
    @Published public var pages = 0
}
