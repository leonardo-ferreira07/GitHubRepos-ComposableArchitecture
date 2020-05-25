//
//  RepositoryRowViewModel.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 18/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import SwiftUI
import Combine

struct RepositoryRowViewModel: Identifiable {
    private let repository: Repository
    
    init(item: Repository) {
        self.repository = item
    }
    
    // MARK: - Computed properties
    var id: String {
        "\(repository.id)"
    }
    
    var ownerName: String {
        repository.owner.login
    }
    
    var name: String {
        repository.name ?? "No name returned from GitHub API"
    }
    
    var description: String {
        repository.description ?? "No description returned from GitHub API"
    }
    
    var descriptionColor: Color {
        var uiColor: UIColor
        #if os(watchOS)
            uiColor = repository.description == nil ? UIColor.red : UIColor.lightGray
        #else
            uiColor = repository.description == nil ? UIColor.red : UIColor.darkText
        #endif
        
        return Color(uiColor)
    }
}

extension RepositoryRowViewModel: Hashable, Equatable {
    static func == (lhs: RepositoryRowViewModel, rhs: RepositoryRowViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
