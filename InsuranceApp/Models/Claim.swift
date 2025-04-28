//
//  Claim.swift
//  InsuranceApp
//
//  Created by Ade Dwi Prayitno on 28/04/25.
//

import Foundation

struct Claim: Identifiable {
    let userId: Int
    let id : Int
    let title: String
    let body: String
    
    static let claimsDummy: [Claim] = [
        Claim(userId: 101, id: 1, title: "One", body: "One Desc"),
        Claim(userId: 111, id: 2, title: "Two", body: "Two Desc"),
        Claim(userId: 123, id: 3, title: "Three", body: "Three Desc"),
        Claim(userId: 125, id: 4, title: "Four", body: "Four Desc"),
    ]
}
