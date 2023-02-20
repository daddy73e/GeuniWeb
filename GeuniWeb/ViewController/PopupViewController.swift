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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!

    private var popupInputData: PopupInput?
    private var delegate: PopupViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    public func configure(input: PopupInput) {
        self.popupInputData = input
        self.delegate = input.delegate
    }

    @IBAction func didTapNo(_ sender: Any) {
        self.dismiss(animated: false) { [weak self] in
            self?.delegate?.responsePopupResult(output: .init(result: false))
        }
    }

    @IBAction func didTapYes(_ sender: Any) {
        self.dismiss(animated: false) { [weak self] in
            self?.delegate?.responsePopupResult(output: .init(result: true))
        }
    }

    private func configureUI() {
        self.view.backgroundColor = UIColor(hex: "#0000004C")
        titleLabel.text = popupInputData?.title
        contentsLabel.text = popupInputData?.contents
    }
}
