//
//  ServiceError.swift
//  Wellmeshi
//
//  Created by PhuongVNC on 11/18/16.
//  Copyright © 2016 Vo Nguyen Chi Phuong. All rights reserved.
//

import Foundation

struct APIError {
    var code = 0
    var message: String?

    static var jsonError: APIError {
        let error = APIError(code: 0, message: "Error format JSON")
        return error
    }

    static var internetError: APIError {
        let error = APIError(code: 0, message: "The connect wasn't lost")
        return error
    }
}
