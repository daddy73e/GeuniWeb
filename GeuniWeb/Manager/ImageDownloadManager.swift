//
//  ImageDownloadManager.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/05/15.
//

import Foundation
import Kingfisher

public class ImageDownloadManager: NSObject {
    public static let shared = ImageDownloadManager()
    private override init() { }
    
    private func savedSplashImageKeyValue() -> (String, String?) {
        if let savedImageDictionary = UserDefaultsUseCase().read(
            input: .init(
                key: UserDefaultKey.splashImageUrl.rawValue
            )
        ).value as? [String: String] {
            if savedImageDictionary.isEmpty {
                return ("", "")
            } else {
                for key in savedImageDictionary.keys {
                    return (key, savedImageDictionary[key])
                }
                return ("", "")
            }
        } else {
            return ("", "")
        }
    }

    public func removeImage(
        completion: ((Bool) -> Void)?
    ) {
        if let imageName = savedSplashImageKeyValue().1 {
            FileManagerUseCase().delete(
                input: .init(fileName: imageName)
            ) { output in
                if output.result {
                    UserDefaultsUseCase().delete(input: .init(key: UserDefaultKey.splashImageUrl.rawValue))
                    completion?(true)
                } else {
                    completion?(false)
                }
            }
        } else {
            completion?(false)
        }
    }
    
    public func loadSplashImage(
        completion: ((Data?) -> Void)?
    ) {
        if let imageName = savedSplashImageKeyValue().1 {
            if !imageName.isEmpty {
                FileManagerUseCase().read(input: .init(fileName: imageName)) { output in
                    completion?(output.data)
                }
            } else {
                completion?(nil)
            }
        } else {
            completion?(nil)
        }
    }
    
    public func downloadImage(
        urlString: String,
        completion: ((String?) -> Void)?
    ) {
        guard let url = URL.init(string: urlString) else {
            completion?(nil)
            return
        }
        
        let imageKey = savedSplashImageKeyValue().0
        if imageKey.isEmpty {
            downloadImageUsingKingfisher(url: url, completion: completion)
        } else if imageKey != urlString {
            removeImage { [weak self] isSuccess in
                if isSuccess {
                    self?.downloadImageUsingKingfisher(url: url, completion: completion)
                } else {
                    completion?(nil)
                }
            }
        } else {
            completion?(nil)
        }
    }
    
    private func downloadImageUsingKingfisher(
        url: URL,
        completion: ((String?) -> Void)?
    ) {
        let resource = ImageResource(downloadURL: url)
        KingfisherManager.shared.retrieveImage(
            with: resource,
            options: nil,
            progressBlock: nil
        ) { result in
            switch result {
            case .success(let value):
                if let imageData = value.image.jpegData(compressionQuality: 1.0) {
                    let fileName = "fnb_\(Date().toString())"
                    FileManagerUseCase().write(input: .init(
                        data: imageData,
                        fileName: fileName
                    )) { output in
                        if output.result {
                            completion?(fileName)
                        } else {
                            completion?(nil)
                        }
                    }
                }
            case .failure:
                completion?(nil)
            }
        }
    }
}
