//
//  FileManagerUseCase.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/04/06.
//

import Foundation

public protocol FileManagerUseCaseProtocol {
    func write(input: WriteFileManagerInput, compleiton: ((WriteFileManagerOutput) -> Void)?)
    func read(input: ReadFileManagerInput, compleiton: ((ReadFileManagerOutput) -> Void)?)
}

public struct WriteFileManagerInput {
    let data: Data
    let fileName: String
    let fileStoreKey: String?
    public init(
        data: Data,
        fileName: String,
        fileStoreKey: String? = nil) {
        self.data = data
        self.fileName = fileName
        self.fileStoreKey = fileStoreKey
    }
}

public struct WriteFileManagerOutput {
    let result: Bool
    public init(result: Bool) {
        self.result = result
    }
}

public struct ReadFileManagerInput {
    let fileName: String
    public init(fileName: String) {
        self.fileName = fileName
    }
}

public struct ReadFileManagerOutput {
    let data: Data?
    public init(data: Data?) {
        self.data = data
    }
}

public class FileManagerUseCase: FileManagerUseCaseProtocol {
    public init() { }
    public func write(
        input: WriteFileManagerInput,
        compleiton: ((WriteFileManagerOutput) -> Void)?
    ) {
        let data = input.data
        guard let directory = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ) as NSURL else {
            compleiton?(.init(result: false))
            return
        }
        do {
            if let url = directory.appendingPathComponent(input.fileName) {
                try data.write(to: url)
                if let key = input.fileStoreKey {
                    UserDefaultsUseCase().write(
                        input: .init(
                            key: UserDefaultKey.splashImage.rawValue,
                            value: [key: input.fileName] 
                        )
                    )
                }
                compleiton?(.init(result: true))
            }
        } catch {
            compleiton?(.init(result: false))
        }
    }

    public func read(
        input: ReadFileManagerInput,
        compleiton: ((ReadFileManagerOutput) -> Void)?
    ) {
        guard let directory = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ) as NSURL else {
            compleiton?(.init(data: nil))
            return
        }

        do {
            if let url = directory.appendingPathComponent(input.fileName) {
                let data = try Data(contentsOf: url)
                compleiton?(.init(data: data))
            }
        } catch {
            compleiton?(.init(data: nil))
        }
    }
}
