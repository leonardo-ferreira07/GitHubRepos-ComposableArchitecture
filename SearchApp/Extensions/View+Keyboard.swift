//
//  View+Keyboard.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 18/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import SwiftUI

extension View {
    func dismissKeyboard() {
        #if !targetEnvironment(macCatalyst) && !os(watchOS)
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        #endif
    }
}
