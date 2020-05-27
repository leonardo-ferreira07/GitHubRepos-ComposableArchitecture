//
//  PullRequestsBuilder.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 20/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct PullRequestsBuilder {
    func makePullRequestsView(pullRequestsFetcher: PullRequestsService, owner: String, repository: String) -> PullRequestsView {
        let store = Store(
            initialState: PullRequestViewModel.PullRequestsState(pullRequests: [], owner: owner, repository: repository, isLoading: false),
        reducer: PullRequestViewModel().pullRequestsReducer.debug(),
        environment: PullRequestViewModel.PullRequestsEnvironment(
            pullRequestsService: pullRequestsFetcher,
            mainQueue: DispatchQueue.main.eraseToAnyScheduler())
        )
        return PullRequestsView(store: store)
    }
}
