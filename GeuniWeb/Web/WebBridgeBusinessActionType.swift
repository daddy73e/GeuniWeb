//
//  WebBridgeBusinessActionType.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/02.
//

public enum WebBridgeBusinessActionType {
    case userDefault(type: UserDefaultActionType)
    case snsLogin(type: SNSLoginType)
}

public enum UserDefaultActionType {
    case write(key: String, value: Any)
    case read(key: String)
    case remove(key: String)
}

public enum SNSLoginType: String {
    case none
    case apple = "apple"
    init(fromRawValue: String) {
        self = SNSLoginType(rawValue: fromRawValue) ?? .none
    }
}
