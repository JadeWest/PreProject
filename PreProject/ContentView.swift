//
//  ContentView.swift
//  PreProject
//
//  Created by 서현규 on 2023/03/02.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = ImageViewModel()
    
    var body: some View {
        VStack {
            ImageCell(vm: vm, uiImg: $vm.img1)
            ImageCell(vm: vm, uiImg: $vm.img2)
            ImageCell(vm: vm, uiImg: $vm.img3)
            ImageCell(vm: vm, uiImg: $vm.img4)
            ImageCell(vm: vm, uiImg: $vm.img5)
            
            Button {
                vm.img1 = nil
                vm.img2 = nil
                vm.img3 = nil
                vm.img4 = nil
                vm.img5 = nil
                Task(priority: .userInitiated) {
                    await vm.fetchAllImg()
                }
            } label: {
                Text("Load All Images")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(10)
            }
        }
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
