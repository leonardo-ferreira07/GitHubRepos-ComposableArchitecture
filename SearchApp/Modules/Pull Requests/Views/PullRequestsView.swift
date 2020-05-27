//
//  PullRequestsView.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 20/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct PullRequestsView: View {
    private let store: Store<PullRequestViewModel.PullRequestsState, PullRequestViewModel.PullRequestsAction>

    init(store: Store<PullRequestViewModel.PullRequestsState, PullRequestViewModel.PullRequestsAction>) {
      self.store = store
    }
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(alignment: .leading, spacing: 20) {
                Spacer()
                #if os(iOS) || os(macOS)
                    HStack(spacing: 10) {
                        Text("Repository:")
                            .font(.headline)
                        Text(viewStore.repository)
                            .font(.subheadline)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.leading, 20)
                #endif
                
                List {
                    if viewStore.pullRequests.isEmpty {
                        LoadingView(isLoading: viewStore.isLoading)
                    } else {
                        Section {
                            ForEach(viewStore.pullRequests, content: PullRequestViewRow.init(viewModel:))
                        }
                    }
                }
                
            }
            .navigationBarTitle("Pull Requests")
            .onAppear(perform: {
                viewStore.send(.fetchPR)
            })
        }
    }
}

//struct PullRequestsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PullRequestsView(viewModel: PullRequestViewModel(pullRequestsFetcher: PullRequestsService(), owner: "", repository: ""))
//    }
//}
