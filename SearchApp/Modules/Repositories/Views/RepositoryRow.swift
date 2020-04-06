//
//  RepoRow.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 04/07/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import SwiftUI

struct RepositoryRow: View {
    private let viewModel: RepositoryRowViewModel
    
    init(viewModel: RepositoryRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(viewModel.name)
                .font(.headline)
                .fixedSize(horizontal: false, vertical: true)
            
            HStack(spacing: 5) {
                Text("Owner:")
                    .font(.subheadline)
                Text(viewModel.ownerName)
                    .font(.subheadline)
            }
            
            Text(viewModel.description)
                .font(.body)
                .foregroundColor(viewModel.descriptionColor)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
#if DEBUG
struct RepoRow_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryRow(viewModel: RepositoryRowViewModel(item: Repository(id: 1, name: "test", description: "test description", owner: RepositoryOwner(login: "login", avatar: "avatar.url.com"))))
    }
}
#endif
