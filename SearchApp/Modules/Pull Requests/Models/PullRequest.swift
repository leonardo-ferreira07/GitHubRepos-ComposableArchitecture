//
//  PullRequest.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 20/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation

struct PullRequest: Decodable, Equatable {
    let title: String
    let body: String
    let date: String
    let user: RepositoryOwner
    
    // MARK: - Coding Keys
    
    private enum CodingKeys: String, CodingKey {
        case title
        case body
        case date = "created_at"
        case user
    }
    
    static func == (lhs: PullRequest, rhs: PullRequest) -> Bool {
        lhs.title == lhs.title
    }
}
