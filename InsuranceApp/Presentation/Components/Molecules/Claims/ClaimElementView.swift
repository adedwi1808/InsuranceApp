//
//  ClaimElementView.swift
//  InsuranceApp
//
//  Created by Ade Dwi Prayitno on 28/04/25.
//

import SwiftUI

struct ClaimElementView: View {
    var data: Claim
    var onClick: () -> Void
    var body: some View {
        Button(action: onClick) {
            VStack(alignment: .leading, spacing: 8) {
                Text(data.title)
                    .font(.system(size: 14, weight: .bold))
                
                Text("Claimant ID: \(data.userId)")
                    .font(.system(size: 13, weight: .regular))
                
                Text(data.body)
                    .font(.system(size: 13, weight: .regular))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .foregroundStyle(.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
        .padding(.vertical, 12)
    }
}

#Preview {
    ClaimElementView(data: Claim.claimsDummy.first!, onClick: {})
}
