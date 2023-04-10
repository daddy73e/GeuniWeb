//
//  PhotoAlbumUseCase.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/04/10.
//

import Foundation

public protocol PhotoAlbumUseCaseProtocol {
    func execute(input: PhotoAlbumInput) -> PhotoAlbumOutput
}

public struct PhotoAlbumInput {
}

public struct PhotoAlbumOutput {
}

public class PhotoAlbumUseCase: PhotoAlbumUseCaseProtocol {
    public init() {
    }
    public func execute(input: PhotoAlbumInput) -> PhotoAlbumOutput {
        return PhotoAlbumOutput()
    }
}
