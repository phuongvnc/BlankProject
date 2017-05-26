//
//  ResponseSerializer.swift
//  EParkRelax
//
//  Created by DaoNV on 3/7/16.
//  Copyright © 2016 AsianTech Inc. All rights reserved.
//

import Alamofire

extension DataRequest {
    func response(completion: @escaping ServiceCompletion) {
        responseJSON { (data) -> Void in
            api.taskCount -= 1
            _ = data.request
            let result = data.result
            let response = data.response
            if let response = response {
                self.saveCookies(response: response)
            }
            backgroundQueue.addOperation({ () -> Void in
                if let error = result.error {
                    let apiError = APIError(code: 0, message: error.localizedDescription)
                    OperationQueue.main.addOperation {
                        completion(APIResult.error(apiError))
                    }
                } else {
                    switch response!.statusCode {
                    case 200...299:
                        if let object = result.value as? JSObject {
                            OperationQueue.main.addOperation {
                            completion(APIResult.success(object))
                            }
                        }

                        if let array = result.value as? JSArray {
                                     OperationQueue.main.addOperation {
                            completion(APIResult.success(array))
                            }
                        }
                        break
                    default:
                        let apiError = APIError(code: 0, message:"Handling error")
                        OperationQueue.main.addOperation {
                            completion(APIResult.error(apiError))
                        }
                        break
                    }
                }
            })
        }
    }

    func saveCookies(response: HTTPURLResponse) {
        guard let headerFields = response.allHeaderFields as? [String : String] else { return }
        guard let URL = response.url else { return }
        let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: URL)
        HTTPCookieStorage.shared.setCookies(cookies, for: URL, mainDocumentURL: nil)
    }
}
