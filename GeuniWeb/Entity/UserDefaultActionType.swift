//
//  UserDefaultActionType.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/07.
//

public enum UserDefaultActionType {
    case write(key: String, value: Any)
    case read(key: String)
    case remove(key: String)
}
