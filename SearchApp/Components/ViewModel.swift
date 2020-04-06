//
//  ViewModel.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 20/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Combine

class ViewModel: ObservableObject {
    
    @Published private(set) var isLoading: Bool = false
    
    var disposables = Set<AnyCancellable>()
    
    func startLoading() {
        isLoading = true
    }
    
    func stopLoading() {
        isLoading = false
    }
    
    func onDisappear() {
        _ = disposables.map({ $0.cancel() })
    }
}
