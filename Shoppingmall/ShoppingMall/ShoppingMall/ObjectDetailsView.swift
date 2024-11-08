//
//  ObjectDetailView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 23.09.2024.
//

import SwiftUI

struct DetailsInfoDTO {
    let title: String
    let description: String
    let coverImageSource: URL?
    let locationTitle: String
    let siteName: String?
    let siteAddress: URL?
}

protocol DetailsViewModel: ObservableObject {
    var details: DetailsInfoDTO? { get }
}

protocol PromotionViewModel: ObservableObject {
    var promotions: HomeSectionDTO? { get }
}

struct DetailsView<ViewModel: DetailsViewModel, PromotionVM: PromotionViewModel>: View {
    @ObservedObject private var viewModel: ViewModel
    @ObservedObject private var promotionViewModel: PromotionVM
    
    init(viewModel: ViewModel, promotionViewModel: PromotionVM) {
        self.viewModel = viewModel
        self.promotionViewModel = promotionViewModel
    }
    
    var body: some View {
        if let details = viewModel.details {
            ScrollView {
                VStack {
                    ObjectCardView(details: details)
                    if let promotions = promotionViewModel.promotions {
                        if !promotions.items.isEmpty {
                            HomeSection(section: promotions) {
                                HomeCard(item: $0)
                                    .frame(height: promotions.itemHeight)
                            }
                            .padding(.bottom)
                        }
                            
                            Divider()
                                .padding(.horizontal)
                            
                            Text(details.description.htmlToPlainText)
                                .padding()
                    }
                }
            }
            .navigationTitle(details.title)
        }
    }
}

struct ObjectCardView: View {
    let details: DetailsInfoDTO
    
