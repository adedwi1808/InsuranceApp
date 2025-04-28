//
//  ClaimResponseModel.swift
//  InsuranceApp
//
//  Created by Ade Dwi Prayitno on 28/04/25.
//

import Foundation

struct ClaimResponseModel: Codable {
    let userID: Int?
    let id: Int?
    let title: String?
    let body: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

extension ClaimResponseModel {
    func mapToClaim() -> Claim {
        return Claim(
            userId: userID ?? 0,
            id: id ?? 0,
            title: title ?? "",
            body: body ?? ""
        )
    }
}
