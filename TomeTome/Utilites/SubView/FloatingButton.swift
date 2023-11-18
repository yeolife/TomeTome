//
//  floatingButton.swift
//  TomeTome
//
//  Created by yeolife on 10/26/23.
//

import SwiftUI

struct FloatingButton: View {
    let action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    withAnimation {
                        action()
                    }
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.accent)
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 20))
    }
}

#Preview {
    FloatingButton(action: { })
}
