//
//  CreateAlbumViewModel.swift
//  TomeTome
//
//  Created by yeolife on 11/8/23.
//

import SwiftUI
import PhotosUI

@MainActor
final class ModifyAlbumViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var isSendFuture: Bool = false
    @Published var startDate: Date = Date() // 최소 3분
    @Published var endDate: Date = Date() // 최대 5년
    @Published private(set) var selectedImage: Image? = Image("selectImage")
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
    
    // TODO: - 새로운 앨범을 DB에 저장
    func completeAlbumCreation() {
        
    }
}
