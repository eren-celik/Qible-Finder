//
//  MapNavigationProtocol.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 23.07.2024.
//

import Foundation
import MapKit

// NavigationHandler protokolü
protocol MapNavigationProtocol {
    func openInAppleMaps(destination: CLLocationCoordinate2D)
    func openInGoogleMaps(destination: CLLocationCoordinate2D)
    func openInYandexMaps(destination: CLLocationCoordinate2D)
    func openInYandexNavi(destination: CLLocationCoordinate2D)
    func showMapNavigationOptions(for destination: CLLocationCoordinate2D)
}

// NavigationHandler protokolü için varsayılan implementasyon
extension MapNavigationProtocol where Self: UIViewController {
    func openInAppleMaps(destination: CLLocationCoordinate2D) {
        let placemark = MKPlacemark(coordinate: destination)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Destination"
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: options)
    }
    
    func openInGoogleMaps(destination: CLLocationCoordinate2D) {
        if let url = URL(string: "comgooglemaps://?daddr=\(destination.latitude),\(destination.longitude)&directionsmode=driving") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Google Maps yüklü değil")
            }
        }
    }
    
    func openInYandexMaps(destination: CLLocationCoordinate2D) {
        if let url = URL(string: "yandexmaps://maps.yandex.com/?rtext=~\(destination.latitude),\(destination.longitude)&rtt=auto") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Yandex Maps yüklü değil")
            }
        }
    }
    
    func openInYandexNavi(destination: CLLocationCoordinate2D) {
        if let url = URL(string: "yandexnavi://build_route_on_map?lat_to=\(destination.latitude)&lon_to=\(destination.longitude)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Yandex Navi yüklü değil")
            }
        }
    }
    
    // Yardımcı fonksiyon ile UIAlertAction ekleme işlemini tek bir yere toplarız
    private func addActionIfAvailable(title: String, urlScheme: String, handler: @escaping () -> Void, to alert: UIAlertController) {
        if let url = URL(string: "\(urlScheme)://"), UIApplication.shared.canOpenURL(url) {
            alert.addAction(UIAlertAction(title: title, style: .default) { _ in handler() })
        }
    }
    
    func showMapNavigationOptions(for destination: CLLocationCoordinate2D) {
        let alert = UIAlertController(title: "Seçim Yapın", message: nil, preferredStyle: .actionSheet)
        
        // Apple Maps seçeneği ekle
        alert.addAction(UIAlertAction(title: "Maps ile Aç", style: .default, handler: { _ in
            self.openInAppleMaps(destination: destination)
        }))
        
        // Diğer harita uygulamalarını kontrol edip ekleme
        addActionIfAvailable(title: "Google Maps ile Aç", urlScheme: "comgooglemaps", handler: {
            self.openInGoogleMaps(destination: destination)
        }, to: alert)
        
        addActionIfAvailable(title: "Yandex Maps ile Aç", urlScheme: "yandexmaps", handler: {
            self.openInYandexMaps(destination: destination)
        }, to: alert)
        
        addActionIfAvailable(title: "Yandex Navi ile Aç", urlScheme: "yandexnavi", handler: {
            self.openInYandexNavi(destination: destination)
        }, to: alert)
        
        // İptal seçeneği ekle
        alert.addAction(UIAlertAction(title: "İptal", style: .cancel, handler: nil))
        
        // Alert controller'ı göster
        present(alert, animated: true, completion: nil)
    }
    
}
