//
//  File.swift
//  
//
//  Created by Pavankumar Arepu on 14/07/24.
//
// Sources/APKNetworkTracker/Views/APICallListView.swift

import SwiftUI

public struct APICallModalView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @State private var apiCalls: [APICall] = [] // Assuming this is populated with data
    
    public init() {} // Public initializer
    
    public var body: some View {
        NavigationView {
            List(apiCalls) { apiCall in
                NavigationLink(destination: APICallDetailView(apiCall: apiCall)) {
                    Text("API Call \(apiCall.id)")
                }
            }
            .navigationTitle("API Calls")
            .navigationBarItems(trailing: Button("Close") {
                self.presentationMode.wrappedValue.dismiss()
            })
            .onAppear {
                self.fetchAPIcalls()
            }
        }
    }
    
    private func fetchAPIcalls() {
        // Fetch API calls from APICallManager or any other source
        self.apiCalls = APICallManager.shared.apiCalls
    }
}
