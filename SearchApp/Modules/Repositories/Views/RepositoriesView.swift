//
//  RepositoriesView.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 18/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import SwiftUI

struct RepositoriesView: View {
    @ObservedObject var viewModel: RepositoriesViewModel
    
    private let pullRequestsBuilder: PullRequestsBuilder
    private let repositoriesNavigator: RepositoriesNavigator
    
    init(viewModel: RepositoriesViewModel,
         repositoriesNavigator: RepositoriesNavigator) {
        self.viewModel = viewModel
        self.pullRequestsBuilder = .init()
        self.repositoriesNavigator = repositoriesNavigator
    }
    
    var body: some View {
        #if os(watchOS)
            return list
        #else
            return NavigationView {
                list
                .listStyle(GroupedListStyle())
                .navigationBarTitle("GitHub Search 👨🏻‍💻")
                .gesture(DragGesture().onChanged({ (_) in
                    self.dismissKeyboard()
                }))
                .padding(.top, padding)
                .onDisappear(perform: viewModel.onDisappear)
            }
        #endif
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
    
    var list: some View {
        List {
            SearchView(viewModel: viewModel)
            
            if viewModel.dataSource.isEmpty {
                LoadingView(viewModel: viewModel)
            } else {
                searchingForSection
                repositoriesSection
            }
        }
    }
    
    var repositoriesSection: some View {
        Section {
            ForEach(viewModel.dataSource) { (repo) in
                self.repositoriesNavigator.navigateToPullRequests(repo)
            }
        }
    }
    
    var searchingForSection: some View {
        Section {
            VStack(alignment: .leading) {
                Text("Searching for:")
                Text(viewModel.searchText)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
    
}
