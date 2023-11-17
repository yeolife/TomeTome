//
//  AlbumCreate.swift
//  TomeTome
//
//  Created by yeolife on 10/26/23.
//

import SwiftUI
import PhotosUI

@MainActor
struct ModifyAlbumView: View {
    @Binding var isCreateMode: Bool
    @StateObject var createAlbumViewModel = ModifyAlbumViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            pickerImage(createAlbumViewModel: createAlbumViewModel)
            
            titleField(createAlbumViewModel: createAlbumViewModel)
            
            Spacer()
            
            HStack(alignment: .center, spacing: 0) {
                dismissButton(text: "취소") {
                    isCreateMode = false
                }
                .foregroundColor(.red)
                
                dismissButton(text: "완료") {
                    createAlbumViewModel.completeAlbumCreation()
                    
                    isCreateMode = false
                }
            }
        }
        .background(Color(.systemBackground))
        .frame(width: 300, height: 455)
        .cornerRadius(12)
        .shadow(radius: 40)
    }
}

struct pickerImage: View {
    @ObservedObject var createAlbumViewModel: ModifyAlbumViewModel
    
    var body: some View {
        PhotosPicker(selection: $createAlbumViewModel.imageSelection, matching: .images) {
            if let image = createAlbumViewModel.selectedImage {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 275)
                    .cornerRadius(12)
                    .padding(.vertical, 28)
            }
        }
        .onAppear {
            PhotoLibraryManager.shared.checkAuthorization()
        }
    }
}

struct titleField: View {
    @ObservedObject var createAlbumViewModel: ModifyAlbumViewModel
    
    var body: some View {
        TextField("빈 제목", text: $createAlbumViewModel.title)
            .padding(.horizontal, 28)
            .textFieldStyle(.roundedBorder)
            .onChange(of: createAlbumViewModel.title) { newValue in
                if newValue.count > 15 {
                    createAlbumViewModel.title = String(newValue.prefix(15))
                }
            }
    }
}

struct dismissButton: View {
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            Text(text)
                .frame(maxWidth: .infinity, minHeight: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 1)
                        .stroke(.customGray2, lineWidth: 0.8)
                )
        }
    }
}

#Preview {
    ModifyAlbumView(isCreateMode: .constant(false))
}
