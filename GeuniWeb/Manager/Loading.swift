//
//  Loading.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/03.
//

import UIKit

public class Loading {
    public static let shared = Loading()
    private let loadingViewController = LoadingViewController()
    private var timeManager = TimerManager.init(finishTime: 10.0)
    private var isShowLoading = false

    public func show(fromVC: UIViewController) {
        if isShowLoading {
            return
        }
        isShowLoading = true
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }

            self.loadingViewController.modalPresentationStyle = .overFullScreen
            fromVC.present(self.loadingViewController, animated: false)
            self.timeManager.startTimer(tickAction: nil) { [weak self] in
                self?.hide()
            }
        }
    }

    public func hide() {
        if !isShowLoading {
            return
        }
        isShowLoading = false
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.loadingViewController.dismiss(animated: false)
        }
    }
}
