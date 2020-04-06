//
//  PullRequestsService.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 20/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation
import Combine

protocol PullRequestsFetchable {
    func fetchPullRequests(withOwner owner: String, repository: String) -> AnyPublisher<[PullRequest], GenericError>
}

struct PullRequestsService {
    private var requester: NetworkService
    
    init(requester: NetworkService = NetworkService()) {
        self.requester = requester
    }
    
}

// MARK: - Fetchable

extension PullRequestsService: PullRequestsFetchable {
    func fetchPullRequests(withOwner owner: String, repository: String) -> AnyPublisher<[PullRequest], GenericError> {
        return requester.request(with: makePullRequests(withOwner: owner, repository: repository))
    }
}

// MARK: - API
private extension PullRequestsService {
    
    func makePullRequests(withOwner owner: String, repository: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = GitHubAPI.scheme
        components.host = GitHubAPI.host
        components.path = GitHubAPI.reposPath + "/\(owner)/\(repository)/pulls"
        
        return components
    }
}

