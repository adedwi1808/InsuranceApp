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
                    
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Claims")
    }
}

#Preview {
    NavigationStack {
        ClaimsView()
    }
}
