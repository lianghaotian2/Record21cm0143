//
//  Stylesheet.swift
//  datepassapp
//
//  Created by cmStudent on 2023/02/17.
//

import SwiftUI

extension Image{
    func profileImageStyle() -> some View{
        self.resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 70, height: 70)
            .clipShape(Circle())
            .clipped()
            .overlay(){
                ZStack{
                    Image(systemName: "camera.fill")
                        .foregroundColor(.gray)
                        .offset(y: 22)
                        .font(.system(size: 12))
                    
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(.white, lineWidth: 3)
                }
            }
    }
}
