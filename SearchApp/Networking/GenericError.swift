//
//  GenericError.swift
//  SearchApp
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 18/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation

import Foundation

enum GenericError: Error {
    case decoding(description: String)
    case network(description: String)
}
