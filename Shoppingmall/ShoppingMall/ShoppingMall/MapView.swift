//
//  MapView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 08.11.2024.
//

import SwiftUI
import WebKit

struct YandexMapView: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct MapView: View {
    private let mapURL = "https://yandex.com/maps"

    var body: some View {
        VStack(spacing: 16) {
            YandexMapView(urlString: mapURL)
                .frame(height: 300)
                .cornerRadius(10)
                .padding(.horizontal)

            Button(action: {
                if let url = URL(string: mapURL), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }) {
                Text(Constants.Text.mapViewButtonTitle)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .cornerRadius(8)
            }
            .padding(.horizontal)

            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(Color(uiColor: Constants.Colors.purple ?? .purple))
                Text(Constants.Text.mapViewAddress)
                    .foregroundColor(.black)
            }
            .padding(.bottom, 16)
        }
        .background(Color.white)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Constants.Text.menuViewMapsTitle)
    }
}

#Preview {
    MapView()
}
