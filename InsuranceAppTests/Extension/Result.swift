//
//  Result.swift
//  InsuranceAppTests
//
//  Created by Ade Dwi Prayitno on 29/04/25.
//

import Foundation
@testable import InsuranceApp

enum Result {
    case success(data: Decodable)
    case error(error: NetworkError)
}

