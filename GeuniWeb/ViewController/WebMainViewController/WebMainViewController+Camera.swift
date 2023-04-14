//
//  WebMainViewController+Camera.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/04/12.
//

import Foundation

extension WebMainViewController: UIImagePickerControllerDelegate {

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    public func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        print("")
    }
}
