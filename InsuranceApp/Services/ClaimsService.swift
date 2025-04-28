//
//  ClaimsService.swift
//  InsuranceApp
//
//  Created by Ade Dwi Prayitno on 28/04/25.
//

import Foundation

protocol ClaimsServiceProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    func getClaims(endpoint: NetworkFactory) async throws -> [ClaimResponseModel]
}

final class ClaimsService: ClaimsServiceProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func getClaims(endpoint: NetworkFactory) async throws -> [ClaimResponseModel] {
        try await networker.taskAsync(type: [ClaimResponseModel].self, endPoint: endpoint, isMultipart: false)
    }
}
