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
    @State var title: String
    @State private var selectedImage: Image? = Image(systemName: "acorn")
    @State private var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            pickerImage(selectedImage: $selectedImage,
                        imageSelection: $imageSelection)
            
            titleField(text: $title)
            
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
    
    func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    selectedImage = Image(uiImage: uiImage)
                    return
                }
            }
        }
    }
}

struct pickerImage: View {
    @Binding var selectedImage: Image?
    @Binding var imageSelection: PhotosPickerItem?
    
    var body: some View {
        PhotosPicker(selection: $imageSelection, matching: .images) {
            if let image = selectedImage {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 275)
                    .background(Color.yellow)
                    .cornerRadius(12)
                    .padding(.top, 36)
            }
        }
    }
}

struct titleField: View {
    @Binding var text: String
    
    var body: some View {
        TextField("빈 제목", text: $text)
            .padding(.horizontal, 24)
            .padding(.top, 8)
            .textFieldStyle(.roundedBorder)
            .onChange(of: text) { newValue in
                if newValue.count > 15 {
                    text = String(newValue.prefix(15))
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
    CreateAlbumView(isCreateMode: .constant(true), title: "")
}
