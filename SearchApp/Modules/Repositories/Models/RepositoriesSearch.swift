//
//  RepositoriesSearch.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 18/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation

struct Repository: Decodable, Equatable {
    var id: Int
    let name: String?
    let description: String?
    let owner: RepositoryOwner
    
    // MARK: - Equatable
    static func == (lhs: Repository, rhs: Repository) -> Bool {
        lhs.id == rhs.id
    }
}

struct RepositoryOwner: Decodable {
    let login: String
    let avatar: String
    
    // MARK: - Coding Keys
    
    private enum CodingKeys: String, CodingKey {
        case login
        case avatar = "avatar_url"
    }
}

struct Repositories: Decodable, Equatable {
    let items: [Repository]
}
