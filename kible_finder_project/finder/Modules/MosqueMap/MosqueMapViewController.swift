//
//  MosqueMapViewController.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 18.07.2024.
//

import UIKit
import MapKit

class MosqueMapViewController: BaseViewController, MapNavigationProtocol, ShareProtocol {
    var viewModel: MosqueMapViewModelProtocol!
    var mapManager: MapManagerProtocol! // MapManagerProtocol olarak tanımlıyoruz
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationInfoView: LocationInfoView!
    @IBOutlet weak var mosqueCollectionView: CollectionView!
    @IBOutlet weak var listButtonView: ListMapButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapManager = MapManager()
        mapManager.delegate = self
        mapManager.initialize(with: mapView)
    }
    
    func setUI() {
        mosqueCollectionView.configure(delegate: self, dataSource: self, cell: MosqueMapCell.self)
        mosqueCollectionView.updateLayout(layout: updateFlowLayout(mosqueCollectionView.flowLayout))
        listButtonView.configure(with: ListMapButtonViewModel(strings: viewModel.strings,
                                                              clickedHandler: showMosqueList,
                                                              centerMapHandler: centerMap))
        locationInfoView.configure(with: LocationInfoViewModel())
        locationInfoView.isHidden = viewModel.hasAuthorization
        
        controlLocation()
    }
    
    func controlLocation() {
        if viewModel.hasAuthorization, viewModel.hasCurrentLocation {
            viewModel.getCurrentLocation()
        } else if !viewModel.hasAuthorization, viewModel.hasCurrentLocation {
            viewModel.getCurrentLocationWithAuthorization()
        } else if viewModel.hasSelectedLocation {
            viewModel.serviceGet()
        }
    }
    
    func updateFlowLayout(_ flowLayout: UICollectionViewFlowLayout) -> UICollectionViewFlowLayout {
        let updatedFlowLayout = flowLayout
        updatedFlowLayout.estimatedItemSize = .zero
        updatedFlowLayout.itemSize = CGSize(width: mosqueCollectionView.bounds.width-16, height: 170)
        return updatedFlowLayout
    }
    
    func addAnnotations() {
        mapManager.removeAllAnnotations()
        viewModel.data?.forEach({ data in
            mapManager.addAnnotation(id: data.id ?? "",
                                     title: data.name ?? "",
                                     latitude: CLLocationDegrees(data.lat ?? 0),
                                     longitude: CLLocationDegrees(data.long ?? 0))
        })
    }
    
    func showMosqueList() {
        let mosqueListView = MosqueListView()
        mosqueListView.configure(with: MosqueListViewModel(data: viewModel.data ?? [],
                                                           strings: viewModel.strings,
                                                           dismissHandler: dismissDialog,
                                                           routeHandler: dismissAndRouteToMosque,
                                                           shareHandler: dismissAndShareMosque))
        let panModalViewController = PanModalViewController(contentView: mosqueListView)
        presentPanModal(panModalViewController)
    }
    
    func centerMap() {
        if viewModel.isAuthorizationDenied {
            locationInfoView.isHidden = false
        } else {
            locationInfoView.isHidden = true
            viewModel.getCurrentLocationWithAuthorization()
        }
    }
    
    // MARK: - HANDLERS
    
    func dismissAndRouteToMosque(data: MosqueMap?) {
        dismiss(animated: true) { [weak self] in
            self?.routeToMosque(data: data)
        }
    }
    
    func dismissAndShareMosque(data: MosqueMap?) {
        dismiss(animated: true) { [weak self] in
            self?.shareMosque(data: data)
        }
    }
    
    func routeToMosque(data: MosqueMap?) {
        guard let data else { return }
        let destination = CLLocationCoordinate2D(latitude: CLLocationDegrees(data.lat ?? 0),
                                                 longitude: CLLocationDegrees(data.long ?? 0))
        
        showMapNavigationOptions(for: destination)
    }
    
    func shareMosque(data: MosqueMap?) {
        guard let data else { return }
        let destination = CLLocationCoordinate2D(latitude: CLLocationDegrees(data.lat ?? 0),
                                                 longitude: CLLocationDegrees(data.long ?? 0))
        
        showMapShareOptions(for: destination, title: data.name ?? "")
    }
    
}

extension MosqueMapViewController: UICollectionViewDelegate {}

extension MosqueMapViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MosqueMapCell = collectionView.dequeueReusableCell(for: indexPath)
        let data = viewModel.data?[indexPath.row]
        cell.routeHandler = routeToMosque
        cell.shareHandler = shareMosque
        cell.setUI(data: data, strings: viewModel.strings)
        return cell
    }
}

extension MosqueMapViewController: MapManagerDelegate {
    func didSelectAnnotation(_ annotation: MKAnnotation) {
        guard let mosqueAnnotation = annotation as? MosqueAnnotation else { return }
        if let index = viewModel.indexOfAnnotation(mosqueAnnotation) {
            let indexPath = IndexPath(item: index, section: 0)
            mosqueCollectionView.collection.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
    }
    
    func regionDidChanged(_ coordinate: CLLocationCoordinate2D) {
        debugPrint(coordinate)
    }
}

extension MosqueMapViewController: MosqueMapBindingDelegate {
    func dataFetched() {
        mosqueCollectionView.reload()
        addAnnotations()
        mapManager.centerMapOnAnnotations()
    }
    
    func locationAuthorizationDenied() {
        locationInfoView.isHidden = false
    }
    
    func locationUpdate(location: CLLocation) {
        viewModel.serviceGet()
    }
}
