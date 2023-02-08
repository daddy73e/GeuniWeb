//
//  WebBridgeAction.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/08.
//

import Foundation

public class WebBridgeAction {
    let requestID: RequestID
    init(requestID: RequestID) {
        self.requestID = requestID
    }

    public func execute(
        request: WebBridgeRequest,
        completion: ((Any?) -> Void)
    ) {
        switch request {
        case .navigator(let webBridgeNavigatorActionType):
            switch webBridgeNavigatorActionType {
            case .preCheckProgramID(let string):
                completion(string)
            case .goPrevPageWithData(let string):
                completion(string)
            case .goMain:
                completion(nil)
            case .logout:
                completion(nil)
            }
        }
    }
}
