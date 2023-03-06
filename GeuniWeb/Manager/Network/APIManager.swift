//
//  APIManager.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/06.
//

import Foundation
import Alamofire

final class APIManager: NSObject {

    public static let shared = APIManager()

    func request(completion: (([String: Any]?, Error?) -> Void)?) {
        let request = AF.request(AppConfigure.shared.baseURL())
        request.responseData { response in
            switch response.result {
            case let .success(data):
                completion?(data.toDictionary(), nil)
            case let .failure(error):
                completion?(nil, error)
            }
        }
    }
}
