//
//  Alert.swift
//  TomeTome
//
//  Created by yeolife on 10/26/23.
//

import SwiftUI

struct alertItem {
    let id = UUID()
    let title: Text
    let message: Text
    let deleteButton: Alert.Button
    let cancelButton: Alert.Button
}

enum APError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
