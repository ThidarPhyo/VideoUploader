//
//  Video.swift
//  VideoUploader
//
//  Created by cmStudent on 2023/08/18.
//

import Foundation

struct Video: Identifiable, Decodable {
    let videoUrl : String
    var id: String {
        return NSUUID().uuidString
    }
}
