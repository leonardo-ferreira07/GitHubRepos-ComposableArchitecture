//
//  RepositoriesNavigator.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 21/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation
import SwiftUI

struct RepositoriesNavigator {
    // MARK: - Properties
    private let pullRequestsBuilder: PullRequestsBuilder
    
    // MARK: - Inits
    
    init(pullRequestsBuilder: PullRequestsBuilder) {
        self.pullRequestsBuilder = pullRequestsBuilder
    }
    
    func navigateToPullRequests(_ repo: RepositoryRowViewModel) -> NavigationLink<RepositoryRow, PullRequestsView> {
        let view = self.pullRequestsBuilder.makePullRequestsView(
                                                                pullRequestsFetcher: PullRequestsService(),
                                                                owner: repo.ownerName,
                                                                repository: repo.name)
        return NavigationLink(destination: view) {
            RepositoryRow.init(viewModel: repo)
        }
    }
}
