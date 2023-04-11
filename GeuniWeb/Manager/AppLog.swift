//
//  AppLog.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/04/11.
//

import Foundation

final class AppLog {

    static func log(
        file: String = #fileID,
        function: String = #function,
        message: String
    ) {
#if DEBUG
        DispatchQueue.global().async {
            print("##AppLog ------------- Log Start -------------")
            print("##AppLog \(file), \(function), \(message)")
            print("##AppLog ------------- Log End -------------\n")
            print("##AppLog")
        }
#endif
    }

    static func bridgeLog(message: String) {
        DispatchQueue.global().async {
#if DEBUG
            let log = """
        ##AppLog
        ##AppLog ----- 📤 Bridging Response Start -----
        ##AppLog [📦] Java Script String: \n\(message)
        ##AppLog ----- 📤 Bridging Response End -----\n
        ##AppLog
        """
            print(log)
#endif
        }
    }
}
