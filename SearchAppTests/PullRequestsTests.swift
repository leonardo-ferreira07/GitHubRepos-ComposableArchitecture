//
//  PullRequestsTests.swift
//  SearchAppTests
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 29/05/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Combine
import ComposableArchitecture
import XCTest

@testable import SearchApp

class PullRequestsTests: XCTestCase {
    
    let scheduler = DispatchQueue.testScheduler
    let pullRequestsServiceMock = PullRequestsServiceMockSuccess()
    lazy var environment = PullRequestViewModel.PullRequestsEnvironment(
        pullRequestsService: pullRequestsServiceMock,
        mainQueue: AnyScheduler(self.scheduler)
    )
    lazy var reducer = PullRequestViewModel().pullRequestsReducer
    
    func testFetchSuccess() {
        let store = TestStore(
            initialState: PullRequestViewModel.PullRequestsState(pullRequests: [],
                                                                 owner: "testOwner",
                                                                 repository: "testRepo",
                                                                 isLoading: false),
            reducer: reducer,
            environment: self.environment
        )
        
        store.assert(
            .environment {
                $0.pullRequestsService = self.pullRequestsServiceMock
            },
            .send(.fetchPR) {
                $0.isLoading = true
                $0.owner = "testOwner"
                $0.repository = "testRepo"
            },
            .do { self.scheduler.advance(by: 0.3) },
            .receive(.pullRequestsResponse(.success(mockPullRequests))) {
                $0.pullRequests = mockPullRequests.map(PullRequestDetailViewModel.init)
                $0.isLoading = false
            }
        )
    }
    
    func testFetchFailure() {
        let store = TestStore(
            initialState: .init(),
            reducer: reducer,
            environment: self.environment
        )
        
        store.assert(
            .environment {
                $0.pullRequestsService = PullRequestsServiceMockFailure()
            },
            .send(.fetchPR) {
                $0.isLoading = true
                $0.owner = ""
                $0.repository = ""
            },
            .do { self.scheduler.advance(by: 0.3) },
            .receive(.pullRequestsResponse(.failure(.decoding(description: "error")))) {
                $0.isLoading = false
                $0.pullRequests = []
            }
        )
    }
    
}

private let mockPullRequests: [PullRequest] = [
    .init(title: "title 1",
          body: "body 1",
          date: "22-06-2020",
          user: RepositoryOwner(login: "login 1", avatar: "avatar 1")),
    .init(title: "title 2",
        body: "body 2",
        date: "22-06-2020",
        user: RepositoryOwner(login: "login 2", avatar: "avatar 2")),
    .init(title: "title 3",
        body: "body 3",
        date: "22-06-2020",
        user: RepositoryOwner(login: "login 3", avatar: "avatar 3"))
]

struct PullRequestsServiceMockSuccess: PullRequestsFetchable {
    func fetchPullRequests(withOwner owner: String, repository: String) -> Effect<[PullRequest], GenericError> {
        Effect(value: mockPullRequests)
    }
}

struct PullRequestsServiceMockFailure: PullRequestsFetchable {
    func fetchPullRequests(withOwner owner: String, repository: String) -> Effect<[PullRequest], GenericError> {
        Effect(error: .decoding(description: "error"))
    }
}

