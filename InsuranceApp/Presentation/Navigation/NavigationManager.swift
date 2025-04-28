//
//  NavigationManager.swift
//  InsuranceApp
//
//  Created by Ade Dwi Prayitno on 28/04/25.
//

import SwiftUI

class NavigationManager: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    
    func goToRoot() {
        guard !path.isEmpty else { return }
        path.removeLast(path.count)
    }
    
    func navigateTo(_ destination: Route) {
        path.append(destination)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
}

extension NavigationManager {
    @ViewBuilder
    func routesDestination(selectedRoutes: Route) -> some View {
        switch selectedRoutes {
        case .claimDetail(let data):
            ClaimDetailView(claimData: data)
        }
    }
}

enum Route: Hashable {
    case claimDetail(claimData: Claim)
}
