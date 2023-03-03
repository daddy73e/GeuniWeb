//
//  LoadingViewController.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/03.
//

import UIKit

final class LoadingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        self.view.backgroundColor = UIColor(hex: "#0000004C")
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }
}
