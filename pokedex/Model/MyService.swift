//
//  MyService.swift
//  pokedex
//
//  Created by APPMAN M-021 on 7/2/2564 BE.
//

import Foundation
import Moya

enum MyService {
    case getUsers
    case postUsers(user: [String: Any])
}

extension MyService: TargetType {
    // domain
    var baseURL: URL {
        return URL(string: "https://run.mocky.io/v3")!
    }

    // endpoint
    var path: String {
        switch self {
        case .getUsers:
            return "/f9916417-f92e-478e-bfbc-c39e43f7c75b"
        case .postUsers:
            return "/"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getUsers:
            return .get
        case .postUsers:
            return .post
        }
    }

    // using for mock response for unit test
    var sampleData: Data {
        switch self {
        case .getUsers:
            return "".data(using: .utf8)!
        case .postUsers(let user):
            print(user)
            let response = ""
            return Data(response.utf8)
        }
    }

    var task: Task {
        switch self {
        case .getUsers:
            return .requestPlain
        case let .postUsers(user: user):
            return .requestParameters(parameters: ["":(Any).self], encoding: JSONEncoding.default)
        default:
            break
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
