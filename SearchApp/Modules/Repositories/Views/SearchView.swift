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
            TextField("e.g. Swift", text: $viewModel.searchText)
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
