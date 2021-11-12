//
//  Views.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 08/11/21.
//

import Foundation
import SwiftUI

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
