//
//  CreateAlbumViewModel.swift
//  TomeTome
//
//  Created by yeolife on 11/8/23.
//

import SwiftUI
import PhotosUI

class CreateAlbumViewModel: ObservableObject {
    @Published var title: String = ""
    @Published private(set) var selectedImage: Image? = Image("acorn")
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        
        Task {
            do {
                let data = try await selection.loadTransferable(type: Data.self)
                
                guard let data, let uiImage = UIImage(data: data) else {
                    throw URLError(.badServerResponse)
                }
                
                selectedImage = Image(uiImage: uiImage)
            } catch {
                print(error)
            }
        }
    }
}
