//
//  APIPath.swift
//  Wellmeshi
//
//  Created by PhuongVNC on 11/15/16.
//  Copyright © 2016 Vo Nguyen Chi Phuong. All rights reserved.
//

import Foundation
import Alamofire

class APIPath {

    static var EndPoint = "https://dev.wellmeshi.com/api/v1/"

    struct Login {
        static var path: String { return EndPoint }
        static var loginFacebook: String { return path + "omniauth/facebook" }
        static var login: String { return path + "auth/sign_in" }
        static var forgot: String { return path + "auth/password" }
        var URLString: String { return Login.path }
    }

}
