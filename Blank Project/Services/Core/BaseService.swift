//
//  BaseService.swift
//  Wellmeshi
//
//  Created by PhuongVNC on 11/15/16.
//  Copyright © 2016 Vo Nguyen Chi Phuong. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class BaseService {

    var accessToken: String? {
        return ""
    }

    func request(input: BaseInputProtocol, completion: @escaping ServiceCompletion) {

        if !reachability.isReachable() {
            completion(APIResult.failure(APIError.internetError))
            return
        }
        var header: Header? = Header()
        if let accessToken = accessToken {
            header?["access-token"] = accessToken
        }
        input.header?.append(header)
        let _ = api.request(input: input, completion: completion)
    }

    func requestService(input: BaseInputProtocol, completion: @escaping ServiceCompletion) -> DataRequest? {

        if !reachability.isReachable() {
            completion(APIResult.failure(APIError.internetError))
            return nil
        }

        var header: Header? = Header()
        if let accessToken = accessToken {
            header?["access-token"] = accessToken
        }

        input.header?.append(header)
        return api.request(input: input, completion: completion)
    }
    
}
