//
//  ClaimsViewModel.swift
//  InsuranceApp
//
//  Created by Ade Dwi Prayitno on 28/04/25.
//

import Foundation

class ClaimsViewModel: ObservableObject {
    @Published var claims: [Claim] = []
    @Published var searchText: String = ""
    
    var services: ClaimsServiceProtocol
    
    init(services: ClaimsServiceProtocol = ClaimsService()) {
        self.services = services
    }
    
    @MainActor
    func getClaims() async throws {
        do {
            let response = try await services.getClaims(endpoint: .posts)
            mapClaimResponses(response: response)
        } catch let error as NetworkError {
            print(error)
        }
    }
    
    private func mapClaimResponses(response: [ClaimResponseModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            claims = response.map { responseElement in
                responseElement.mapToClaim()
            }
        }
    }
}
