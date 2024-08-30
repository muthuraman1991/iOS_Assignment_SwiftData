//
//  PhotoListView.swift
//  iOS_Assignment
//
//  Created by Muthuraman Vairavan on 28/08/24.
//

import SwiftUI

struct PhotoListView: View {
    var photos: [PhotoInfoDecodable]?
    
    var body: some View {
        VStack(spacing: .zero) {
            loadList
        }
        .redacted(reason: photos == nil ? .placeholder : [])
    }
    
    @ViewBuilder
    private var loadList: some View {
        if let photos {
            List {
                ForEach(0...(Constants.maxImageToLoad-1), id: \.self) { index in
                    let photourl = photos[index].src?["large"]
                    loadImageInAsync(photourl: photourl, index: index)
                }.listRowSeparator(.hidden, edges: .all)
            }
        }
    }
    
    private func loadImageInAsync(photourl: String?, index: Int) -> some View {
            VStack(alignment: .center, spacing: 16) {
                AsyncImage(url: URL(string: photourl ?? "")) { phase in
                    if let image = phase.image {
                        image.resizable()
                    } else if phase.error != nil {
                        Text("No Image Available")
                    } else {
                        Image(systemName: "photo.fill")
                    }
                }
                .frame(width: 350, height: 350)
                .aspectRatio(contentMode: .fit)
                .padding(.top, 16)
                Text("\(index+1)")
            }
    }
}

#Preview {
    PhotoListView()
}
