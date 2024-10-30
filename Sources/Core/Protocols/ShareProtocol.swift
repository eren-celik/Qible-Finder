//
//  ShareProtocol.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 23.07.2024.
//

import Foundation
import MapKit

protocol MapShareProtocol {
    func showMapShareOptions(for destination: CLLocationCoordinate2D, title: String)
}

protocol ShareProtocol: MapShareProtocol {
    
}

// ShareHandler protokolü için varsayılan implementasyon
extension ShareProtocol where Self: UIViewController {
    func showMapShareOptions(for destination: CLLocationCoordinate2D, title: String) {
        let latitude = destination.latitude
        let longitude = destination.longitude
        
        let appleMapsURL = "http://maps.apple.com/?daddr=\(latitude),\(longitude)"
        let shareText = title + "\n" + appleMapsURL
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}
