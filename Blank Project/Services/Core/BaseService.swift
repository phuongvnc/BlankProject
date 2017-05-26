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



    func request(method: METHOD, path: URLConvertible, params: Parameter? = nil, completion: @escaping ServiceCompletion) {

        if !reachability.isReachable() {
            completion(APIResult.error(APIError.internetError))
            return
        }
        var header: Header? = Header()
        if let accessToken = accessToken {
                header?["access-token"] = accessToken
        }


        let _ = api.request(method: method, url: path, parameters: params, headers: header, completion: completion)
    }

    func requestService(method: METHOD, path: URLConvertible, params: Parameter? = nil, completion: @escaping ServiceCompletion) -> DataRequest? {

        if !reachability.isReachable() {
            completion(APIResult.error(APIError.internetError))
            return nil
        }

        var header: Header? = Header()
        if let accessToken = accessToken {
                header?["access-token"] = accessToken
        }
        return api.request(method: method, url: path, parameters: params, headers: header, completion: completion)
    }

}
