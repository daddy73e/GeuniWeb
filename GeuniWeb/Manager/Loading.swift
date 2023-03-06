//
//  Loading.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/03.
//
import UIKit

protocol LoadingPresentable {
    /// Show loading indicator
    func show(withMessage message: String?)
    /// Hide loading indicator
    func hide()
    /// Show loading indicator with Unique Value
    func showWithID(
        withMessage message: String?,
        file: String,
        function: String
    )
    /// Hide loading indicator with Unique Value
    func hideWithID(
        file: String,
        function: String
    )
}

final class Loading: UIView, LoadingPresentable {

    static let shared = Loading()
    private var loadingSet: Set<String> = []
    private let backgroundView: UIView = UIView(frame: UIScreen.main.bounds)
    private let contentView = UIView()
    private var indicator: UIActivityIndicatorView?

    private enum Constants {
        static let loadingImageViewSize: CGFloat = 80
        static let contentsSpace: CGFloat = 12
        static let defaultLoadingID: String = "\(#fileID)/\(#function)"
    }

    private convenience init() {
        self.init(frame: UIScreen.main.bounds)
        configureUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: LoadingPresentable
    /// showLoading을 선행시켜서 loadingSet이 Empty여야만 UI로직을 태우도록 작성
    func showWithID(
        withMessage message: String? = nil,
        file: String = #fileID,
        function: String = #function
    ) {
        Task { @MainActor in
            self.showLoading(with: message, set: self.loadingSet)
            self.loadingSet.insert("\(file)/\(function)")
        }
    }

    func hideWithID(
        file: String = #fileID,
        function: String = #function
    ) {
        Task { @MainActor in
            self.loadingSet.remove("\(file)/\(function)")
            self.hideLoading(set: self.loadingSet)
        }
    }

    /// showLoading을 선행시켜서 loadingSet이 Empty여야만 UI로직을 태우도록 작성
    func show(withMessage message: String? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.showLoading(with: message, set: self.loadingSet)
            self.loadingSet.insert(Constants.defaultLoadingID)
        }
    }

    func hide() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.loadingSet.remove(Constants.defaultLoadingID)
            self.hideLoading(set: self.loadingSet)
        }
    }
}

private extension Loading {
    func configureUI() {
        backgroundView.backgroundColor = .clear
    }

    func addOnWindow() {
        if let window = getKeyWindow() {
            window.addSubview(self)
        }
    }

    func configureSubViews() {
        indicator = UIActivityIndicatorView(frame: .init(x: 0, y: 0, width: 100, height: 100))
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        indicator?.translatesAutoresizingMaskIntoConstraints = false
        indicator?.color = .white
        contentView.backgroundColor = UIColor(hex: "#0000004C")

        addSubview(backgroundView)
        backgroundView.addSubview(contentView)

        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),

            contentView.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: self.backgroundView.bottomAnchor, constant: 0),
            contentView.topAnchor.constraint(equalTo: self.backgroundView.topAnchor, constant: 0)
        ])

        if let indicator = self.indicator {
            indicator.isHidden = false
            indicator.startAnimating()
            contentView.addSubview(indicator)
            NSLayoutConstraint.activate([
                indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        }
    }

    func removeSubViews() {
        indicator?.removeFromSuperview()
        contentView.removeFromSuperview()
        backgroundView.removeFromSuperview()
        self.removeFromSuperview()
    }

    func getKeyWindow() -> UIWindow? {
        var window: UIWindow?
        window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        return window
    }

    @objc
    func closeLoading() {
        hide()
    }

    func showLoading(
        with message: String?,
        set: Set<String>
    ) {
        guard set.isEmpty else { return }
        addOnWindow()
        configureSubViews()
    }

    func hideLoading(set: Set<String>) {
        guard set.isEmpty else { return }
        removeSubViews()
    }
}
