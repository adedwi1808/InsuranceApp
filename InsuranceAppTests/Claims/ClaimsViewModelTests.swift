//
//  ClaimsViewModelTests.swift
//  InsuranceAppTests
//
//  Created by Ade Dwi Prayitno on 29/04/25.
//

import XCTest
@testable import InsuranceApp

final class ClaimsViewModelTests: XCTestCase {
    var sut: ClaimsViewModel!

    override func setUp() {
        super.setUp()
        sut = ClaimsViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_getClaims_success() async throws {
        let mockData: [ClaimResponseModel] = [
            ClaimResponseModel(
                userID: 101,
                id: 1,
                title: "Claims Insurance",
                body: "Claim Description"
            ),
            ClaimResponseModel(
                userID: 111,
                id: 2,
                title: "Claims Insurance 2",
                body: "Claim Description 2"
            )
        ]
        
        let stub: StubClaimsService = StubClaimsService(result: .success(data: mockData))
        sut = ClaimsViewModel(services: ClaimsService(networker: stub))
        
        try await sut.getClaims()
        
        XCTAssertEqual(sut.claims.count, 2, "The get claims error")
    }
    
    func test_getClaims_middlewareError() async throws {
        let stub: StubClaimsService = StubClaimsService(result: .error(error: .middlewareError(code: 0, message: "Error Middleware - 123")))
        sut = ClaimsViewModel(services: ClaimsService(networker: stub))
        try await sut.getClaims()
        
        XCTAssertEqual(sut.isError, true)
        XCTAssertEqual(sut.errorMessages, "Error Middleware - 123")
    }
    
    func test_getClaims_internetError() async throws {
        let stub: StubClaimsService = StubClaimsService(result: .error(error: .internetError(message: "Upss, please check your network")))
        sut = ClaimsViewModel(services: ClaimsService(networker: stub))
        try await sut.getClaims()
        
        XCTAssertEqual(sut.isError, true)
        XCTAssertEqual(sut.errorMessages, "Upss, please check your network")
    }
    
    func test_getClaims_decodingError() async throws {
        let stub: StubClaimsService = StubClaimsService(result: .error(error: .decodingError(message: "Failed Decode")))
        sut = ClaimsViewModel(services: ClaimsService(networker: stub))
        try await sut.getClaims()
        
        XCTAssertEqual(sut.isError, true)
        XCTAssertEqual(sut.errorMessages, "Failed Decode")
    }
    
    func test_getClaims_unAuthorized() async throws {
        let stub: StubClaimsService = StubClaimsService(result: .error(error: .unAuthorized))
        sut = ClaimsViewModel(services: ClaimsService(networker: stub))
        try await sut.getClaims()
        
        XCTAssertEqual(sut.isError, true)
        XCTAssertEqual(sut.errorMessages, "unauthorized")
    }
    
    func test_closeAlert_afterErrorShowup() async throws {
        let stub: StubClaimsService = StubClaimsService(result: .error(error: .internetError(message: "Upss, please check your network")))
        sut = ClaimsViewModel(services: ClaimsService(networker: stub))
        try await sut.getClaims()
        
        XCTAssertEqual(sut.isError, true)
        XCTAssertEqual(sut.errorMessages, "Upss, please check your network")
        
        sut.closeAlert()
        
        XCTAssertEqual(sut.isError, false)
    }
    
    func test_closeAlert_evenNoErrorOccured() async throws {
        let mockData: [ClaimResponseModel] = [
            ClaimResponseModel(
                userID: 101,
                id: 1,
                title: "Claims Insurance",
                body: "Claim Description"
            ),
            ClaimResponseModel(
                userID: 111,
                id: 2,
                title: "Claims Insurance 2",
                body: "Claim Description 2"
            )
        ]
        
        let stub: StubClaimsService = StubClaimsService(result: .success(data: mockData))
        sut = ClaimsViewModel(services: ClaimsService(networker: stub))
        try await sut.getClaims()
        
        XCTAssertEqual(sut.isError, false)
        
        sut.closeAlert()
        
        XCTAssertEqual(sut.isError, false)
    }

    
    func test_filterClaims_whenNoData() async throws {
        let mockData: [ClaimResponseModel] = []
        
        let stub: StubClaimsService = StubClaimsService(result: .success(data: mockData))
        sut = ClaimsViewModel(services: ClaimsService(networker: stub))
        try await sut.getClaims()
        
        XCTAssertEqual(sut.isError, false)
        
        sut.searchText = "Claims"
        XCTAssertEqual(sut.filteredClaims.count, 0)
    }
    
    func test_filterClaims_whenDataExist() async throws {
        let mockData: [ClaimResponseModel] = [
            ClaimResponseModel(
                userID: 101,
                id: 1,
                title: "Claims Insurance",
                body: "Claim Description"
            ),
            ClaimResponseModel(
                userID: 111,
                id: 2,
                title: "Claims Insurance 2",
                body: "Claim Description 2"
            )
        ]
        
        let stub: StubClaimsService = StubClaimsService(result: .success(data: mockData))
        sut = ClaimsViewModel(services: ClaimsService(networker: stub))
        try await sut.getClaims()
        
        XCTAssertEqual(sut.isError, false)
        
        sut.searchText = "Claims Insurance 2"
        XCTAssertEqual(sut.filteredClaims.count, 1)
    }
    
    func test_filterClaims_whenDataExist_noMatchingData() async throws {
        let mockData: [ClaimResponseModel] = [
            ClaimResponseModel(
                userID: 101,
                id: 1,
                title: "Claims Insurance",
                body: "Claim Description"
            ),
            ClaimResponseModel(
                userID: 111,
                id: 2,
                title: "Claims Insurance 2",
                body: "Claim Description 2"
            )
        ]
        
        let stub: StubClaimsService = StubClaimsService(result: .success(data: mockData))
        sut = ClaimsViewModel(services: ClaimsService(networker: stub))
        try await sut.getClaims()
        
        XCTAssertEqual(sut.isError, false)
        
        sut.searchText = "Claims Insurance 75"
        XCTAssertEqual(sut.filteredClaims.count, 0)
    }
}

extension ClaimsViewModelTests {
    class StubClaimsService: NetworkerProtocol {
        var result: Result?
        init(result: Result) {
            self.result = result
        }
        
        func taskAsync<T>(type: T.Type, endPoint: NetworkFactory, isMultipart: Bool) async throws -> T where T: Decodable {
            switch result {
            case .success(let data):
                return data as! T
            case .error(let error):
                throw error
            case .none:
                return try JSONDecoder().decode(type.self, from: Data())
            }
        }
    }
}
