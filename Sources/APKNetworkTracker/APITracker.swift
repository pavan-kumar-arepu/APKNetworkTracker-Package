//
//  File.swift
//  
//
//  Created by Pavankumar Arepu on 14/07/24.
//

import Foundation
import UIKit
import SwiftUI

public class APITracker {
    
    public static var isTrackingEnabled = false
    
    private static var apiCalls: [APICall] = []
    
    public static func startTracking() {
        isTrackingEnabled = true
        URLProtocol.registerClass(APITrackingURLProtocol.self)
    }
    
    public static func stopTracking() {
        URLProtocol.unregisterClass(APITrackingURLProtocol.self)
        APICallManager.shared.clear()
    }
    
    public static func trackAPICall(request: URLRequest, response: HTTPURLResponse?, responseData: Data?) {
        if isTrackingEnabled {
            DispatchQueue.global().async {
                let apiCall = APICall(request: request, response: response, responseData: responseData)
                APICallManager.shared.add(apiCall)
            }
        }
    }
    
    public static func showAPICallModal() {
        DispatchQueue.main.async {
            guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
                print("Error: Root view controller not found")
                return
            }
            
            let modalView = APICallModalView()
            let hostingController = UIHostingController(rootView: modalView)
            
            rootViewController.present(hostingController, animated: true, completion: nil)
        }
    }
}


