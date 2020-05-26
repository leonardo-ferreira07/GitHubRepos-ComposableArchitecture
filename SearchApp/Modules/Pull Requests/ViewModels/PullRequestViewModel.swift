//
//  PullRequestViewModel.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 20/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation
import Combine


import ComposableArchitecture

struct PullRequestsState: Equatable {
    var pullRequests: [PullRequestDetailViewModel] = []
    var owner: String = ""
    var repository: String = ""
    var isLoading: Bool = false
}

enum PullRequestsAction: Equatable {
    case pullRequestsResponse(Result<[PullRequest], GenericError>)
    case fetchPR
}

struct PullRequestsEnvironment {
    var pullRequestsService: PullRequestsService
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

class PullRequestViewModel: NSObject {
    
    // MARK: - Pull requests reducer

    let pullRequestsReducer = Reducer<PullRequestsState, PullRequestsAction, PullRequestsEnvironment> {
        state, action, environment in
        switch action {
        case .pullRequestsResponse(.failure):
            state.pullRequests = []
            state.isLoading = false
            return .none
            
        case let .pullRequestsResponse(.success(response)):
            state.pullRequests = response.map(PullRequestDetailViewModel.init)
            state.isLoading = false
            return .none
            
        case .fetchPR:
            struct PullRequestId: Hashable {}
            
            state.isLoading = true
            return environment.pullRequestsService
                .fetchPullRequests(withOwner: state.owner, repository: state.repository)
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .cancellable(id: PullRequestId(), cancelInFlight: true)
                .map(PullRequestsAction.pullRequestsResponse)
        }

    }
    
}