    var body: some View {
        VStack {
            if details.title.isEmpty {
                NoDataView(text: Constants.Text.newsViewNoDataRepeatLater)
            } else {
                AsyncImage(url: details.coverImageSource) { image in
                    image.resizable()
                } placeholder: {
                    Rectangle()
                        .fill(Color(red: 0.98, green: 0.98, blue: 0.95))
                }
                .aspectRatio(CGSize(width: 2, height: 1), contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .frame(maxWidth: 512)
                .padding()
                
                HStack {
                    Text("\(details.locationTitle) " + Constants.Text.objectDetailsViewFloor)
                    Spacer()
                    Button(action: {
                        if let siteAddress = details.siteAddress {
                            UIApplication.shared.open(siteAddress)
                        }
                    }, label: {
                        Text(details.siteName ?? "")
                    })
                    
                }
                .padding()
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    DetailsView(
        viewModel: MockDetailsViewModel(), promotionViewModel:  MockDetailsViewModel()
    )
}

class MockDetailsViewModel: DetailsViewModel, PromotionViewModel {
    @Published private(set) var details: DetailsInfoDTO?
    @Published private(set) var promotions: HomeSectionDTO?
    
    init() {
        self.details = .init(
            title: "Nike",
            description: "Почти вся продукция Nike производится сторонними компаниями-подрядчиками вне территории США (в основном в Азии), сама компания является правообладателем торговых марок, разрабатывает дизайн продукции и владеет сетью магазинов (около 1150 по всему миру), а также торговых центров NikeTown",
            coverImageSource: URL(string: "https://www.magfarah.com/wp-content/uploads/2022/10/Key-elements-in-the-marketing-strategy-of-Nike.jpg")!,
            locationTitle: "1-й этаж",
            siteName: "nike.org",
            siteAddress: URL(string: "https://nike.com/")!
        )
        
        self.promotions = .init(
            title: "Предложения за баллы",
            size: .small,
            items: [
                HomeItemDTO(
                    title: "Black Friday",
                    description: "скидки до 70%",
                    backgroundColor: Color.black,
                    coverImageSource: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRP5Yk-9uapAB-NMnkxTdTcJQZn0S5PfScR5RV33XLXpGtlbQ0bmaxH8Wgw2OYFZel6MtA&usqp=CAU")!,
                    brightness: .dark
                ),
                HomeItemDTO(
                    title: "Зимняя распродажа",
                    description: "скидки до 25%",
                    backgroundColor: Color.gray,
                    coverImageSource: URL(string: "https://avatars.mds.yandex.net/i?id=af2bb360823154405977499f38548b99_sr-12495681-images-thumbs&n=13")!,
                    brightness: .dark
                )
            ], destinationView: .offers)
    }
}


//import SwiftUI
//
//struct ObjectData: Identifiable, Decodable {
//    let id: UUID
//    let name: String
//    let logo_url: String
//    let site_url: String
////    let sitemap: String
//    let floor: Int
//    let description: String
//}
//
//struct OffersForPointsData: Identifiable, Decodable {
//    let id: String
//    let title: String
//    let disclaimer: String?
//    let logo_url: String?
//    let content: String
//    
//    func toCard() -> CardData2 {
//        return CardData2(title: title, subtitle: disclaimer, imageUrl: logo_url, backgroundColor: Color(uiColor: Constants.Colors.purple ?? .purple))
//    }
//}
//
//struct CardData2: Identifiable {
//    let id = UUID()
//    let title: String
//    let subtitle: String?
//    let imageUrl: String?
//    let backgroundColor: Color
//}
//
//struct ObjectDetailView: View { 
//    @EnvironmentObject var router: Router
//    let shopId: UUID
//    let title: String
//    @State private var isLoading: Bool = true
//    @State private var objectData: ObjectData?
//    @State private var offersForPoints: [OffersForPointsData] = []
//    @State private var plainTextDescription: String = ""
//    
//    var body: some View {
//        ScrollView {
//            VStack {
//                if let objectData = objectData {
//                    if let logoURL = URL(string: objectData.logo_url) {
//                        AsyncImage(url: logoURL) { phase in
//                            switch phase {
//                            case .empty:
//                                ProgressView()
//                                    .frame(width: 312, height: 240)
//                            case .success(let image):
//                                image
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 312, height: 240)
//                                    .clipShape(RoundedRectangle(cornerRadius: 12))
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 12)
//                                            .stroke(Color.gray, lineWidth: 1)
//                                    )
//                            case .failure(_):
//                                Image(uiImage: UIImage.image)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 312, height: 240)
//                                    .clipShape(RoundedRectangle(cornerRadius: 12))
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 12)
//                                            .stroke(Color.gray, lineWidth: 1)
//                                    )
//                            @unknown default:
//                                EmptyView()
//                            }
//                        }
//                    } else {
//                        Image(uiImage: UIImage.image)
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 312, height: 240)
//                            .clipShape(RoundedRectangle(cornerRadius: 12))
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 12)
//                                    .stroke(Color.gray, lineWidth: 1)
//                            )
//                    }
//                    HStack {
//                        Text("\(objectData.floor) этаж")
//                        Text(objectData.site_url)
//                    }
//                    
//                    Button(action: {
////                        print(objectData.sitemap)
//                    }, label: {
//                        Text("Расположение в ТРЦ")
//                            .multilineTextAlignment(.center)
//                        Image(uiImage: UIImage.iconsLocation)
//                            .renderingMode(.template)
//                            .foregroundColor(.white)
//                            .frame(width: 18, height: 18)
//                        
//                    })
//                    .buttonStyle(.borderedProminent)
//                    .frame(width: 312)
//                    .background(Color.accentColor)
//                    .cornerRadius(8)
//                    if !offersForPoints.isEmpty {
//                        OffersView(title: "Предложения за баллы", offers: offersForPoints, frameWidth: 227, frameHeight: 127, onSeeAllTap: {})
//                    }
//                    Divider()
//                        .frame(height: 4)
//                        .background(Color.gray.opacity(0.1))
//                        .padding(.horizontal, 25)
//                        .padding()
//                        
//                    Text(plainTextDescription)
//                        .padding(.horizontal, 30)
//                } else {
//                    VStack {
//                        Text("Упс.. \n\nНет данных для отображения")
//                            .multilineTextAlignment(.center)
//                            .foregroundColor(.gray)
//                            .padding(.horizontal, 16)
//                            .font(.system(size: 18))
//                        Image(uiImage: UIImage.noResults)
//                            .resizable()
//                            .frame(width: 294, height: 294, alignment: .center)
//                            .padding(.top, 20)
//                    }
//                }
//            }
//            .padding(.top, 40)
//            .onAppear {
//                Task {
//                    await fetchShopData()
//                    await fetctOffersForPointsData()
//                }
//            }
//            .navigationTitle(title)
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarBackButtonHidden(true)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: {
//                        router.navigateBack(in: .catalog)
//                    }) {
//                        Image(uiImage: UIImage.iconsBack)
//                            .padding(.leading, 32)
//                    }
//                }
//            }
//        }
//    }
//    
//    
//    private func fetchShopData() async {
//        let urlString = "https://skillbox.dev.instadev.net/api/v1/shops/\(shopId)"
//        guard let url = URL(string: urlString) else { return }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(for: request)
//            
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Object JSON: \(jsonString)")
//            }
//            
//            if let decodedResponse = try? JSONDecoder().decode(ObjectData.self, from: data) {
//                DispatchQueue.main.async {
//                    self.objectData = decodedResponse
//                    self.plainTextDescription = decodedResponse.description.htmlToPlainText
//                    self.isLoading = false
//                }
//            }
//        } catch {
//            DispatchQueue.main.async {
//                self.isLoading = false
//            }
//        }
//    }
//    
//    private func fetctOffersForPointsData() async {
//        let urlString = "https://skillbox.dev.instadev.net/api/v1/shops/\(shopId)/promotions"
//        guard let url = URL(string: urlString) else { return }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(for: request)
//            
//            //            if let jsonString = String(data: data, encoding: .utf8) {
//            //                print("Offers JSON: \(jsonString)")
//            //            }
//            
//            if let decodedResponse = try? JSONDecoder().decode([OffersForPointsData].self, from: data) {
//                DispatchQueue.main.async {
//                    self.offersForPoints = decodedResponse
//                    self.isLoading = false
//                }
//            }
//        } catch {
//            DispatchQueue.main.async {
//                self.isLoading = false
//            }
//        }
//    }
//}
//
//struct OffersView: View {
//    let title: String
//    let offers: [OffersForPointsData]
//    let frameWidth: CGFloat
//    let frameHeight: CGFloat
//    let onSeeAllTap: () -> Void
//    
//    
//    var body: some View {
//        HStack {
//            Text(title)
//                .font(.title3)
//            Spacer()
//            Button(action: onSeeAllTap) {
//                Text(Constants.Text.homeViewTextAllButton)
//                    .foregroundColor(.blue)
//            }
//        }
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 16) {
//                ForEach(offers) { offer in
//                    ZStack {
//                        if let url = URL(string: offer.logo_url ?? "") {
//                            AsyncImage(url: url) { image in
//                                image
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .clipped()
//                            } placeholder: {
//                                RoundedRectangle(cornerRadius: 12)
//                                    .fill(Color(Constants.Colors.coral!))
//                            }
//                        }
//                        VStack(alignment: .leading) {
//                            Spacer()
//                            Text(offer.title)
//                                .font(.headline)
//                                .foregroundColor(.white)
//                                .padding(.bottom, 15)
//                            if let subtitle = offer.disclaimer {
//                                Text(subtitle)
//                                    .font(.subheadline)
//                                    .foregroundColor(.white)
//                                    .padding(.bottom, 10)
//                            }
//                        }
//                    }
//                    .frame(width: frameWidth, height: frameHeight)
//                    .clipShape(RoundedRectangle(cornerRadius: 12))
//                }
//            }
//        }
//       
//    }
//}
//
extension String {
    var htmlToPlainText: String {
        guard let data = self.data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else { return self }
        return attributedString.string
    }
}
