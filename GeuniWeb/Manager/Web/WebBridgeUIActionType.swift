//
//  WebBridgeUIActionType.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/02.
//

public enum WebBridgeUIActionType {
    case closeWeb(String)
    case showAlertPopup([String: String]) // ProgramID로 화면 이동이 가능한지 체크
    case login(loginType: SNSLoginType, error: Error?)
    case logout
}
