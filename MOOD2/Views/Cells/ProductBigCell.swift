//
//  ProductBigCell.swift
//  MOOD2
//
//  Created by NOY on 17.10.2024.
//

import SwiftUI

struct ProductBigCell: View {
    
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            if let image = product.media.first?.url {
                AsyncImage(url: URL(string: image)!)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 1.25, alignment: .center)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .lineLimit(2)
                
                Text(product.variants.first?.variantOptionValues.first?.title.capitalized ?? "Белый")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundStyle(.black.opacity(0.5))
                
                Text(product.price.main.price.formattedPrice() + " " + "₽")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
        }
    }
}

#Preview {
    ProductBigCell(product: Product(id: "157031", code: "pukhovik_parka_apres_ski_belogo_tsveta", type: "product", title: "Парка Après-ski на пуху", article: "6421224032", availability: false, availabilityCount: 0, media: [.init(type: "image", title: "", url: "/upload/iblock/b8a/cfl3blzo2mkvrx153srnnmp337wduzk3.jpg", alternative: "")], price: .init(main: .init(price: 3998000, currency: "RUB", unit: "шт"), base: .init(price: 3998000, currency: "RUB", unit: "шт"), baseDiscount: .init(price: 3998000, currency: "RUB", unit: "шт"), mainDiscount: .init(price: 3998000, currency: "RUB", unit: "шт"), additional: []), categoryID: "812", categoryIDList: ["812"], nameplates: [], properties: [], variants: [], variantOptions: [], isActive: true, sort: 1))
}
