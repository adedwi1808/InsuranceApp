//
//  ClaimsViewModel.swift
//  InsuranceApp
//
//  Created by Ade Dwi Prayitno on 28/04/25.
//

import Foundation

class ClaimsViewModel: ObservableObject {
    @Published var claims: [Claim] = []
    @Published var searchText: String = "" {
        didSet {
            filterClaims()
        }
    }
    @Published var filteredClaims: [Claim] = []
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessages: String = ""
    
    var services: ClaimsServiceProtocol
    
    init(services: ClaimsServiceProtocol = ClaimsService()) {
        self.services = services
    }
    
    @MainActor
    func getClaims() async throws {
        isLoading = true
        isError = false
        do {
            let response = try await services.getClaims(endpoint: .posts)
            mapClaimResponses(response: response)
            isLoading = false
        } catch let error as NetworkError {
            errorMessages = error.localizedDescription
            isError = true
            isLoading = false
        }
    }
    
    func closeAlert() {
        isError = false
    }
    
    private func mapClaimResponses(response: [ClaimResponseModel]) {
        claims = response.map { responseElement in
            responseElement.mapToClaim()
        }
        filterClaims()
    }
    
    private func filterClaims() {
        if searchText.isEmpty {
            filteredClaims = claims
        } else {
            filteredClaims = claims.filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.body.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
