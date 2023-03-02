//
//  WebBridgeBusinessActionType.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/02.
//

public enum WebBridgeBusinessActionType {
    case userDefault(type: UserDefaultActionType)
}

public enum UserDefaultActionType {
    case write(key: String, value: Any)
    case read(key: String)
    case remove(key: String)
}
