//
//  WebBridgeRequest.swift
//  GeuniModule
//
//  Created by 60157085 on 2023/02/05.
//

public enum WebBridgeRequest {
    case closeWeb(String)
    case showAlertPopup([String: String]) // ProgramID로 화면 이동이 가능한지 체크
    case login(loginType: SNSLoginType, error: Error?)
    case logout
    case userDefault(type: UserDefaultActionType)
    case requestAPI
    case updateConfigure(type: ConfigureType)
    case generateBarcode(code: String)
}
