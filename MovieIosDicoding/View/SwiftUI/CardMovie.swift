//
//  CardMovie.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import SwiftUI

struct CardMovie: View {
    var body: some View {
        ZStack {
            if #available(iOS 14.0, *) {
                Color.white.ignoresSafeArea()
            } else {
                // Fallback on earlier versions
            }
            VStack(alignment:.leading) {
                Image("harrypotterposter")
                    .resizable()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300, alignment: .center)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Text("Harry Potter")
                    .fontWeight(.bold)
                    .padding(EdgeInsets.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 20, alignment: .leading)
                Spacer()
            }
        }
        
    }
}

struct CardMovie_Previews: PreviewProvider {
    static var previews: some View {
        CardMovie()
    }
}
