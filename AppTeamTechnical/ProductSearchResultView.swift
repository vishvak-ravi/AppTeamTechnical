//
//  ProductSearchResultView.swift
//  AppTeamTechnical
//
//  Created by Vishvak Ravi on 2/4/24.
//

import SwiftData
import SwiftUI

struct ProductSearchResultView : View {
    let modelContext: ModelContext
    let product: ProductModel
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            AsyncImage(url: product.thumbnailURL,
                       content: { image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: 180)
            },
                       placeholder:  {
                ProgressView()
            })
            .overlay(alignment: .topTrailing) {
                Button {
                    modelContext.insert(product)
                    product.favorite.toggle()
                } label: {
                    Image(systemName: product.favorite ? "heart.fill" : "heart")
                        .padding(10)
                        .background(.white)
                        .foregroundStyle(product.favorite ? .pink : .black)
                        .clipShape(.circle)
                }
                .offset(CGSize(width: 10.0, height: -10.0))
                
            }
            VStack (alignment: .leading){
                if (product.newPrice < product.price) {
                    Group {
                        Text("Now $\(String(format: "%.2f", product.newPrice)) ")
                            
                            .bold()
                            .foregroundStyle(.green)
                        + Text("$\(String(format: "%.2f", product.price))")
                            .font(.subheadline)
                            .strikethrough()
                            .foregroundStyle(.gray)
                    }
                }
                else {
                    Text("$\(product.price)")
                        .font(.title3)
                        .bold()
                }
                Text(product.title)
                    .padding(.vertical, 3)
                    .foregroundStyle(.gray)
                HStack {
                    RatingView(rating: Int(product.rating))
                    Text("\(000)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                .padding(.vertical, 3)
                Group {
                    Text("Save with W+")
                        .bold()
                        .foregroundStyle(.blue)
                        .padding(.vertical, 3)
                    Text("Free shipping, arrives ")
                        .foregroundStyle(.gray)
                    + Text("in 2 days")
                        .bold()
                        .foregroundStyle(Color.gray)
                }
                .font(.caption)
                
                Button {
                    modelContext.insert(product) //TODO: need to prevent attempts at re-insertion
                    product.quantityInCart += 1
                } label: {
                    Text("Add to cart")
                        .font(.caption)
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.horizontal, 60)
                        .padding(.vertical, 10)
                }
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding(.top, 10)
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(for: ProductModel.self, isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ProductModel.self, configurations: config)
    let context = ModelContext(container)
    
    let pavilion = ProductModel(product: .hpPavilion)
    
    context.insert(pavilion)
    
    return ProductSearchResultView(modelContext: context, product: pavilion)
}
