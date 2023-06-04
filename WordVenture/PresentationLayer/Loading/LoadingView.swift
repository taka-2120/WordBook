//
//  LoadingView.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/25/23.
//

import SwiftUI
import GIFImage

struct LoadingView: View {
    
    @ObservedObject private var controller = LoadingController()
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            GIFImage(source: .local(filePath: controller.launchAnimationPath), loop: .constant(false)) { _ in
                await controller.load()
            }
        }
        .alert("error", isPresented: $controller.isErrorShown) {
            Text("OK")
        } message: {
            Text(controller.errorMessage)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
