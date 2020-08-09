//
//  Result+Chain.swift
//  githubtrends
//
//  Created by Raluca Toadere on 07/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import Foundation

extension Result {
    @discardableResult
    func onSuccess(_ task: (Success) -> Void) -> Result {
        switch self {
        case .success(let value):
            task(value)
        case .failure:
            break
        }
        return self
    }

    @discardableResult
    func onFailure(_ task: (Failure) -> Void) -> Result {
        switch self {
        case .success:
            break
        case .failure(let error):
            task(error)
        }
        return self
    }
}
