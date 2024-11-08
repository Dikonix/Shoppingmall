//
//  CatalogDetailView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 23.09.2024.
//

import SwiftUI

struct CategoryItemDTO: Hashable, Identifiable {
    let id: UUID
    let title: String
    let image: URL?
}

protocol CategoryViewModel: ObservableObject {
    var title: String { get }
    var items: [CategoryItemDTO] { get }
    func getCategoryDetails()
}

struct CatalogDetailView<ViewModel : CategoryViewModel>: View {
    @ObservedObject private var viewModel: ViewModel
    @State private var searchText: String = ""
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            HStack {
                Image(uiImage: UIImage.iconsSearch)
                TextField(Constants.Text.catalogDetailViewSearch, text: $searchText)
                    .foregroundColor(.gray)
                    .opacity(0.4)
            }
            .padding(10)
            .frame(height: 32)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding([.horizontal, .top], 28)
            
            ScrollView {
                if filteredData.isEmpty {
                    NoDataView(text: Constants.Text.catalogDetailViewNoData)
                } else {
                    ForEach(filteredData, id: \.self) { item in
                        NavigationLink(value: item) {
                            CategoryItem(item: item)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .refreshable {
                viewModel.getCategoryDetails()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.title)
    }
    
    private var filteredData: [CategoryItemDTO] {
        if searchText.isEmpty {
            return viewModel.items
        } else {
            return viewModel.items.filter { data in
                data.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

private struct CategoryItem: View {
    let item: CategoryItemDTO
    
    var body: some View {
        HStack {
            AsyncImage(url: item.image) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 42, height: 42)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 42, height: 42)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                        )
                case .failure(_):
                    Image(uiImage: UIImage.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 42, height: 42)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                        )
                @unknown default:
                    EmptyView()
                }
            }
            
            Text(item.title)
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 24)
    }
}

#Preview {
    NavigationStack {
        CatalogDetailView(viewModel: MockCategoryViewModel())
    }
}

class MockCategoryViewModel: CategoryViewModel {
    let title: String = "Магазины"
    @Published private(set) var items: [CategoryItemDTO] = []
    
    init() {
        getCategoryDetails()
    }
    
    func getCategoryDetails() {
        self.items = [
            CategoryItemDTO(
                id: UUID(),
                title: "ZARA",
                image: URL(string: "https://static.wikia.nocookie.net/star-and-the-forces-of-evil/images/3/3b/Star_Butterfly_S3_profile.png/revision/latest?cb=20240107212937")
            ),
            CategoryItemDTO(
                id: UUID(),
                title: "Adidas",
                image: URL(string: "https://static.wikia.nocookie.net/star-and-the-forces-of-evil/images/7/7b/Pre-teen_Star.jpg/revision/latest?cb=20201225002436")
            ),
            CategoryItemDTO(
                id: UUID(),
                title: "Nike",
                image: URL(string: "https://static.wikia.nocookie.net/star-and-the-forces-of-evil/images/3/3b/Star_Butterfly_S3_profile.png/revision/latest?cb=20240107212937")
            ),
            CategoryItemDTO(
                id: UUID(),
                title: "Puma",
                image: URL(string: "https://static.wikia.nocookie.net/star-and-the-forces-of-evil/images/7/7b/Pre-teen_Star.jpg/revision/latest?cb=20201225002436")
            )
        ]
    }
    
}
