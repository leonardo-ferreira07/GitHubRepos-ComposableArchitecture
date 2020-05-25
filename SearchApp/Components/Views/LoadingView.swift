//
//  LoadingView.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 20/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    private var isLoading: Bool = false
    
    init(isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    var body: some View {
        emptySection
    }
    
    var emptySection: some View {
        Section {
            if isLoading {
                Text("Loading some things for you... 🤔")
                    .foregroundColor(.gray)
            } else {
                Text("No things found, try again later. 🤷🏻‍♂")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: true)
    }
}
