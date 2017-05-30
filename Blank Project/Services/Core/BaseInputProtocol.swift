//
//  BaseInput.swift
//  Blank Project
//
//  Created by framgia on 5/30/17.
//  Copyright © 2017 Vo Nguyen Chi Phuong. All rights reserved.
//

import Foundation
import Alamofire

protocol BaseInputProtocol: class {
    var url: URLConvertible { get set }
    var header: Header? { get set }
    var parameter: Parameter? { get set }
    var method: HTTPMethod { get set }
}
