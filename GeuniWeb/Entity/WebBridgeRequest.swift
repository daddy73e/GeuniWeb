//
//  WebBridgeRequest.swift
//  GeuniModule
//
//  Created by 60157085 on 2023/02/05.
//

public enum WebBridgeRequest {
    case goAdmin
    case closeWeb(String)
    case openNewWebPage(String)
    case showPopup([String: String]) // ProgramID로 화면 이동이 가능한지 체크
    case showToast([String: String])
    case login(loginType: SNSLoginType, error: Error?)
    case logout
    case userDefaults(type: UserDefaultActionType)
    case requestAPI
    case updateConfigure(type: ConfigureType)
    case generateBarcode(code: String)
    case updatePushStatus(isOn: Bool)
    case openCamera
    case historyback(isOn: Bool)
    case currentLocation
}
