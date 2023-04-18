//
//  WebMainViewController+BridgeAction.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/29.
//

extension WebMainViewController {

    func updateConfigure(type: ConfigureType, completion: (() -> Void)?) {
        switch type {
        case .baseURL:
            completion?()
            Router.shared.restart(fromVC: self) { }
        case .screen(let type):
            Task { @MainActor in
                self.updateScreenMode(type: type)
                self.view.setNeedsLayout()
                completion?()
            }
        default:
            completion?()
        }
    }

    func closeWebMain(sendData: String?, completion: (() -> Void)?) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
            self.delegate?.closeWebMain(sendData: sendData)
            completion?()
        } else {
            self.dismiss(animated: true) { [weak self] in
                self?.delegate?.closeWebMain(sendData: sendData)
                completion?()
            }
        }
    }

    func openNewWebPage(urlPath: String, completion: (() -> Void)?) {
        let webViewController = WebMainViewController()
        webViewController.homeUrl = URL(string: urlPath)
        Router.shared.navigateWeb(
            fromVC: self,
            toVC: webViewController,
            delegate: self,
            animated: true
        )
        completion?()
    }

    func showPopup(dictionary: [String: String], completion: (() -> Void)?) {
        Router.shared.showPopup(
            fromVC: self,
            popupInput: .init(
                title: dictionary["title"] ?? "",
                contents: dictionary["contents"] ?? "",
                yesText: dictionary["yesText"] ?? "",
                noText: dictionary["noText"] ?? "",
                completion: { output in
                    print("output = \(output)")
                    completion?()
                }
            )
        )
    }

    func showToast(dictionary: [String: String], completion: (() -> Void)?) {
        let message = dictionary["message"] ?? ""
        Toast.shared.show(option: .init(
            backgroundView: self.view,
            message: message
        ), completion: completion)
    }

    func logout(completion: (() -> Void)?) {
        SNSLoginManager.shared.requestLogout { error in
            if error == nil {
                /* 로그인화면으로 이동 */
                completion?()
            } else {
                AppLog.bridgeLog(message: "Logout 실패")
            }
        }
    }

    func login(loginType: SNSLoginType, error: Error?, completion: (() -> Void)?) {
        switch loginType {
        case .facebook:
            SNSLoginManager.shared.requestFacebookLogin(viewController: self) { userInfo in
                print(userInfo ?? "")
                completion?()
            }
        case .payco:
            SNSLoginManager.shared.requestPaycoLogin { _ in
                completion?()
            }
        default:
            completion?()
        }
    }

    func generateBarcode(code: String, completion: (() -> Void)?) {
        let useCase = GenerateBarcodeUseCase()
        useCase.generateBarcode(input: .init(code: code)) { [weak self] output in
            if let output = output {
                self?.sampleImageView?.image = output.image
                completion?()
            }
        }
    }

    func updatePushStatus(isOn: Bool, completion: (() -> Void)?) {
        if isTargetSimulator() {
            Toast.shared.show(option: .init(
                backgroundView: self.view,
                message: "시뮬레이터에서는 테스트할 수 없습니다."
            ))
            return
        }
        PushManager.shared.updatePushNotificationStatus(isOn: isOn) { [weak self] isSucces in
            guard let self = self else { return }
            if isSucces {
                completion?()
            } else {
                Router.shared.showPopup(
                    fromVC: self,
                    popupInput: .init(
                        title: "알림",
                        contents: "알림 설정 필요",
                        yesText: "확인",
                        noText: "취소",
                        completion: { output in
                            if output.result {
                                Router.shared.openSettingPage()
                            }
                            completion?()
                        }
                    )
                )
            }
        }
    }

    func openCamera(completion: (() -> Void)?) {
        CameraUseCase().checkPermission { permission in
            switch permission {
            case .enableCameraAlbum:
                Task { @MainActor in
                    let camera = UIImagePickerController()
                    camera.sourceType = .camera
                    camera.delegate = self
                    self.present(camera, animated: true, completion: completion)
                }
            case .disableCamera:
                Router.shared.showPopup(
                    fromVC: self,
                    popupInput: .init(
                        title: "카메라 권한 설정이 필요합니다.",
                        completion: { output in
                            completion?()
                            if !output.result {
                                return
                            }
                            Router.shared.openSettingPage()
                        }
                    )
                )
            case .disableAlbum:
                Router.shared.showPopup(
                    fromVC: self,
                    popupInput: .init(
                        title: "앨범 권한 설정이 필요합니다.",
                        completion: { output in
                            completion?()
                            if !output.result {
                                return
                            }
                            Router.shared.openSettingPage()
                        }
                    )
                )
            }
        }
    }

    func historyback(isOn: Bool, completion: (() -> Void)?) {
        if let navigationController = self.navigationController as? BaseNavigationViewController {
            navigationController.isLockSwapeGesture = !isOn
            completion?()
        }
    }

    func currentLocation(completion: (() -> Void)?) {
        LocationManager.shared.checkLocationService()
        LocationManager.shared.delegate = self
    }
}

private extension WebMainViewController {
    func isTargetSimulator() -> Bool {
        return TARGET_IPHONE_SIMULATOR == 1
    }
}

extension WebMainViewController: LocationManagerDelegate {
    public func loactionChangeAuthorization(status: LocationStatus) {
        print("update location status = \(status)")
    }
}
