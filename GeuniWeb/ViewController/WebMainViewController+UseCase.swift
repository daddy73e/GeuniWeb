//
//  WebMainViewController+UseCase.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/29.
//

extension WebMainViewController {
    func generateBarcode(code: String, completion: ((UIImage?) -> Void)?) {
        let useCase = GenerateBarcodeUseCase()
        useCase.generateBarcode(input: .init(code: code)) { output in
            if let output = output {
                completion?(output.image)
            }
        }
    }
}
