//
//  AppTeamTechnicalApp.swift
//  AppTeamTechnical
//
//  Created by Vishvak Ravi on 2/4/24.
//

import SwiftData
import SwiftUI

@main
struct AppTeamTechnicalApp: App {
    var body: some Scene {
        WindowGroup {
            SearchView(viewModel: SearchView.ViewModel())
        }
        .modelContainer(for: ProductModel.self)
    }
}
