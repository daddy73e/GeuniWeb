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
    var delegate: PopupViewDelegate?

    init(
        title: String,
        contents: String = "",
        yesText: String = "YES",
        noText: String = "NO",
        delegate: PopupViewDelegate? = nil
    ) {
        self.title = title
        self.contents = contents
        self.yesText = yesText
        self.noText = noText
        self.delegate = delegate
    }
}

protocol PopupViewDelegate: AnyObject {
    func responsePopupResult(output: PopupOutPut)
}

final class PopupViewController: UIViewController {

    @IBOutlet weak var rootVerticalCenter: NSLayoutConstraint!
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!

    private var popupInputData: PopupInput?
    private var delegate: PopupViewDelegate?
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
        self.delegate = input.delegate
    }

    @IBAction func didTapNo(_ sender: Any) {
        hideAnimate { [weak self] in
            self?.dismiss(animated: false) { [weak self] in
                self?.delegate?.responsePopupResult(output: .init(result: false))
            }
        }
    }

    @IBAction func didTapYes(_ sender: Any) {
        hideAnimate { [weak self] in
            self?.dismiss(animated: false) { [weak self] in
                self?.delegate?.responsePopupResult(output: .init(result: true))
            }
        }
    }

    private func configureUI() {
        self.view.backgroundColor = UIColor(hex: "#0000004C")
        titleLabel.text = popupInputData?.title
        contentsLabel.text = popupInputData?.contents
        self.rootVerticalCenter.constant = Constants.animateInterval
    }

    private func showAnimate() {
        self.rootVerticalCenter.constant = 0
        self.rootView.alpha = 0
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: .curveEaseInOut) {
                self.rootView.alpha = 1
                self.view.layoutIfNeeded()
        } completion: { _ in }
    }

    private func hideAnimate(completion: (() -> Void)? = nil) {
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
                completion?()
            }
        }
    }
}
