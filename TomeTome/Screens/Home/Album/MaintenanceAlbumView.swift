//
//  AlbumCreate.swift
//  TomeTome
//
//  Created by yeolife on 10/26/23.
//

import SwiftUI
import PhotosUI

@MainActor
struct MaintenanceAlbumView: View {
    @Binding var isCreateMode: Bool
    @StateObject var modifyAlbumViewModel = ModifyAlbumViewModel()
    
    var body: some View {
            VStack(alignment: .center, spacing: 0) {
                pickerImage(modifyAlbumViewModel: modifyAlbumViewModel)
                
                titleField(modifyAlbumViewModel: modifyAlbumViewModel)
                
                isReceiveToggle(modifyAlbumViewModel: modifyAlbumViewModel)
                
                Spacer()
                
                selectButtons(isCreateMode: $isCreateMode,
                              modifyAlbumViewModel: modifyAlbumViewModel)
            }
            .background(Color(.systemBackground))
            .frame(width: 300, height: modifyAlbumViewModel.isSendFuture ? 605 : 375)
            .cornerRadius(12)
            .shadow(radius: 40)
        }
}

struct pickerImage: View {
    @ObservedObject var modifyAlbumViewModel: ModifyAlbumViewModel
    
    var body: some View {
        PhotosPicker(selection: $modifyAlbumViewModel.imageSelection, matching: .images) {
            if let image = modifyAlbumViewModel.selectedImage {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 175)
                    .cornerRadius(12)
                    .padding(.vertical)
            }
        }
        .onAppear {
            PhotoLibraryManager.shared.checkAuthorization()
        }
    }
}

struct titleField: View {
    @ObservedObject var modifyAlbumViewModel: ModifyAlbumViewModel
    
    var body: some View {
        TextField("빈 제목", text: $modifyAlbumViewModel.title)
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal, 28)
            .onChange(of: modifyAlbumViewModel.title) { newValue in
                if newValue.count > 15 {
                    modifyAlbumViewModel.title = String(newValue.prefix(15))
                }
            }
    }
}

struct isReceiveToggle: View {
    @ObservedObject var modifyAlbumViewModel: ModifyAlbumViewModel
    
    var body: some View {
        HStack {
            Text("과거 메시지 받기")
                .fontWeight(.bold)
            Toggle("", isOn: $modifyAlbumViewModel.isSendFuture)
                .labelsHidden()
        }
        .padding(.vertical)
        
        if(modifyAlbumViewModel.isSendFuture) {
            Form {
                Section(header: Text(modifyAlbumViewModel.scheduleSelection == .cycle ? 
                                     "메시지가 주기 내로 랜덤하게 전송돼요" : "메시지가 정확한 일정마다 전송돼요")) {
                    Picker("", selection: $modifyAlbumViewModel.scheduleSelection) {
                        ForEach(ScheduleOption.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Picker("", selection: $modifyAlbumViewModel.unitSelection) {
                        ForEach(modifyAlbumViewModel.scheduleSelection.unitOption) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: modifyAlbumViewModel.unitSelection) { selection in
                        if(modifyAlbumViewModel.scheduleSelection == .cycle) {
                            modifyAlbumViewModel.randomDateCreation()
                        } else {
                            modifyAlbumViewModel.exactDateCreation()
                        }
                        
                        modifyAlbumViewModel.dateSelection = selection.dateOption.first!
                    }
                    
                    Picker("", selection: $modifyAlbumViewModel.dateSelection) {
                        ForEach(modifyAlbumViewModel.unitSelection.dateOption) { option in
                            Text("\(option.value)").tag(option)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Text("\(modifyAlbumViewModel.showDate) \(modifyAlbumViewModel.scheduleSelection == .cycle ? "이내로" : "정확한") 전송")
                        .font(.caption)
                }
            }
        }
    }
}

struct selectButtons: View {
    @Binding var isCreateMode: Bool
    @ObservedObject var modifyAlbumViewModel: ModifyAlbumViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            selectButton(text: "취소") {
                isCreateMode = false
            }
            .foregroundColor(.red)
            
            selectButton(text: "완료") {
                modifyAlbumViewModel.completeAlbumCreation()
                
                isCreateMode = false
            }
        }
    }
}

struct selectButton: View {
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
    MaintenanceAlbumView(isCreateMode: .constant(false))
}
