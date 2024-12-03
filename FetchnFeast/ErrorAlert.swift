//
//  ErrorAlert.swift
//  FetchnFeast
//
//  Created by David Nguyen on 12/3/24.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button

}

struct AlertContext {
    static let invalidData = AlertItem(title: Text("Server Error"), message: Text("The data received from the server was invalid."), dismissButton: .default(Text("OK")))

    static let invalidResponse = AlertItem(title: Text("Server Error"), message: Text("Invalid response from the server."), dismissButton: .default(Text("OK")))

    static let invalidURL = AlertItem(title: Text("Server Error"), message: Text("The requested URL was invalid."), dismissButton: .default(Text("OK")))

    static let unableToComplete = AlertItem(title: Text("Server Error"), message: Text("Please check your internet connection."), dismissButton: .default(Text("OK")))
}
