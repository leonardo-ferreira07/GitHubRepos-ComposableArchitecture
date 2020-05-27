//
//  RepositoriesView.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 18/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct RepositoriesView: View {
    
    private let store: Store<RepositoriesViewModel.RepositoriesSearchState, RepositoriesViewModel.RepositoriesSearchAction>
    private let pullRequestsBuilder: PullRequestsBuilder
    private let repositoriesNavigator: RepositoriesNavigator
    
    init(store: Store<RepositoriesViewModel.RepositoriesSearchState, RepositoriesViewModel.RepositoriesSearchAction>,
         repositoriesNavigator: RepositoriesNavigator) {
        self.store = store
        self.pullRequestsBuilder = .init()
        self.repositoriesNavigator = repositoriesNavigator
    }
    
    var body: some View {
        
        WithViewStore(store) { viewStore in
            self.myBody(viewStore)
        }
    }
    
    private var padding: CGFloat {
        var padding: CGFloat = 0
        #if targetEnvironment(macCatalyst)
            padding = 1
        #endif
        return padding
    }
}

private extension RepositoriesView {
    
    func myBody(_ store: ViewStore<RepositoriesViewModel.RepositoriesSearchState, RepositoriesViewModel.RepositoriesSearchAction>) -> some View {
        #if os(watchOS)
            return list(store)
        #else
            return NavigationView {
                list(store)
                .listStyle(GroupedListStyle())
                .navigationBarTitle("GitHub Search 👨🏻‍💻")
                .gesture(DragGesture().onChanged({ (_) in
                    self.dismissKeyboard()
                }))
                .padding(.top, padding)

            }
        #endif
    }
    
    func list(_ store: ViewStore<RepositoriesViewModel.RepositoriesSearchState, RepositoriesViewModel.RepositoriesSearchAction>) -> some View {
        List {
            SearchView(store: store)
            
            if store.repositories.isEmpty {
                LoadingView(isLoading: store.isLoading)
            } else {
                searchingForSection(store)
                repositoriesSection(store)
            }
        }
    }
    
    func repositoriesSection(_ store: ViewStore<RepositoriesViewModel.RepositoriesSearchState, RepositoriesViewModel.RepositoriesSearchAction>) -> some View {
        Section {
            ForEach(store.repositories) { (repo) in
                self.repositoriesNavigator.navigateToPullRequests(repo)
            }
        }
    }
    
    func searchingForSection(_ store: ViewStore<RepositoriesViewModel.RepositoriesSearchState, RepositoriesViewModel.RepositoriesSearchAction>) -> some View {
        Section {
            VStack(alignment: .leading) {
                Text("Searching for:")
                Text(store.searchQuery)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
    
}
