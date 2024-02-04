//
//  SearchView.swift
//  AppTeamTechnical
//
//  Created by Vishvak Ravi on 2/4/24.
//

import SwiftUI
import SwiftData

struct SearchView: View {
    @Environment(\.modelContext) var modelContext
    @State var viewModel: ViewModel
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.backward")
                    .foregroundStyle(.white)
                TextField("Search", text: $viewModel.query)
                //TODO find better way to include search and barcode
//                .overlay(
//                    HStack {
//                        Image(systemName: "magnifyingglass")
//                            .foregroundColor(.gray)
//                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                            .padding(.leading, 8)
//                        Image(systemName: "barcode.viewfinder")
//                            .foregroundColor(.gray)
//                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                            .padding(.leading, 8)
//                    }
//                )
                .padding(10)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
                Image(systemName: "cart")
                    .foregroundStyle(.white)
            }
            .onChange(of: viewModel.query) { oldVal, newVal in
                Task {
                    await viewModel.getResults()
                }
            }
            HStack {
                Text("How do you want your items? | 00000")
                    .padding(.top, 15)
                    .foregroundStyle(.white)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(.blue)
        
        ScrollView {
            LazyVStack(alignment: .leading) {
                if (viewModel.query != "") {
                    VStack(alignment: .leading) {
                        Text("Results for \"\(viewModel.query)\"")
                            .font(.title2)
                            .bold()
                        + Text(" (\(viewModel.productTotal ?? 0) results)")
                            .foregroundStyle(.gray)
                        Text("Price when purchased online")
                    }
                    .padding(20)
                }
                ForEach(viewModel.productResults) { product in
                    ProductSearchResultView(modelContext: modelContext, product: product)
                        .padding(.horizontal, 20)
                    Divider()
                }
                
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
    
    return SearchView(viewModel: SearchView.ViewModel())
}
