//
//  HomeViewController.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 11.06.2024.
//

import UIKit
import Kingfisher
import IQKeyboardManagerSwift
import netfox
import PanModal
import CoreLocation

class HomeViewController: BaseLocationViewController {
    var viewModel: HomeViewModelProtocol!
    
    @IBOutlet weak var prayerTimesView: PrayerTimeContainerView!
    @IBOutlet weak var quickAccessView: QuickAccessView!
    @IBOutlet weak var mosqueCardView: MosqueCardView!
    @IBOutlet weak var messageCardView: HomeCardView!
    @IBOutlet weak var hadithCardView: HadithCardView!
    @IBOutlet weak var verseCardView: HomeCardView!
    @IBOutlet weak var prayerCardView: HomeCardView!
    @IBOutlet weak var calendarCardView: CalendarCardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
        NFX.sharedInstance().start()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLeftTitle("Namaz Vakitleri")
        setRightButton(clickAction: #selector(self.closeButton_touch), icon: "icon_close")
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache { print("Done") }
    }
    
    @objc
    private func closeButton_touch() {
        NamazService.shared.closeNamazUI()
    }
    
    func setUI() {
        quickAccessView.configure(with: QuickAccessViewModel(menuNavigation: viewModel.menuNavigation,
                                                             menuCoordinator: viewModel.coordinator,
                                                             strings: viewModel.strings))
        
        mosqueCardView.configure(with: MosqueCardViewModel())
        
        messageCardView.configure(with: HomeCardViewModel(type: .message,
                                                          menuNavigation: viewModel.menuNavigation,
                                                          menuCoordinator: viewModel.coordinator,
                                                          strings: viewModel.strings))
        verseCardView.configure(with: HomeCardViewModel(type: .verse,
                                                        menuNavigation: viewModel.menuNavigation,
                                                        menuCoordinator: viewModel.coordinator,
                                                        strings: viewModel.strings))
        hadithCardView.configure(with: HadithCardViewModel(menuNavigation: viewModel.menuNavigation,
                                                           menuCoordinator: viewModel.coordinator,
                                                           strings: viewModel.strings))
        prayerCardView.configure(with: HomeCardViewModel(type: .prayer,
                                                         menuNavigation: viewModel.menuNavigation,
                                                         menuCoordinator: viewModel.coordinator,
                                                         strings: viewModel.strings))
        calendarCardView.configure(with: CalendarCardViewModel(menuNavigation: viewModel.menuNavigation,
                                                               menuCoordinator: viewModel.coordinator,
                                                               strings: viewModel.strings))
        
        prayerTimesView.configure(with: PrayerTimeContainerViewModel(selectLocationHandler: viewModel.presentSelectLocation))
        
        viewModel.serviceGet()
    }
    
    func controlLocationAuthorization() {
        let locationManager = LocationManager.shared
        let userDefaultsManager = UserDefaultsManager.shared

        let hasAuthorization = locationManager.hasAuthorization
        let hasSelectedLocation = userDefaultsManager.selectedLocation != nil
        let hasCurrentLocation = userDefaultsManager.currentLocation != nil
        
        if !hasSelectedLocation && !hasCurrentLocation {
            if hasAuthorization {
                viewModel.presentSelectLocation()
            } else {
                viewModel.showLocationRequest()
            }
        } else if hasAuthorization, hasCurrentLocation {
            viewModel.getCurrentLocation()
        } else if !hasAuthorization, hasCurrentLocation {
            viewModel.getCurrentLocationWithAuthorization()
        } else if hasSelectedLocation {
            viewModel.servicePrayerTime()
        }
    }
}

extension HomeViewController: HomeBindingDelegate {
    
    func homeDataFetched() {
        guard let dayHadiths = viewModel.home?.dayHadith,
              let dayMessage = viewModel.home?.dayMessage,
              let dayVerse = viewModel.home?.dayVerse,
              let dayPrayer = viewModel.home?.dayPrayer,
              let calendar = viewModel.home?.calendar
        else { return }
        hadithCardView.updateUI(data: dayHadiths)
        messageCardView.setData(dayMessage)
        verseCardView.setData(dayVerse)
        prayerCardView.setData(dayPrayer)
        calendarCardView.updateUI(data: calendar)
        
        controlLocationAuthorization()
    }
    
    func prayerTimeFetched() {
        prayerTimesView.viewModel.prayerTime = viewModel.prayerTime
        prayerTimesView.updatePrayerTimes()
    }
    
    func locationRequestDismiss() {
        self.dismiss(animated: true) { [weak self] in
            self?.viewModel.presentSelectLocation()
        }
    }

    func locationSelected() {
        viewModel.servicePrayerTime()
        prayerTimesView.updateLocation()
    }
}

