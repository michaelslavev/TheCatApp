//
//  URL.swift
//  TheCatApp
//
//  Created by Michael Slavev on 07.06.2023.
//

import Foundation

extension URL {
    static func makeShareUrl(for path: String) -> URL? {
        URL(string: "rickandmorty://strv.rickandmorty.com/\(path)")
    }
    
    func valueOf(queryParameter: String) -> String? {
        guard let url = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        return url.queryItems?
            .first { $0.name == queryParameter }?
            .value
    }
}
