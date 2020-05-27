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
    let store: ViewStore<RepositoriesViewModel.RepositoriesSearchState, RepositoriesViewModel.RepositoriesSearchAction>
    
    init(store: ViewStore<RepositoriesViewModel.RepositoriesSearchState, RepositoriesViewModel.RepositoriesSearchAction>) {
        self.store = store
    }
    
    var body: some View {
        HStack(alignment: .center) {
            #if os(watchOS)
                TextField("e.g. Swift", text: store.binding(
                    get: { $0.searchQuery }, send: RepositoriesViewModel.RepositoriesSearchAction.searchQueryChanged))
            #else
                TextField("e.g. Swift", text: store.binding(
                    get: { $0.searchQuery }, send: RepositoriesViewModel.RepositoriesSearchAction.searchQueryChanged))
                    .disableAutocorrection(true)
            #endif
        }
    }
}
