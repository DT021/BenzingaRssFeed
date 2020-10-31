//
//  AvatarView.swift
//  BenzingaRss
//
//  Created by Jacob Myers on 10/5/20.
//

import Foundation
import SwiftUI

/// AvatarView
struct AvatarView: View {
    
    /// image
    let image: String
    
    /// size
    let size: CGFloat
    
    /// body
    var body: some View {
        Image(image)
            .resizable()    // resizable image
            .frame(width: size, height: size) // frame
            .clipShape(Circle())    // make rounded
            .overlay(Circle().stroke(Color.white.opacity(0.5), lineWidth: 5)) // create rounded border
    }
}
