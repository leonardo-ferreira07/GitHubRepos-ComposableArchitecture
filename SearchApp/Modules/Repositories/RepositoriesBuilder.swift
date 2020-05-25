//
//  RepositoriesBuilder.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 18/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct RepositoriesBuilder {
    func makeRepositoriesView(repositoriesFetcher: RepositoriesService) -> RepositoriesView {
        let viewModel = RepositoriesViewModel()
        let repoNavigator = RepositoriesNavigator(pullRequestsBuilder: PullRequestsBuilder())
        let store = Store(
        initialState: RepositoriesSearchState(),
        reducer: viewModel.repoSearchReducer.debug(),
        environment: RepositoriesSearchEnvironment(
          repositoryService: repositoriesFetcher,
          mainQueue: DispatchQueue.main.eraseToAnyScheduler())
        )
        return RepositoriesView(store: store, repositoriesNavigator: repoNavigator)
    }
    
}
