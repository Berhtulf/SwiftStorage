//
//  File.swift
//  
//
//  Created by Martin Václavík on 27.08.2022.
//

import Foundation

final class UserDefaultsStorageImpl: Storage {
    private let userDefaults: UserDefaults

    func save(data: Data?, for key: String) throws {
        userDefaults.set(data, forKey: key)
    }

    func loadData(for key: String) throws -> Data? {
        userDefaults.data(forKey: key)
    }

    func delete(for key: String) throws {
        userDefaults.removeObject(forKey: key)
    }

    func save(bool: Bool?, for key: String) throws {
        userDefaults.set(bool, forKey: key)
    }

    func loadBool(for key: String) throws -> Bool {
        userDefaults.bool(forKey: key)
    }

    func save(int: Int?, for key: String) throws {
        userDefaults.set(int, forKey: key)
    }

    func loadInt(for key: String) throws -> Int {
        userDefaults.integer(forKey: key)
    }

    func save(double: Double?, for key: String) throws {
        userDefaults.set(double, forKey: key)
    }

    func loadDouble(for key: String) throws -> Double {
        userDefaults.double(forKey: key)
    }

    func save(string: String?, for key: String) throws {
        userDefaults.set(string, forKey: key)
    }

    func loadString(for key: String) throws -> String? {
        userDefaults.string(forKey: key)
    }

    func save(value data: Encodable, for key: String) throws {
        let encoder = JSONEncoder()
        userDefaults.set(try encoder.encode(data), forKey: key)
    }

    func load<T: Decodable>(for key: String) throws -> T {
        guard let data = userDefaults.data(forKey: key) else {
            throw StorageError.dataNotFound(key: key)
        }
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }

    init(groupName: String? = nil) {
        if let groupName = groupName, let userDefaults = UserDefaults(suiteName: groupName) {
            self.userDefaults = userDefaults
        } else {
            self.userDefaults = .standard
        }
    }
}
