//
//  PhotoCategoryView.swift
//  iOS_Assignment
//
//  Created by Muthuraman Vairavan on 28/08/24.
//

import SwiftUI
import SwiftData

struct CategoryListView: View {
    @StateObject private var viewModel: PhotoViewModel
    @State private var path = NavigationPath()
    @State private var isAlertShown = false
    
    init(modelContext: ModelContext?) {
        _viewModel = StateObject(wrappedValue: PhotoViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        NavigationStack(path: $path){
            List {
                ForEach(viewModel.categories, id: \.self) { item in
                    listItem(item: item)
                }
            }
            .alert(isPresented: $isAlertShown) {
                Alert(title: Text("Sorry!!! Something went worng, Please try again later"))
            }
            .navigationDestination(for: String.self) { path in
                if path == "Detailed View" {
                    PhotoListView(photos: viewModel.photoListModel?.photos)
                }
            }
        }
    }
    
    private func listItem(item: String) -> some View {
        Button {
            Task {
                viewModel.selectedCategories = item
                do {
                    try await viewModel.fetchPhotos(forCategory: item)
                    path.append("Detailed View")
                } catch {
                    print("error ==== \(error)")
                    isAlertShown = true
                }
            }
        } label: {
            rowView(textString: item)
        }
    }
}

struct rowView: View {
    var textString: String
    
    var body: some View {
        HStack {
            Text(textString)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.body)
                .foregroundColor(Color(UIColor.tertiaryLabel))
        }
    }
}

extension CategoryListView {
    func getViewModel() -> PhotoViewModel {
        return self.viewModel
    }
}

#Preview {
    CategoryListView(modelContext: nil)
}
