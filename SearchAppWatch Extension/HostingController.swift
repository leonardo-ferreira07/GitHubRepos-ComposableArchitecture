//
//  HostingController.swift
//  SearchAppWatch Extension
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 24/03/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<RepositoriesView> {
    override var body: RepositoriesView {
        RepositoriesBuilder().makeRepositoriesView(repositoriesFetcher: RepositoriesService())
    }
}
