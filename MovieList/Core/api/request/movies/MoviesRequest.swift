//
//  MoviesRequest.swift
//  MovieList
//
//  Created by Can Bas on 3.04.2023.
//

import Foundation

enum MoviesRequest: RequestProtocol {

case getMoviesBy(search: String, page: Int)

    var urlParams: [String: String?] {
        switch self {
        case let .getMoviesBy(search, page):
            var params: [String: String] = [:]

            params["apikey"] = APIConstants.apikey
            if !search.isEmpty { params["s"] = search }
            params["page"] = String(page)

            return params
        }
    }
    var path: String {
        "/"
    }

    var requestType: RequestType {
        .GET
    }


}
