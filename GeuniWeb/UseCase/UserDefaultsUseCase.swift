//
//  UserDefaultUseCase.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/07.
//

import Foundation

public protocol UserDefaultUseCaseProtocol {
    func read(input: UserDefaultsInput) -> UserDefaultsOutput
    func write(input: UserDefaultsInput)
    func delete(input: UserDefaultsInput)
    func deleteAll()
}

public struct UserDefaultsInput {
    let key: String
    var value: Any?

    init(key: String, value: Any? = nil) {
        self.key = key
        self.value = value
    }
}

public struct UserDefaultsOutput {
    var value: Any?

    init(value: Any? = nil) {
        self.value = value
    }
}

final public class UserDefaultsUseCase: UserDefaultUseCaseProtocol {

    public init() { }

    public func read(input: UserDefaultsInput) -> UserDefaultsOutput {
        let key = input.key
        let value = UserDefaults.standard.value(forKey: key)

        if value is String {
            return UserDefaultsOutput(value: UserDefaults.standard.string(forKey: key))
        } else if value is Int {
            return UserDefaultsOutput(value: UserDefaults.standard.integer(forKey: key))
        } else if value is Bool {
            return UserDefaultsOutput(value: UserDefaults.standard.bool(forKey: key))
        } else if value is [Any] {
            return UserDefaultsOutput(value: UserDefaults.standard.array(forKey: key))
        } else if value is [String: Any] {
            return UserDefaultsOutput(value: UserDefaults.standard.dictionary(forKey: key))
        } else if value is Float {
            return UserDefaultsOutput(value: UserDefaults.standard.float(forKey: key))
        } else if value is Data {
            return UserDefaultsOutput(value: UserDefaults.standard.data(forKey: key))
        } else if value is Double {
            return UserDefaultsOutput(value: UserDefaults.standard.double(forKey: key))
        } else {
            return UserDefaultsOutput(value: nil)
        }
    }

    public func write(input: UserDefaultsInput) {
        UserDefaults.standard.set(input.value, forKey: input.key)
        UserDefaults.standard.synchronize()
    }

    public func delete(input: UserDefaultsInput) {
        UserDefaults.standard.removeObject(forKey: input.key)
        UserDefaults.standard.synchronize()
    }

    public func deleteAll() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}
