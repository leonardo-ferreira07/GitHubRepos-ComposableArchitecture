//
//  SearchView.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 04/07/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject private var viewModel: RepositoriesViewModel
    
    init(viewModel: RepositoriesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(alignment: .center) {
            #if os(watchOS)
                TextField("e.g. Swift", text: $viewModel.searchText)
            #else
                TextField("e.g. Swift", text: $viewModel.searchText)
                    .disableAutocorrection(true)
            #endif
        }
    }
}

#if DEBUG
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: RepositoriesViewModel(repositoriesFetcher: RepositoriesService()))
    }
}
#endif
