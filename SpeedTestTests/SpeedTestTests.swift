//
//  SpeedTestTests.swift
//  SpeedTestTests
//
//  Created by Иван Карплюк on 24.04.2024.
//

import XCTest
@testable import SpeedTest

final class DICprotocolTests: XCTestCase {
    
    struct TestService {
        let name = "TestService"
    }
    
    struct TestContainer: DICprotocol {
        var services: [String: Any] = [:]
    }
    
    var container: TestContainer!
    
    override func setUp() {
        super.setUp()
        container = TestContainer()
    }
    
    override func tearDown() {
        container = nil
        super.tearDown()
    }
    
    func testRegisterAndResolve() {
        let service = TestService()
        container.register(type: TestService.self, service: service)
        
        let resolvedService: TestService = container.resolve(type: TestService.self)
        
        XCTAssertEqual(resolvedService.name, service.name)
    }
}

final class LogTests: XCTestCase {
    
    func testSourceFileName() {
        let filePath = "/User/testProject/testFile.swift"
        let expectedFileName = "testFile.swift"
        
        let fileName = Log.sourceFileName(filePath: filePath)
        
        XCTAssertEqual(fileName, expectedFileName)
    }
}
