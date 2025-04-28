//
//  ClaimDetailView.swift
//  InsuranceApp
//
//  Created by Ade Dwi Prayitno on 28/04/25.
//

import SwiftUI

struct ClaimDetailView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    var claimData: Claim
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(claimData.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Claimant ID: \(claimData.userId)")
                        .font(.caption)
                    
                    Text(claimData.body)
                        .font(.body)
                        .lineLimit(nil)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            
            Button(action: {
                navigationManager.pop()
            }) {
                VStack {
                    Text("Process")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(8)
                .shadow(radius:4)
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 16)
        .navigationTitle("Claim Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ClaimDetailView(claimData: Claim.claimsDummy.first!)
    }
}
