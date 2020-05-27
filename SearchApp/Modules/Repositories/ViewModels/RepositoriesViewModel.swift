//
//  RepositoriesViewModel.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 18/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation
import Combine
import ComposableArchitecture

class RepositoriesViewModel: NSObject {
    
    struct RepositoriesSearchState: Equatable {
        var repositories: [RepositoryRowViewModel] = []
        var searchQuery = ""
        var isLoading: Bool = false
    }

    enum RepositoriesSearchAction: Equatable {
        case repositoriesResponse(Result<Repositories, GenericError>)
        case searchQueryChanged(String)
    }

    struct RepositoriesSearchEnvironment {
        var repositoryService: RepositoriesService
        var mainQueue: AnySchedulerOf<DispatchQueue>
    }
    
    // MARK: - Search feature reducer

    let repoSearchReducer = Reducer<RepositoriesSearchState, RepositoriesSearchAction, RepositoriesSearchEnvironment> {
        state, action, environment in
        switch action {
        case .repositoriesResponse(.failure):
            state.repositories = []
            state.isLoading = false
            return .none
            
        case let .repositoriesResponse(.success(response)):
            state.repositories = response.items.map(RepositoryRowViewModel.init)
            state.isLoading = false
            return .none
            
        case let .searchQueryChanged(query):
            struct SearchRepositoryId: Hashable {}
            
            state.searchQuery = query
            
            guard !query.isEmpty else {
                state.repositories = []
                state.isLoading = false
                return .cancel(id: SearchRepositoryId())
            }
            
            state.isLoading = true
            return environment.repositoryService
                .fetchRepositories(forText: query)
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .debounce(id: SearchRepositoryId(), for: 0.3, scheduler: environment.mainQueue)
                .map(RepositoriesSearchAction.repositoriesResponse)
        }

    }
    
}
