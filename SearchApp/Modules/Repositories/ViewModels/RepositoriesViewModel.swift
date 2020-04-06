//
//  RepositoriesViewModel.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 18/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation
import Combine

class RepositoriesViewModel: ViewModel {
    
    @Published var searchText: String = ""
    @Published private(set) var dataSource: [RepositoryRowViewModel] = []
    
    private let repositoriesFetcher: RepositoriesService
    
    init(repositoriesFetcher: RepositoriesService, scheduler: DispatchQueue = DispatchQueue(label: "RepositoriesViewModel")) {
        self.repositoriesFetcher = repositoriesFetcher
        super.init()
        
        $searchText
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .sink(receiveValue: fetchRepositories(forsearchText:))
            .store(in: &disposables)
    }
    
    private func fetchRepositories(forsearchText searchText: String) {
        DispatchQueue.main.async { [weak self] in self?.startLoading() }
        
        repositoriesFetcher.fetchRepositories(forText: searchText)
        .map { response in
            response.items.map(RepositoryRowViewModel.init)
        }
        .map(Array.removeDuplicates)
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure( let error):
                print("## \(error)")
                self.stopLoading()
                self.dataSource = []
            case .finished:
                break
            }
        },
        receiveValue: { [weak self] repos in
            guard let self = self else { return }
            self.stopLoading()
            self.dataSource = repos
        })
        .store(in: &disposables)
    }
    
}
