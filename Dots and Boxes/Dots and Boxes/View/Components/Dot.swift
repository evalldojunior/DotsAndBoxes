//
//  Dot.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 12/04/21.
//
import SwiftUI

public struct Dot: View {
    
    public init() {}
    
    public var body: some View {
        Circle()
            .foregroundColor(Color.whiteColor)
            .frame(width: 13, height: 13)
            .shadow(radius: 3)
    }
}
