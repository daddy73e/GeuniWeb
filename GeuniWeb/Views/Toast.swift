//
//  Toast.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/04/04.
//

import UIKit

public struct ToastOption {
    let backgroundView: UIView
    var message: String
    var font: UIFont?
    var textColor: UIColor = .white
    var backgroundColor: UIColor = .lightGray
    var showHideAnimateDuration: CGFloat
    var showingSecond: CGFloat
    var verticalPadding: CGFloat
    var horizontalPadding: CGFloat
    var isFixed: Bool

    public init(
        backgroundView: UIView,
        message: String,
        font: UIFont? = UIFont.boldSystemFont(ofSize: 15),
        textColor: UIColor = .white,
        backgroundColor: UIColor = .lightGray,
        showHideAnimateDuration: CGFloat = 0.3,
        showingSecond: CGFloat = 2.0,
        verticalPadding: CGFloat = 15.0,
        horizontalPadding: CGFloat = 10.0,
        isFixed: Bool = false
    ) {
        self.backgroundView = backgroundView
        self.message = message
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.showHideAnimateDuration = showHideAnimateDuration
        self.showingSecond = showingSecond
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.isFixed = isFixed
    }
}

final class Toast {
    static let shared = Toast()
    private var isShowing = false

    var toastFrame: UIView?
    var toastLabel: UILabel?
    var option: ToastOption?

    // swiftlint:disable function_body_length
    func show(
        option: ToastOption,
        completion: (() -> Void)? = nil
    ) {
        self.option = option
        if isShowing {
            return
        }
        self.isShowing = true
        DispatchQueue.main.async { [weak self] in
            self?.toastFrame = UIView()
            self?.toastLabel = UILabel(frame: .zero)
            guard let toastFrame = self?.toastFrame else {
                return
            }

            guard let toastLabel = self?.toastLabel else {
                return
            }

            toastLabel.textColor = option.textColor
            toastLabel.font = option.font
            toastLabel.textAlignment = .center
            toastLabel.text = option.message
            toastLabel.alpha = 1.0
            toastLabel.sizeToFit()
            toastLabel.center = CGPoint(
                x: option.backgroundView.center.x,
                y: option.backgroundView.bounds.height
            )
            toastFrame.backgroundColor = .lightGray
            toastFrame.frame = CGRect(
                x: toastLabel.frame.origin.x - option.verticalPadding,
                y: toastLabel.frame.origin.y - option.horizontalPadding,
                width: toastLabel.frame.size.width + option.verticalPadding * 2,
                height: toastLabel.frame.size.height + option.horizontalPadding * 2
            )
            toastFrame.layer.cornerRadius = (toastLabel.frame.size.height + option.horizontalPadding * 2) / 2
            toastFrame.layer.masksToBounds = true
            option.backgroundView.addSubview(toastFrame)
            option.backgroundView.addSubview(toastLabel)
            UIView.animate(
                withDuration: option.showHideAnimateDuration,
                delay: 0.0,
                options: .curveEaseInOut,
                animations: {
                    toastLabel.center = CGPoint(
                        x: option.backgroundView.center.x,
                        y: option.backgroundView.bounds.height - (option.backgroundView.safeAreaInsets.bottom + 60)
                    )
                    toastFrame.center = toastLabel.center
                    option.backgroundView.layoutIfNeeded()
                }, completion: { _ in
                    if option.isFixed {
                        completion?()
                        return
                    }
                    self?.hide(completion: completion)
                }
            )
        }
    }

    func hide(
        animate: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        guard let toastFrame = self.toastFrame else {
            completion?()
            return
        }

        guard let toastLabel = self.toastLabel else {
            completion?()
            return
        }

        guard let option = self.option else {
            completion?()
            return
        }

        if !animate {
            DispatchQueue.main.async { [weak self] in
                toastLabel.removeFromSuperview()
                toastFrame.removeFromSuperview()
                self?.isShowing = false
                self?.option = nil
                completion?()
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                UIView.animate(
                    withDuration: option.showHideAnimateDuration,
                    delay: option.showingSecond,
                    options: .curveEaseOut,
                    animations: {
                        toastLabel.alpha = 0.0
                        toastFrame.alpha = 0.0
                        toastLabel.center = CGPoint(
                            x: option.backgroundView.center.x,
                            y: option.backgroundView.bounds.height
                        )
                        toastFrame.center = toastLabel.center
                        option.backgroundView.layoutIfNeeded()
                    }, completion: {[weak self] _ in
                        toastLabel.removeFromSuperview()
                        toastFrame.removeFromSuperview()
                        self?.isShowing = false
                        self?.option = nil
                        completion?()
                    }
                )
            }
        }
    }
}
