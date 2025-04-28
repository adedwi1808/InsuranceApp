//
//  ContentView.swift
//  InsuranceApp
//
//  Created by Ade Dwi Prayitno on 28/04/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var navigationManager: NavigationManager = NavigationManager()
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            Text("Hello Ade!")
                .environmentObject(navigationManager)
                .navigationDestination(for: Route.self) {
                    navigationManager.routesDestination(selectedRoutes: $0)
                        .navigationBarBackButtonHidden()
                }
        }
    }
}

#Preview {
    ContentView()
}
