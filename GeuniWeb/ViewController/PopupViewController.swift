//
//  PopupViewController.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/20.
//

import UIKit

public struct PopupOutPut {
    var result: Bool
    var param: String

    init(
        result: Bool,
        param: String = ""
    ) {
        self.result = result
        self.param = param
    }
}

public struct PopupInput {
    var title: String
    var contents: String
    var yesText: String
    var noText: String
    var completion: ((PopupOutPut) -> Void)?

    init(
        title: String,
        contents: String = "",
        yesText: String = "YES",
        noText: String = "NO",
        completion: ((PopupOutPut) -> Void)?
    ) {
        self.title = title
        self.contents = contents
        self.yesText = yesText
        self.noText = noText
        self.completion = completion
    }
}

final class PopupViewController: UIViewController {

    @IBOutlet weak var rootVerticalCenter: NSLayoutConstraint!
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!

    private var popupInputData: PopupInput?
    private var flagAnimate = false

    private enum Constants {
        static let animateInterval = 30.0
        static let animateDuration = 0.3
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !flagAnimate {
            showAnimate()
            flagAnimate = true
        }
    }

    public func configure(input: PopupInput) {
        self.popupInputData = input
    }

    @IBAction func didTapNo(_ sender: Any) {
        hideAnimate { [weak self] in
            self?.dismiss(animated: false) { [weak self] in
                self?.popupInputData?.completion?(.init(result: false))
            }
        }
    }

    @IBAction func didTapYes(_ sender: Any) {
        hideAnimate { [weak self] in
            self?.dismiss(animated: false) { [weak self] in
                self?.popupInputData?.completion?(.init(result: true))
            }
        }
    }

    private func configureUI() {
        self.view.backgroundColor = UIColor(hex: "#0000004C")
        self.rootVerticalCenter.constant = Constants.animateInterval
        self.rootView.isHidden = true
        self.titleLabel.text = popupInputData?.title
        self.contentsLabel.text = popupInputData?.contents
        self.noButton.isHidden = popupInputData?.noText.isEmpty ?? true
        self.yesButton.isHidden = popupInputData?.yesText.isEmpty ?? true
        self.noButton.setTitle(popupInputData?.noText, for: .normal)
        self.yesButton.setTitle(popupInputData?.yesText, for: .normal)
    }

    private func showAnimate() {
        if !self.rootView.isHidden {
            return
        }
        self.rootView.isHidden = false
        self.rootVerticalCenter.constant = 0
        self.rootView.alpha = 0
        UIView.animate(
            withDuration: Constants.animateDuration,
            delay: 0,
            options: .curveEaseInOut) {
                self.rootView.alpha = 1
                self.view.layoutIfNeeded()
        } completion: { _ in }
    }

    private func hideAnimate(completion: (() -> Void)? = nil) {
        if self.rootView.isHidden {
            return
        }
        self.rootVerticalCenter.constant = Constants.animateInterval
        self.rootView.alpha = 1
        UIView.animate(
            withDuration: Constants.animateDuration,
            delay: 0,
            options: .curveEaseInOut) {
                self.rootView.alpha = 0
                self.view.layoutIfNeeded()
        } completion: { isFinish in
            if isFinish {
                self.rootView.isHidden = true
                completion?()
            }
        }
    }
}
