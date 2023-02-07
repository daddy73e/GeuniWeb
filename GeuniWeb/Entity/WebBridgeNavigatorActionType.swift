//
//  WebBridgeNavigatorActionType.swift
//  GeuniModule
//
//  Created by 60157085 on 2023/02/05.
//

import Foundation

public enum WebBridgeNavigatorActionType {
    case preCheckProgramID(String) // ProgramID로 화면 이동이 가능한지 체크
    case goPrevPageWithData(String) // 이전 페이지 이동
    case goMain(Int?, Int?) // 웹뷰 종료, 메인위에 쌓여있던 모든 화면 날리고 메인으로 이동 + 탭 스위칭
    case logout // 로그아웃
}
