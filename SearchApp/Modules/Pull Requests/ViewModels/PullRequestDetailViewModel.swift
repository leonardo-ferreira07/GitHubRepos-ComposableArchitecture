//
//  PullRequestDetailViewModel.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 20/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import SwiftUI
import Combine

struct PullRequestDetailViewModel: Identifiable {
    private let pullRequest: PullRequest
    
    init(item: PullRequest) {
        self.pullRequest = item
    }
    
    // MARK: - Computed properties
    var id: String {
        "\(pullRequest.user.login)"
    }
    
    var title: String {
        pullRequest.title
    }
}

extension PullRequestDetailViewModel: Hashable {
    static func == (lhs: PullRequestDetailViewModel, rhs: PullRequestDetailViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

