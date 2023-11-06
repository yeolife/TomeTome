//
//  PhotoPermission.swift
//  TomeTome
//
//  Created by yeolife on 11/7/23.
//

import Foundation
import Photos

class PhotoPermissionManager : ObservableObject {
    @Published var permissionGranted = false
    
    func checkAuthorization() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("접근 허가된 상태")
        case .denied:
            print("접근 불허된 상태")
        case .notDetermined:
            print("아직 응답하지 않은 상태")
            PHPhotoLibrary.requestAuthorization({ status in
                switch status {
                case .authorized:
                    print("사용자가 접근을 허용함")
                    
                case .denied:
                    print("사용자가 접근을 불허함")
                default:
                    break
                }
            })
        case .restricted:
            print("접근 제한")
        default: break
        }
    }
}
