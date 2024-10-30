//
//  MapManager.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 18.07.2024.
//

import MapKit

protocol MapManagerProtocol: AnyObject {
    var delegate: MapManagerDelegate? { get set }
    func initialize(with mapView: MKMapView)
    func centerMap(on location: CLLocation)
    func addAnnotation(id: String, title: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    func removeAllAnnotations()
    func centerMapOnAnnotations()
}

protocol MapManagerDelegate: AnyObject {
    func didSelectAnnotation(_ annotation: MKAnnotation)
    func regionDidChanged(_ coordinate: CLLocationCoordinate2D)
}

class MosqueAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var id: String

    init(title: String?, coordinate: CLLocationCoordinate2D, id: String) {
        self.title = title
        self.coordinate = coordinate
        self.id = id
        super.init()
    }
}

class MapManager: NSObject, MapManagerProtocol {
    weak var delegate: MapManagerDelegate?
    private var mapView: MKMapView?
    
    func initialize(with mapView: MKMapView) {
        self.mapView?.removeFromSuperview()
        self.mapView = mapView
        self.mapView?.delegate = self
        self.mapView?.showsUserLocation = true
    }
    
    func centerMap(on location: CLLocation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView?.setRegion(region, animated: true)
    }
    
    func addAnnotation(id: String, title: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        guard let mapView = mapView else { return }
        let annotation = MosqueAnnotation(title: title, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), id: id)
        mapView.addAnnotation(annotation)
    }
    
    func removeAllAnnotations() {
        guard let mapView = mapView else { return }
        mapView.removeAnnotations(mapView.annotations)
    }
    
    func centerMapOnAnnotations() {
        guard let mapView = mapView, !mapView.annotations.isEmpty else { return }
        
        var minLat = CLLocationDegrees.greatestFiniteMagnitude
        var maxLat = -CLLocationDegrees.greatestFiniteMagnitude
        var minLon = CLLocationDegrees.greatestFiniteMagnitude
        var maxLon = -CLLocationDegrees.greatestFiniteMagnitude
        
        for annotation in mapView.annotations {
            let coordinate = annotation.coordinate
            minLat = min(minLat, coordinate.latitude)
            maxLat = max(maxLat, coordinate.latitude)
            minLon = min(minLon, coordinate.longitude)
            maxLon = max(maxLon, coordinate.longitude)
        }
        
        let centerLat = (minLat + maxLat) / 2
        let centerLon = (minLon + maxLon) / 2
        let spanLat = (maxLat - minLat) * 1.2 // Add some padding
        let spanLon = (maxLon - minLon) * 1.2 // Add some padding
        
        let centerCoordinate = CLLocationCoordinate2D(latitude: centerLat, longitude: centerLon)
        let span = MKCoordinateSpan(latitudeDelta: spanLat, longitudeDelta: spanLon)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        
        mapView.setRegion(region, animated: true)
    }
}

extension MapManager: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation {
            delegate?.didSelectAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier = "CustomPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = false
            annotationView?.image = UIImage.iconMapPin
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        delegate?.regionDidChanged(mapView.centerCoordinate)
    }
}
