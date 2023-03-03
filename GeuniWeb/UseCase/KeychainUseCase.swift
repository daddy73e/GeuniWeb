//
//  KeychainUseCase.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/02.
//

import Foundation

public struct KeychainInput {
    let key: String
    let saveData: String?
    
    public init(
        key: String,
        saveData: String? = nil
    ) {
        self.key = key
        self.saveData = saveData
    }
}

public struct KeychainOutput {
    let savedData: String
    public init(savedData: String) {
        self.savedData = savedData
    }
}

public protocol KeychainUseCaseProtocol {
    func write(input: KeychainInput)
    func read(input: KeychainInput) -> String?
    func delete(input: KeychainInput)
}

public class KeychainUseCase: KeychainUseCaseProtocol {

    public init() { }

    public func write(input: KeychainInput) {
        if let saveData = input.saveData {
            writeKeychain(data: saveData, key: input.key)
        }
    }

    public func read(input: KeychainInput) -> String? {
        return readKeychain(key: input.key)
    }

    public func delete(input: KeychainInput) {
        deleteKeychain(key: input.key)
    }

    private func keychainAttributes(key: String) -> [AnyHashable: Any] {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecAttrGeneric as String: key
        ]
        var attributes: [AnyHashable: Any] = .init()
        var result: AnyObject?
        var status = SecItemCopyMatching(query as CFDictionary, &result)

        if status == errSecSuccess,
           let resultDic = result as? [AnyHashable: Any] {
            attributes = resultDic
            attributes[kSecReturnData as String] = kCFBooleanTrue
            attributes[kSecClass as String] = kSecClassGenericPassword

            var passwordData: AnyObject?
            status = SecItemCopyMatching(attributes as CFDictionary, &passwordData)

            if status == errSecSuccess {
                attributes.removeValue(forKey: kSecReturnData as String)
                attributes[kSecValueData as String] = passwordData
            }
        } else {
            attributes = [
                kSecAttrAccount as String: key,
                kSecAttrGeneric as String: key,
                kSecAttrLabel as String: "",
                kSecAttrDescription as String: "",
                kSecValueData as String: Data()
            ]
        }

        return attributes
    }

    /// 키체인 읽기
    private func readKeychain(key: String) -> String? {
        let attributes: [AnyHashable: Any] = keychainAttributes(key: key)

        guard let result = attributes[kSecValueData as String] else {
            return nil
        }

        if let data = result as? Data,
           let string = String(data: data, encoding: .utf8) {
            return string
        }
        return nil
    }

    /// 키체인 저장
    private func writeKeychain(data: String, key: String) {
        guard let data = data.data(using: .utf8) else {
            return
        }
        var attributes: [AnyHashable: Any] = keychainAttributes(key: key)
        var status = errSecSuccess
        if let passwordData = attributes[kSecValueData as String] as? Data,
           data != passwordData {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecMatchLimit as String: kSecMatchLimitOne,
                kSecReturnAttributes as String: true,
                kSecAttrGeneric as String: key
            ]
            var result: AnyObject?
            status = SecItemCopyMatching(query as CFDictionary, &result)
            if status == errSecSuccess,
               var updateItem = result as? [AnyHashable: Any] {
                updateItem[kSecClass as String] = kSecClassGenericPassword
                attributes[kSecValueData as String] = data
                attributes.removeValue(forKey: kSecClass as String)
                status = SecItemUpdate(updateItem as CFDictionary, attributes as CFDictionary)
            } else {
                attributes[kSecClass as String] = kSecClassGenericPassword
                attributes[kSecValueData as String] = data
                status = SecItemAdd(attributes as CFDictionary, nil)
            }
        }
    }

    /// 키체인 삭제
    private func deleteKeychain(key: String) {
        var attributes: [AnyHashable: Any] = keychainAttributes(key: key)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecAttrGeneric as String: key
        ]

        var result: AnyObject?
        var status = SecItemCopyMatching(query as CFDictionary, &result)
        if status == errSecSuccess {
            attributes[kSecClass as String] = kSecClassGenericPassword
            status = SecItemDelete(attributes as CFDictionary)
        }
    }
}
