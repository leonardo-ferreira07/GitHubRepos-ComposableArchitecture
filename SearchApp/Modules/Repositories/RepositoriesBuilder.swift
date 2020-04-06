//
//  RepositoriesBuilder.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 18/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import SwiftUI

struct RepositoriesBuilder {
    func makeRepositoriesView(repositoriesFetcher: RepositoriesService) -> RepositoriesView {
        let viewModel = RepositoriesViewModel(repositoriesFetcher: repositoriesFetcher)
        let repoNavigator = RepositoriesNavigator(pullRequestsBuilder: PullRequestsBuilder())
        return RepositoriesView(viewModel: viewModel, repositoriesNavigator: repoNavigator)
    }
    
}
