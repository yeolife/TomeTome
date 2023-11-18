//
//  CreateAlbumViewModel.swift
//  TomeTome
//
//  Created by yeolife on 11/8/23.
//

import SwiftUI
import PhotosUI

@MainActor
final class MaintenanceAlbumViewModel: ObservableObject {
    @Published var title: String = ""
    
    @Published var isSendFuture: Bool = false
    @Published var scheduleSelection: ScheduleOption = .cycle
    @Published var unitSelection: UnitOption = .time
    @Published var dateSelection: DateOption = .timeUnit_1 {
        didSet {
            exactDateCreation()
            
            if(scheduleSelection == .cycle) {
                randomDateCreation()
            }
        }
    }
    @Published var saveDate: String = Date().formattedDate
    @Published var showDate: String = Date().formattedDate
    
    @Published private(set) var selectedImage: Image? = Image("selectImage")
    @Published var imageSelection: PhotosPickerItem? = nil {
        willSet {
            setImage(from: imageSelection)
        }
    } 
}

// MARK: - 날짜 관련
extension MaintenanceAlbumViewModel {
    func exactDateCreation() {
        let now = Date()
        var dateComponents = DateComponents()
        
        if(unitSelection == .time) {
            dateComponents.hour = dateSelection.value
        } else if(unitSelection == .day) {
            dateComponents.day = dateSelection.value
        } else if(unitSelection == .week) {
            dateComponents.weekOfMonth = dateSelection.value
        } else if(unitSelection == .month) {
            dateComponents.month = dateSelection.value
        } else if(unitSelection == .year) {
            dateComponents.year = dateSelection.value
        }

        let calendar = Calendar.current
        if let futureDate = calendar.date(byAdding: dateComponents, to: now) {
            // 상황에 따라 sendDate에 값이 안들어가게 해야함
            showDate = futureDate.formattedDate
            
            if(scheduleSelection == .schedule) {
                saveDate = futureDate.formattedDate
            }
        }
    }
    
    func randomDateCreation() {
        let now = Date()
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        
        var addTime: Int = 0
        var addDay: Int = 0
        
        if let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: now) {
            let secondsUntilEndOfDay = endOfDay.timeIntervalSince(now)
            addTime = Int(secondsUntilEndOfDay / 60)
        }

        if(unitSelection == .time) {
            addTime = dateSelection.value * 60
        }
        else if(unitSelection == .day && dateSelection.value == 1) {
            addTime = 1440
        } else {
            if(unitSelection == .day) {
                addDay = dateSelection.value
            } else if(unitSelection == .week) {
                addDay = dateSelection.value * 7
            } else if(unitSelection == .month) {
                addDay = dateSelection.value * (calendar.range(of: .day, in: .month, for: now)?.count ?? 31)
            } else if(unitSelection == .year) {
                addDay = dateSelection.value * (calendar.range(of: .day, in: .year, for: now)?.count ?? 365)
            }
            
            dateComponents.day = Int.random(in: 1...addDay)
        }
                
        dateComponents.minute = Int.random(in: 1...addTime)
        
        if let futureDate = calendar.date(byAdding: dateComponents, to: now) {
            saveDate = futureDate.formattedDate
        }
    }
}

// MARK: - 앨범 관련
extension MaintenanceAlbumViewModel {
    // 사진 가져오기
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
