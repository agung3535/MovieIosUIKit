//
//  GenreMovie.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import SwiftUI

struct GenreMovie: View {
    
    var body: some View {
        ZStack {
            if #available(iOS 14.0, *) {
                Color.orange.ignoresSafeArea()
            } else {
                // Fallback on earlier versions
            }
                VStack {
                    Text("Action")
                        .foregroundColor(.white)
                }
        }
        .frame(width: 100, height: 40, alignment: .center)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        
    }
}

struct GenreMovie_Previews: PreviewProvider {
    static var previews: some View {
        GenreMovie()
    }
}
