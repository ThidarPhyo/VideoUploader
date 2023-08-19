//
//  ContentViewModel.swift
//  VideoUploader
//
//  Created by cmStudent on 2023/08/18.
//

import Foundation
import SwiftUI
import PhotosUI
import Firebase
import FirebaseFirestoreSwift

class ContentViewModel: ObservableObject {
    
    @Published var videos = [Video]()
    
    @Published var selectedItem: PhotosPickerItem? {
        didSet { Task {
            try await uploadVideo()
        }}
    }
    
    init() {
        Task {
            try await fetchVideo()
        }
    }
    
    func uploadVideo() async throws {
        guard let item = selectedItem else {
            return
        }
        guard let videoData = try await item.loadTransferable(type: Data.self) else {
            return
        }
        print("Debug video data \(videoData)")
        
        guard let videoUrl = try await Uploader.uploadVideo(withData: videoData) else {
            return
        }
        try await Firestore.firestore().collection("videos").document().setData(["videoUrl": videoUrl])
        print("Finished video upload.................")
    }
    
    @MainActor
    func fetchVideo() async throws {
        let snapshot = try await Firestore.firestore().collection("videos").getDocuments()
//        self.videos = snapshot.documents.compactMap({ try? $0.data(as: Video.self)
//        })
        self.videos = snapshot.documents.compactMap { document in
            do {
                let videoData = try document.data(as: Video.self)
                return videoData
            } catch {
                // This will help you see what specific error occurred during conversion
                print("Error converting document to Video: \(error)")
                return nil
            }
        }

        // Print the videos array for debugging purposes
        print("Videos: \(self.videos)")


        for doc in snapshot.documents {
            print(doc.data())
            
        }
    }
}
