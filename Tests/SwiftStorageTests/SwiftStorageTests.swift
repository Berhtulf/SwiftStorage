import XCTest
@testable import SwiftStorage

final class SwiftStorageTests: XCTestCase {
    var storage: Storage!

    override func setUp() {
        storage = StorageFactory.create(for: .userDefaults)
    }

    func testExample() throws {
        try storage.save(value: true, for: "Bool")
        let loadedTrueValue: Bool = try storage.load(for: "Bool")
        XCTAssertTrue(loadedTrueValue)

        try storage.save(value: false, for: "Bool")
        let loadedFalseValue: Bool = try storage.load(for: "Bool")
        XCTAssertFalse(loadedFalseValue)
    }

    func testSaveThenLoadString() throws {
        try storage.save(string: "Example string", for: "String")
        let loadedValue = try storage.loadString(for: "String")

        XCTAssertEqual("Example string", loadedValue)
    }
}
