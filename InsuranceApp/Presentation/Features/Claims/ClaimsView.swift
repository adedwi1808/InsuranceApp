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
        ZStack {
            VStack {
                List(viewModel.filteredClaims) { claim in
                    ClaimElementView(data: claim) {
                        navigationManager.navigateTo(.claimDetail(claimData: claim))
                    }
                }
                .listStyle(.plain)
                .searchable(text: $viewModel.searchText)
            }
            
            if viewModel.isLoading {
                ProgressView()
                    .tint(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black.opacity(0.45))
            }
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
