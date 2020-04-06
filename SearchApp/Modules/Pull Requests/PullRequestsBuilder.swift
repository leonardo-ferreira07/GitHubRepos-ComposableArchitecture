//
//  PullRequestsBuilder.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 20/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation

struct PullRequestsBuilder {
    func makePullRequestsView(pullRequestsFetcher: PullRequestsService, owner: String, repository: String) -> PullRequestsView {
        let viewModel = PullRequestViewModel(pullRequestsFetcher: pullRequestsFetcher, owner: owner, repository: repository)
        return PullRequestsView(viewModel: viewModel)
    }
}
