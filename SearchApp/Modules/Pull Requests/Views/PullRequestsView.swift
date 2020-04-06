//
//  PullRequestsView.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 20/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import SwiftUI

struct PullRequestsView: View {
    @ObservedObject var viewModel: PullRequestViewModel

    init(viewModel: PullRequestViewModel) {
      self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Spacer()
            #if os(iOS) || os(macOS)
                HStack(spacing: 10) {
                    Text("Repository:")
                        .font(.headline)
                    Text(viewModel.repository)
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.leading, 20)
            #endif
            
            List {
                if viewModel.dataSource.isEmpty {
                    LoadingView(viewModel: viewModel)
                } else {
                    Section {
                        ForEach(viewModel.dataSource, content: PullRequestView.init(viewModel:))
                    }
                }
            }
            
        }
        .navigationBarTitle("Pull Requests")
        .onAppear(perform: viewModel.onAppear)
        .onDisappear(perform: viewModel.onDisappear)
        
    }
}

struct PullRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        PullRequestsView(viewModel: PullRequestViewModel(pullRequestsFetcher: PullRequestsService(), owner: "", repository: ""))
    }
}
