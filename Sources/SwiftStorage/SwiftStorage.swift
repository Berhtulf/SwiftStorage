import Foundation

public protocol Storage {
    func save(data: Data?, for key: String) throws -> Void
    func loadData(for key: String) throws -> Data?
    func delete(for key: String) throws -> Void

    func save(bool: Bool?, for key: String) throws -> Void
    func loadBool(for key: String) throws -> Bool

    func save(int: Int?, for key: String) throws -> Void
    func loadInt(for key: String) throws -> Int

    func save(double: Double?, for key: String) throws -> Void
    func loadDouble(for key: String) throws -> Double

    func save(string: String?, for key: String) throws -> Void
    func loadString(for key: String) throws -> String?

    func save(value: Encodable, for key: String) throws -> Void
    func load<T: Decodable>(for key: String) throws -> T
}

public struct StorageFactory {
    public static func create(for storageType: StorageDestination) -> Storage {
        switch storageType {
        case .userDefaults:
            return UserDefaultsStorageImpl()
        case let .userDefaultsWith(groupName: groupName):
            return UserDefaultsStorageImpl(groupName: groupName)
        }
    }
}

public enum StorageDestination {
    case userDefaults
    case userDefaultsWith(groupName: String)
}

public enum StorageError: Error {
    case dataNotFound(key: String)
    case corruptedData(key: String)
}
