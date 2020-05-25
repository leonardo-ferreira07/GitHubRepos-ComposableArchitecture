//
//  SearchView.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 04/07/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct SearchView: View {
    let store: ViewStore<RepositoriesSearchState, RepositoriesSearchAction>
    
    init(store: ViewStore<RepositoriesSearchState, RepositoriesSearchAction>) {
        self.store = store
    }
    
    var body: some View {
        HStack(alignment: .center) {
            #if os(watchOS)
                TextField("e.g. Swift", text: store.binding(
                get: { $0.searchQuery }, send: RepositoriesSearchAction.searchQueryChanged))
            #else
                TextField("e.g. Swift", text: store.binding(
                get: { $0.searchQuery }, send: RepositoriesSearchAction.searchQueryChanged))
                    .disableAutocorrection(true)
            #endif
        }
    }
}
