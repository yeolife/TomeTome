//
//  CustomNavigationBar.swift
//  TomeTome
//
//  Created by yeolife on 11/5/23.
//

import SwiftUI

enum NaviButtonType: String {
    case create = "추가"
    case edit = "편집"
    case delete = "삭제"
    case complete = "완료"
}

struct CustomNavBarContainerView<Content: View>: View {
    let content: Content
    let customNavigationBar: CustomNavBar
    
    init(@ViewBuilder content: () -> Content, customNavigationBar: CustomNavBar) {
        self.content = content()
        self.customNavigationBar = customNavigationBar
    }

    var body: some View {
        VStack(spacing: 0) {
            customNavigationBar
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct CustomNavBar: View {
    let isDisplayLeftButton: Bool
    let isDisplaySearchButton: Bool
    let isDisplayRightButton: Bool
    var rightButtonType: NaviButtonType
    let isTappedLeftButton: () -> Void
    let isTappedSearchButton: () -> Void
    let isTappedRightButton: () -> Void
    
    var body: some View {
        HStack {
            if(isDisplayLeftButton) {
                Button {
                    isTappedLeftButton()
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            if(isDisplaySearchButton) {
                Button {
                    isTappedSearchButton()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.black)
                }
            }
            
            if(isDisplayRightButton) {
                Button {
                    isTappedRightButton()
                } label: {
                    Text(rightButtonType.rawValue)
                        .foregroundStyle(.black)
                        .frame(width: 30, height: 30)
                }
                .padding(.leading, 10)
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 30)
    }
}

#Preview {
    CustomNavBar(isDisplayLeftButton: true,
                            isDisplaySearchButton: true,
                            isDisplayRightButton: true,
                            rightButtonType: .edit,
                            isTappedLeftButton: {},
                            isTappedSearchButton: {},
                            isTappedRightButton: {})
}
