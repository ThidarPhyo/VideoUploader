//
//  Uploader.swift
//  VideoUploader
//
//  Created by cmStudent on 2023/08/18.
//

import Foundation
import FirebaseStorage

struct Uploader {
    static func uploadVideo(withData videoData: Data) async throws -> String? {
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference().child("/videos/\(fileName)")
        let metaData = StorageMetadata()
        metaData.contentType = "video/quicktime"
        
        do {
            let _ = try await ref.putDataAsync(videoData,metadata: metaData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("DEbug failed \(error.localizedDescription)")
            return nil
        }
    }
}
