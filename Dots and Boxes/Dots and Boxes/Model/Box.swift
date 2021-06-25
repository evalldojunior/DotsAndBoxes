//
//  Box.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 12/04/21.
//

import Foundation
import SwiftUI

public class Box {
    var top: Bool?
    var right: Bool?
    var left: Bool?
    var bottom: Bool?
    var players: playerType?
    var complete: Bool?
    var colorBox: Color?
    
    enum playerType {
        case none, player1, player2
    }
    
    init(){
        top = false
        right = false
        left = false
        bottom = false
        complete = false
        colorBox = Color.darkGreyColor
    }
    
    public func checkCompleteBox(colorBox: Color) -> Bool{
        if !complete! {
            if top! && right! && left! && bottom! {
                complete = true
                withAnimation(){
                    self.colorBox = colorBox
                }
                return true
            }
        } else {
            return true
        }
        return false
    }
}
