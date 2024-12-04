//
//  FetchnFeastTests.swift
//  FetchnFeastTests
//
//  Created by David Nguyen on 12/3/24.
//

//import XCTest
//@testable import FetchnFeast
//
//final class FetchnFeastTests: XCTestCase {
//    
//    // MARK: - Recipe Model Tests
//    
//    func testRecipeModelDecoding() throws {
//        let json = """
//        {
//            "uuid": "1234",
//            "name": "Chicken Curry",
//            "cuisine": "Indian",
//            "photo_url_small": "https://example.com/small.jpg",
//            "photo_url_large": "https://example.com/large.jpg",
//            "source_url": "https://example.com/recipe",
//            "youtube_url": "https://youtube.com/watch?v=1234"
//        }
//        """.data(using: .utf8)!
//        
//        let recipe = try JSONDecoder().decode(Recipe.self, from: json)
//        
//        XCTAssertEqual(recipe.uuid, "1234")
//        XCTAssertEqual(recipe.name, "Chicken Curry")
//        XCTAssertEqual(recipe.cuisine, "Indian")
//        XCTAssertEqual(recipe.photo_url_small, "https://example.com/small.jpg")
//        XCTAssertEqual(recipe.photo_url_large, "https://example.com/large.jpg")
//        XCTAssertEqual(recipe.source_url, "https://example.com/recipe")
//        XCTAssertEqual(recipe.youtube_url, "https://youtube.com/watch?v=1234")
//    }
//    
//    // MARK: - NetworkManager Tests
//    
//    func testNetworkManagerFetchRecipesSuccess() async throws {
//        // Mock Network Response
//        let mockJSON = """
//        {
//            "recipes": [
//                {
//                    "uuid": "abcd",
//                    "name": "Fried Calamari",
//                    "cuisine": "Asian",
//                    "photo_url_small": "",
//                    "photo_url_large": "",
//                    "source_url": "",
//                    "youtube_url": ""
//                }
//            ]
//        }
//        """.data(using: .utf8)!
//        
//        let mockSession = URLSessionMock(data: mockJSON, response: HTTPURLResponse(url: URL(string: "https://example.com")!,
//                                                                                   statusCode: 200,
//                                                                                   httpVersion: nil,
//                                                                                   headerFields: nil),
//                                         error: nil)
//        NetworkManager.shared.session = mockSession
//        
//        let recipes = try await NetworkManager.shared.getRecipes()
//        
//        XCTAssertEqual(recipes.count, 1)
//        XCTAssertEqual(recipes.first?.name, "Fried Calamari")
//    }
//    
//    func testNetworkManagerFetchRecipesInvalidData() async throws {
//        // Mock Invalid JSON
//        let invalidJSON = "Invalid Data".data(using: .utf8)!
//        let mockSession = URLSessionMock(data: invalidJSON, response: HTTPURLResponse(url: URL(string: "https://example.com")!,
//                                                                                      statusCode: 200,
//                                                                                      httpVersion: nil,
//                                                                                      headerFields: nil),
//                                         error: nil)
//        NetworkManager.shared.session = mockSession
//        
//        do {
//            _ = try await NetworkManager.shared.getRecipes()
//            XCTFail("Expected to throw FFError.invalidData")
//        } catch let error as FFError {
//            XCTAssertEqual(error, .invalidData)
//        } catch {
//            XCTFail("Unexpected error type")
//        }
//    }
//    
//    // MARK: - ViewModel Tests
//    
//    func testRecipeListViewModelFetchRecipesSuccess() async throws {
//        let mockRecipes = [
//            MockData.mockRecipe
//        ]
//        
//        let mockNetworkManager = NetworkManagerMock(mockRecipes: mockRecipes)
//        let viewModel = RecipeListViewModel(networkManager: mockNetworkManager)
//        
//        await viewModel.getRecipes()
//        
//        XCTAssertEqual(viewModel.recipes.count, 1)
//        XCTAssertEqual(viewModel.recipes.first?.name, MockData.mockRecipe.name)
//        XCTAssertFalse(viewModel.isLoading)
//    }
//    
//    func testRecipeListViewModelFetchRecipesFailure() async throws {
//        let mockNetworkManager = NetworkManagerMock(shouldThrowError: true)
//        let viewModel = RecipeListViewModel(networkManager: mockNetworkManager)
//        
//        await viewModel.getRecipes()
//        
//        XCTAssertTrue(viewModel.recipes.isEmpty)
//        XCTAssertNotNil(viewModel.alertItem)
//    }
//}
//
//// MARK: - Mock Network Manager
//
//final class NetworkManagerMock: NetworkManaging {
//    var mockRecipes: [Recipe] = []
//    var shouldThrowError = false
//    
//    init(mockRecipes: [Recipe] = [], shouldThrowError: Bool = false) {
//        self.mockRecipes = mockRecipes
//        self.shouldThrowError = shouldThrowError
//    }
//    
//    func getRecipes() async throws -> [Recipe] {
//        if shouldThrowError {
//            throw FFError.invalidData
//        }
//        return mockRecipes
//    }
//}
//
//// MARK: - Mock URLSession
//
//final class URLSessionMock: URLSessionProtocol {
//    private let data: Data?
//    private let response: URLResponse?
//    private let error: Error?
//
//    init(data: Data?, response: URLResponse?, error: Error?) {
//        self.data = data
//        self.response = response
//        self.error = error
//    }
//
//    func data(from url: URL) async throws -> (Data, URLResponse) {
//        if let error = error {
//            throw error
//        }
//        return (data ?? Data(), response ?? URLResponse())
//    }
//}
