//
//  AlbumCreate.swift
//  TomeTome
//
//  Created by yeolife on 10/26/23.
//

import SwiftUI
import PhotosUI

struct CreateAlbumView: View {
    @Binding var isCreateMode: Bool
    @StateObject var createAlbumViewModel = CreateAlbumViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            pickerImage(createAlbumViewModel: createAlbumViewModel)
            
            titleField(createAlbumViewModel: createAlbumViewModel)
            
            Spacer()
            
            HStack(alignment: .center, spacing: 0) {
                dismissButton(title: "취소") {
                    isCreateMode = false
                }
                .foregroundColor(.red)
                
                dismissButton(title: "완료") {
                    // TODO: - 데이터 DB에 저장
                    isCreateMode = false
                }
            }
        }
        .frame(width: 300, height: 455)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 40)
    }
}

struct pickerImage: View {
    @ObservedObject var createAlbumViewModel: CreateAlbumViewModel
    
    var body: some View {
        PhotosPicker(selection: $createAlbumViewModel.imageSelection, matching: .images) {
            if let image = createAlbumViewModel.selectedImage {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 275)
                    .cornerRadius(12)
                    .padding(.top, 36)
            }
        }
        .onAppear {
            PhotoLibraryManager.shared.checkAuthorization()
        }
    }
}

struct titleField: View {
    @ObservedObject var createAlbumViewModel: CreateAlbumViewModel
    
    var body: some View {
        TextField("빈 제목", text: $createAlbumViewModel.title)
            .padding(.horizontal, 24)
            .padding(.top, 8)
            .textFieldStyle(.roundedBorder)
            .onChange(of: createAlbumViewModel.title) { newValue in
                if newValue.count > 15 {
                    createAlbumViewModel.title = String(newValue.prefix(15))
                }
            }
    }
}

struct dismissButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            Text(title)
        }
        .frame(maxWidth: .infinity, minHeight: 60)
        .overlay(
            RoundedRectangle(cornerRadius: 1)
                .stroke(.customGray2, lineWidth: 0.8)
        )
    }
}

#Preview {
    CreateAlbumView(isCreateMode: .constant(false))
}
