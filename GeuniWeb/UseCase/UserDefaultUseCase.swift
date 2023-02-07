//
//  UserDefaultUseCase.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/07.
//

import Foundation

public struct UserDefaultInput {
    let key: String
    var value: Any?

    init(key: String, value: Any? = nil) {
        self.key = key
        self.value = value
    }
}

public struct UserDefaultOutput {
    var value: Any?

    init(value: Any? = nil) {
        self.value = value
    }
}

public protocol UserDefaultUseCaseProtocol {
    func read(input: UserDefaultInput) -> UserDefaultOutput
    func write(input: UserDefaultInput)
    func delete(input: UserDefaultInput)
    func deleteAll()
}

final public class UserDefaultUseCase: UserDefaultUseCaseProtocol {

    public init() { }

    public func read(input: UserDefaultInput) -> UserDefaultOutput {
        let key = input.key
        let value = UserDefaults.standard.value(forKey: key)

        if value is String {
            return UserDefaultOutput(value: UserDefaults.standard.string(forKey: key))
        } else if value is Int {
            return UserDefaultOutput(value: UserDefaults.standard.integer(forKey: key))
        } else if value is Bool {
            return UserDefaultOutput(value: UserDefaults.standard.bool(forKey: key))
        } else if value is [Any] {
            return UserDefaultOutput(value: UserDefaults.standard.array(forKey: key))
        } else if value is [String: Any] {
            return UserDefaultOutput(value: UserDefaults.standard.dictionary(forKey: key))
        } else if value is Float {
            return UserDefaultOutput(value: UserDefaults.standard.float(forKey: key))
        } else if value is Data {
            return UserDefaultOutput(value: UserDefaults.standard.data(forKey: key))
        } else if value is Double {
            return UserDefaultOutput(value: UserDefaults.standard.double(forKey: key))
        } else {
            return UserDefaultOutput(value: nil)
        }
    }

    public func write(input: UserDefaultInput) {
        UserDefaults.standard.set(input.value, forKey: input.key)
        UserDefaults.standard.synchronize()
    }

    public func delete(input: UserDefaultInput) {
        UserDefaults.standard.removeObject(forKey: input.key)
        UserDefaults.standard.synchronize()
    }

    public func deleteAll() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}
