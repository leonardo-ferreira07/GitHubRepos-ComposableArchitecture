//
//  RepositoriesService.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 18/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation
import Combine

protocol RepositoriesFetchable {
    func fetchRepositories(forText text: String) -> AnyPublisher<Repositories, GenericError>
}

struct RepositoriesService {
    private var requester: NetworkService
    
    init(requester: NetworkService = NetworkService()) {
        self.requester = requester
    }
    
}

// MARK: - Fetchable

extension RepositoriesService: RepositoriesFetchable {
    func fetchRepositories(forText text: String) -> AnyPublisher<Repositories, GenericError> {
        return requester.request(with: makeRepositoriesSearch(withText: text))
    }
}

// MARK: - API
private extension RepositoriesService {
    
    func makeRepositoriesSearch(withText text: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = GitHubAPI.scheme
        components.host = GitHubAPI.host
        components.path = GitHubAPI.searchPath + "/repositories"
        
        components.queryItems = [
            URLQueryItem(name: "q", value: text)
        ]
        
        return components
    }
}
