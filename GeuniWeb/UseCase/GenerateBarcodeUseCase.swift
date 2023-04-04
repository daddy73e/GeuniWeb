//
//  GenerateBarcodeUseCase.swift
//  ssgcommerce
//
//  Created by 60157085 on 2023/03/27.
//
import UIKit

public protocol GenerateBarcodeUseCaseProtocol {
    func generateBarcode(input: GenerateBarcodeInput, completion: ((GenerateBarcodeOutput?) -> Void)?)
}

public struct GenerateBarcodeInput {
    let code: String
    public init(code: String) {
        self.code = code
    }
}

public struct GenerateBarcodeOutput {
    let image: UIImage?
    public init(image: UIImage?) {
        self.image = image
    }
}

public class GenerateBarcodeUseCase: GenerateBarcodeUseCaseProtocol {

    public init() { }

    public func generateBarcode(
        input: GenerateBarcodeInput,
        completion: ((GenerateBarcodeOutput?) -> Void)?
    ) {
        let data = input.code.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                completion?(.init(image: UIImage(ciImage: output)))
            }
        } else {
            completion?(.init(image: nil))
        }
    }
}
