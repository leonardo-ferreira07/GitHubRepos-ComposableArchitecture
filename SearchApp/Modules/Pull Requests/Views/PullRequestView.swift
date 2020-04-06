//
//  PullRequestView.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 20/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import SwiftUI

struct PullRequestView: View {
    private let viewModel: PullRequestDetailViewModel
    
    init(viewModel: PullRequestDetailViewModel) {
      self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                #if os(iOS) || os(macOS)
                    Text("Proposed by:")
                        .font(.headline)
                #endif
                Text(viewModel.id)
                    .font(.body)
            }
            Text(viewModel.title)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct PullRequestView_Previews: PreviewProvider {
    static var previews: some View {
        PullRequestView(viewModel: PullRequestDetailViewModel(item: PullRequest(title: "", body: "", date: "", user: RepositoryOwner(login: "", avatar: ""))))
    }
}
