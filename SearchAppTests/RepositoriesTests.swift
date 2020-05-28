//
//  RepositoriesTests.swift
//  SearchAppTests
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 27/05/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Combine
import ComposableArchitecture
import XCTest

@testable import SearchApp

class RepositoriesTests: XCTestCase {
    
    let scheduler = DispatchQueue.testScheduler
    let repositoriesServiceMock = RepositoriesServiceMockSuccess()
    lazy var environment = RepositoriesViewModel.RepositoriesSearchEnvironment(
        repositoryService: repositoriesServiceMock,
        mainQueue: AnyScheduler(self.scheduler)
    )
    lazy var reducer = RepositoriesViewModel().repoSearchReducer
    
    func testSearchAndClearQuery() {
        let store = TestStore(
            initialState: .init(),
            reducer: reducer,
            environment: self.environment
        )
        
        store.assert(
            .environment {
                $0.repositoryService = self.repositoriesServiceMock
            },
            .send(.searchQueryChanged("S")) {
                $0.searchQuery = "S"
                $0.isLoading = true
            },
            .do { self.scheduler.advance(by: 0.3) },
            .receive(.repositoriesResponse(.success(mockRepositories))) {
                $0.repositories = mockRepositories.items.map(RepositoryRowViewModel.init)
                $0.isLoading = false
            },
            .send(.searchQueryChanged("")) {
                $0.repositories = []
                $0.searchQuery = ""
                $0.isLoading = false
            }
        )
    }
    
    func testSearchFailure() {
        let store = TestStore(
            initialState: .init(),
            reducer: reducer,
            environment: self.environment
        )
        
        store.assert(
            .environment {
                $0.repositoryService = RepositoriesServiceMockFailure()
            },
            .send(.searchQueryChanged("Sw")) {
                $0.searchQuery = "Sw"
                $0.isLoading = true
            },
            .do { self.scheduler.advance(by: 0.3) },
            .receive(.repositoriesResponse(.failure(.decoding(description: "error")))) {
                $0.isLoading = false
                $0.repositories = []
            }
        )
    }
    
}

private let mockRepositories: Repositories = Repositories(items: [
    .init(id: 1,
          name: "repo 1",
          description: "repo 1 description",
          owner: .init(login: "login 1", avatar: "avatar 1")),
    .init(id: 1,
          name: "repo 2",
          description: "repo 2 description",
          owner: .init(login: "login 2", avatar: "avatar 2")),
    .init(id: 1,
          name: "repo 3",
          description: "repo 3 description",
          owner: .init(login: "login 3", avatar: "avatar 3"))
])

struct RepositoriesServiceMockSuccess: RepositoriesFetchable {
    func fetchRepositories(forText text: String) -> Effect<Repositories, GenericError> {
        Effect(value: mockRepositories)
    }
}

struct RepositoriesServiceMockFailure: RepositoriesFetchable {
    func fetchRepositories(forText text: String) -> Effect<Repositories, GenericError> {
        Effect(error: .decoding(description: "error"))
    }
}

