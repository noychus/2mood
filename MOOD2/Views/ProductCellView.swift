//
//  ProductCellView.swift
//  MOOD2
//
//  Created by NOY on 15.10.2024.
//

import Foundation
import SwiftUI

struct ProductsCellView: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            if let image = product.media.first?.url {
                AsyncImage(url: URL(string: image)!)
                    .frame(width: UIScreen.main.bounds.width / 2.6, height: UIScreen.main.bounds.width / 2.1, alignment: .center)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .lineLimit(2)
                
                    .font(.subheadline)
                Text(product.variants.first?.variantOptionValues.first?.title.capitalized ?? "Белый")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundStyle(.black.opacity(0.5))
                
                Text(product.price.main.price.formattedPrice() + " " + product.price.main.currency)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
            }
            .padding(.bottom)
        }
        .frame(width: UIScreen.main.bounds.width / 2.6, height: UIScreen.main.bounds.width / 1.3)
    }
}

#Preview {
    ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 12) {
            Spacer().frame(width: 0)
            
            ProductsCellView(product: Product(id: "157031", code: "pukhovik_parka_apres_ski_belogo_tsveta", type: "product", title: "Парка Après-ski на пуху", article: "6421224032", availability: false, availabilityCount: 0, media: [.init(type: "image", title: "", url: "/upload/iblock/b8a/cfl3blzo2mkvrx153srnnmp337wduzk3.jpg", alternative: "")], price: .init(main: .init(price: 3998000, currency: "RUB", unit: "шт"), base: .init(price: 3998000, currency: "RUB", unit: "шт"), baseDiscount: .init(price: 3998000, currency: "RUB", unit: "шт"), mainDiscount: .init(price: 3998000, currency: "RUB", unit: "шт"), additional: []), categoryID: "812", categoryIDList: ["812"], nameplates: [], properties: [], variants: [], variantOptions: [], isActive: true, sort: 1))
            
            ProductsCellView(product: Product(id: "157031", code: "pukhovik_parka_apres_ski_belogo_tsveta", type: "product", title: "Парка Après-ski на пуху", article: "6421224032", availability: false, availabilityCount: 0, media: [.init(type: "image", title: "", url: "/upload/iblock/b8a/cfl3blzo2mkvrx153srnnmp337wduzk3.jpg", alternative: "")], price: .init(main: .init(price: 3998000, currency: "RUB", unit: "шт"), base: .init(price: 3998000, currency: "RUB", unit: "шт"), baseDiscount: .init(price: 3998000, currency: "RUB", unit: "шт"), mainDiscount: .init(price: 3998000, currency: "RUB", unit: "шт"), additional: []), categoryID: "812", categoryIDList: ["812"], nameplates: [], properties: [], variants: [], variantOptions: [], isActive: true, sort: 1))
            
            ProductsCellView(product: Product(id: "157031", code: "pukhovik_parka_apres_ski_belogo_tsveta", type: "product", title: "Парка Après-ski на пуху", article: "6421224032", availability: false, availabilityCount: 0, media: [.init(type: "image", title: "", url: "/upload/iblock/b8a/cfl3blzo2mkvrx153srnnmp337wduzk3.jpg", alternative: "")], price: .init(main: .init(price: 3998000, currency: "RUB", unit: "шт"), base: .init(price: 3998000, currency: "RUB", unit: "шт"), baseDiscount: .init(price: 3998000, currency: "RUB", unit: "шт"), mainDiscount: .init(price: 3998000, currency: "RUB", unit: "шт"), additional: []), categoryID: "812", categoryIDList: ["812"], nameplates: [], properties: [], variants: [], variantOptions: [], isActive: true, sort: 1))
            
            Spacer().frame(width: 0)
        }
    }
}

