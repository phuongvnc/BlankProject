//
//  APIManager.swift
//  Wellmeshi
//
//  Created by PhuongVNC on 11/7/16.
//  Copyright © 2016 Vo Nguyen Chi Phuong. All rights reserved.
//

import Foundation
import Alamofire
import Reachability

enum APIResult<T> {
    case success(T)

    case error(APIError)
}

typealias METHOD = HTTPMethod
typealias ServiceResult = Alamofire.Result
typealias JSObject = [String: AnyObject]
typealias JSArray = [JSObject]
typealias Completion = (ServiceResult<Any>) -> Void
typealias ServiceCompletion = (_ result: APIResult<Any>) -> Void
typealias Header = HTTPHeaders
typealias Parameter = Parameters

let serialQueue: OperationQueue = {
    let queue = OperationQueue()
    queue.maxConcurrentOperationCount = 1
    return queue
}()

let backgroundQueue: OperationQueue = {
    let queue = OperationQueue()
    queue.maxConcurrentOperationCount = 6
    return queue
}()

let api = APIManager()
let reachability: Reachability = Reachability.forInternetConnection()

class APIManager {
    private let manager = SessionManager.default
    private let lock = NSLock()
    private var _taskCount = 0


    let validation: DataRequest.Validation = { ( request, result, data) -> DataRequest.ValidationResult in
        return Request.ValidationResult.success
    }

    let downloadValidation: DownloadRequest.Validation = { (request, response, temporaryURL, destinationURL)
        -> DownloadRequest.ValidationResult in
        return DownloadRequest.ValidationResult.success
    }

    var taskCount: Int {
        set {
            lock.sync {
                let oldValue = self._taskCount
                self._taskCount = newValue
                if oldValue == 0 || newValue == 0 {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = newValue > 0
                }
            }
        }

        get {
            return _taskCount
        }
    }

    init() {

    }

    func logout() {
        manager.session.cancelAllTasks(completion: nil)
        backgroundQueue.cancelAllOperations()
    }

    func reset() {
        manager.session.cancelAllTasks(completion: nil)
        backgroundQueue.cancelAllOperations()
    }

    func request(method: METHOD,
                 url: URLConvertible,
                 parameters: Parameter? = nil,
                 headers: Header? = nil,
                 completion: @escaping ServiceCompletion) -> DataRequest {

        let encode: URLEncoding = method == .get ? .queryString : .default
        taskCount += 1
        let request = Alamofire.request(url, method: method, parameters: parameters, encoding: encode, headers: headers)
        request.validate(validation)
        request.response(completion: completion)
        return request
    }

    func download(path: URLConvertible,
                  progress: ((_ progress: Float) -> Void)?,
                  log: Bool = false,
                  completion: @escaping (_ filePath: URL?, _ error: Error?, _ info: String?) -> Void) -> Request {

        var filePath: URL!
        taskCount += 1
        let request = Alamofire.download(path) { (url, response) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
            let link = NSTemporaryDirectory() + url.lastPathComponent
            filePath = URL(fileURLWithPath: link)
            return (filePath, DownloadRequest.DownloadOptions())
        }

        request.downloadProgress { (pro) in
            if let progress = progress {
                progress(Float(pro.completedUnitCount) / Float(pro.totalUnitCount))
            }
            }.validate(downloadValidation).responseJSON { (downloadRespone) in
                self.taskCount -= 1
                switch downloadRespone.result {
                case .success( _):
                    completion(filePath, nil, nil)
                case .failure(let error):
                    completion(nil, error, nil)
                }
        }
        return request

    }
}
// MARK: - URLSession
extension URLSession {
    func cancelAllTasks(completion: (() -> Void)?) {
        getTasksWithCompletionHandler { (tasks, uploads, downloads) in
            for task in tasks {
                task.cancel()
            }
            for task in uploads {
                task.cancel()
            }
            for task in downloads {
                task.cancel()
            }
            completion?()
        }
    }
}


extension NSLock {
    func sync(_ listenser: () -> ()){
        lock()
        listenser()
        unlock()
    }
}
