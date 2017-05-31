//
//  Bundle.swift
//  Blank Project
//
//  Created by framgia on 5/31/17.
//  Copyright © 2017 Vo Nguyen Chi Phuong. All rights reserved.
//

import Foundation

public let kCFBundleDisplayNameKey = "kCFBundleDisplayName"
public let kCFBundleNameKey = "CFBundleName"
public let kCFBundleShortVersionKey = "CFBundleShortVersionString"

extension Bundle {
    public var name: String {
        guard let info = infoDictionary else { return "" }
        return info[kCFBundleDisplayNameKey] as? String ?? info[kCFBundleNameKey] as? String ?? ""
    }

    public var version: String {
        guard let info = infoDictionary else { return "" }
        return info[kCFBundleVersionKey as String] as? String ?? ""
    }

    public var build: String {
        guard let info = infoDictionary else { return "" }
        return info[kCFBundleShortVersionKey] as? String ?? ""
    }
}
