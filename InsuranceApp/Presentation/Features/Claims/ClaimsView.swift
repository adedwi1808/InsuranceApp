//
//  ClaimsView.swift
//  InsuranceApp
//
//  Created by Ade Dwi Prayitno on 28/04/25.
//

import SwiftUI

struct ClaimsView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @StateObject var viewModel: ClaimsViewModel = ClaimsViewModel()
    
    var body: some View {
        VStack {
            List(viewModel.claims) { claim in
                ClaimElementView(data: claim) {
                    navigationManager.navigateTo(.claimDetail(claimData: claim))
                }
            }
            .listStyle(.plain)
            .searchable(text: $viewModel.searchText)
        }
        .navigationTitle("Claims")
        .onAppear {
            Task {
                try await viewModel.getClaims()
            }
        }
    }
}

#Preview {
    NavigationStack {
        ClaimsView()
    }
}
