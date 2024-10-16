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
            }
            
            Text(product.title)
                .font(.subheadline)
            
            Text(" ")
                .font(.footnote)
            
            Text(product.price.main.price.description + " " + product.price.main.currency)
                .font(.callout)
        }
        .frame(width: UIScreen.main.bounds.width / 2.6)
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

