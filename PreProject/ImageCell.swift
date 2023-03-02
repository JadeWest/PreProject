//
//  ImageCell.swift
//  PreProject
//
//  Created by 서현규 on 2023/03/02.
//

import SwiftUI

class ImageViewModel: ObservableObject {
    
    @Published var img1: UIImage? = UIImage(systemName: "photo")
    @Published var img2: UIImage? = UIImage(systemName: "photo")
    @Published var img3: UIImage? = UIImage(systemName: "photo")
    @Published var img4: UIImage? = UIImage(systemName: "photo")
    @Published var img5: UIImage? = UIImage(systemName: "photo")
    
    init() {
        
    }
    
    func fetchImg() async -> UIImage? {
        do {
            if let url = URL(string: "https://picsum.photos/200") {
                let (d, _) = try await URLSession.shared.data(from: url)
                let img = UIImage(data: d)
                return img
            }
        } catch {
            print("error: \(error.localizedDescription)")
        }
        return UIImage(systemName: "photo")
    }
    
    func fetchAllImg() async {
        await MainActor.run(body: {
            Task {
                img1 = await fetchImg()
                img2 = await fetchImg()
                img3 = await fetchImg()
                img4 = await fetchImg()
                img5 = await fetchImg()
            }
        })
    }
}

struct ImageCell: View {
    
    @ObservedObject var vm: ImageViewModel
    @Binding var uiImg: UIImage?
    
    var body: some View {
        HStack {
            if let uiImg = uiImg {
                Image(uiImage: uiImg)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 50)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 50)
            }
                
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .frame(width: 200, height: 10)
                        .foregroundColor(.gray)
                    
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .frame(width: 100, height: 10)
                        .foregroundColor(.blue)
                }
                
                Button {
                    self.uiImg = UIImage(systemName: "photo")
                    Task {
                        self.uiImg = await vm.fetchImg()
                    }
                } label: {
                    Text("Load")
                        .frame(width: 150, height: 75)
                        .foregroundColor(.white)
                        .font(.headline)
                        .background(.blue)
                        .cornerRadius(10)
                }
            }
        }
    }

//struct ImageCell_Previews: PreviewProvider {
//
//    static var previews: some View {
//        ImageCell()
//    }
//}
