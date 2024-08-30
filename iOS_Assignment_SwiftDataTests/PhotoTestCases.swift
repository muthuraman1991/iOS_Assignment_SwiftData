//
//  CategoryListTest.swift
//  iOS_Assignment_SwiftDataTests
//
//  Created by Muthuraman Vairavan on 29/08/24.
//

import XCTest
import SwiftData

@testable import iOS_Assignment_SwiftData

final class PhotoTestCases: XCTestCase {
    var photoAPIClient: PhotoAPIClient!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let mockNetworkService = MockNetworkManager()
        photoAPIClient = PhotoAPIClient(networkService: mockNetworkService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchAPIDataFromLocalJson() async throws {
        if let url = URL(string: URLKeys.domainName + "search?query=\("Nature")&per_page=\(Constants.maxImageToLoad)") {
            let result = try await photoAPIClient.fetchPhoto(url: url)
            switch result {
            case .success(let photoListDecodable):
                XCTAssertNotNil(photoListDecodable.photos, "Model is empty, not fetched data")
                
                XCTAssertNotNil(photoListDecodable.photos?.first?.src?["large"], "URL is Empty")
                
                XCTAssert(photoListDecodable.photos?.count == Constants.maxImageToLoad, "Photo Count not matching")
            case .failure(let error):
                throw error
            }
        }
    }
    
    //first fetch data from api and save it in db
    @MainActor func testFetchDataFromDB() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: PhotoInfoModel.self, configurations: config)

        //let categoryListView = CategoryListView(modelContext: container.mainContext)
        let viewModel = PhotoViewModel(modelContext: container.mainContext)
        
        //fetch from API
        try await viewModel.fetchPhotosFromAPI(forCategory: "Nature")
                
        //fetch from DB
        try await viewModel.fetchPhotos(forCategory: "Nature")
        
        XCTAssert(viewModel.photoListModel?.photos != nil, "Model is empty, not fetched data")
        
        XCTAssert(viewModel.photoListModel?.photos?.count == Constants.maxImageToLoad, "Photo Count not matching")
        
        XCTAssert(viewModel.photoListModel?.photos?.first?.src?["large"] != nil, "URL is Empty")
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
