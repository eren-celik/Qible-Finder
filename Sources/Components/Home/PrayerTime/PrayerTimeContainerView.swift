//
//  PrayerTimesView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 6.07.2024.
//

import UIKit


protocol PrayerTimeContainerViewModelProtocol {
    var selectLocationHandler: VoidHandler { get }
    var todayDate: String { get }
    var todayHijriDate: String { get }
    var prayerTime: PrayerTime? { get set }
    func currentDateText() -> String
}

struct PrayerTimeContainerViewModel: PrayerTimeContainerViewModelProtocol {
    var selectLocationHandler: VoidHandler
    var todayDate: String {
        Date().toString(format: DateType.dd_MMMM_yyyy.rawValue)
    }
    
    var todayHijriDate: String {
        Date().toHijriDateString() ?? ""
    }
    
    func currentDateText() -> String {
        return todayDate + " / " + todayHijriDate
    }
    
    var prayerTime: PrayerTime?
}

class PrayerTimeContainerView: BaseNibLoadableView {
    var viewModel: PrayerTimeContainerViewModelProtocol!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var dateLabel: Label!
    @IBOutlet weak var circularProgressBar: CircularProgressBar!
    @IBOutlet weak var remainingTimeView: RemainTimeView!
    @IBOutlet weak var locationSelectView: LocationSelectView!
    @IBOutlet weak var timesContainerView: TimesContainerView!
    
    func configure(with viewModel: PrayerTimeContainerViewModelProtocol) {
        self.viewModel = viewModel
        setUI()
    }
    
    func setUI() {
        let gradientColor = UIColor.gradientColor(
            colors: [.primaryBase, .primary300],
            size: bgView.frame.size
        )
        bgView.backgroundColor = gradientColor
        
        let text = viewModel.currentDateText()
        dateLabel.configure(with: .init(alignment: .center))
        dateLabel.setAttributedText(mainText: text, mainFont: .xs3SemiBold,
                                    mainColor: .whiteBase,
                                    secondaryText: viewModel.todayHijriDate,
                                    secondaryFont: .xs3Medium,
                                    secondaryColor: .white200)
        
        remainingTimeView.setUI()
        locationSelectView.configure(with: LocationViewModel(selectLocationHandler: viewModel.selectLocationHandler))
    }
    
    func updateLocation() {
        locationSelectView.updateLocationUI()
    }
    
    func updatePrayerTimes() {
        guard let prayerTime = viewModel.prayerTime else { return }
        
        PrayerTimeManager.shared.delegate = self
        
        PrayerTimeManager.shared.setPrayerTimes([prayerTime])
        let currentPrayerTime = PrayerTimeManager.shared.currentPrayerTime
        let nextPrayerTime = PrayerTimeManager.shared.nextPrayerTime
        
        circularProgressBar.startTime = prayerTime.times?.fajr
        circularProgressBar.endTime = prayerTime.times?.isha
        circularProgressBar.times = prayerTime.times
        remainingTimeView.configure(with: RemainTimeViewModel(data: prayerTime.times,
                                                              nextPrayerTime: nextPrayerTime))
        
        timesContainerView.configure(with: TimesContainerViewModel(data: prayerTime.times,
                                                                   currentPrayerTime: currentPrayerTime))
    }
}

extension PrayerTimeContainerView: PrayerTimeManagerDelegate {
    func didUpdateTimeUntilNextPrayer(_ timeString: String) {
        remainingTimeView.remainingTime = timeString
    }
    
    func countDownIsOver() {
        let delay = 2.0 // 2 saniye gecikme
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.updatePrayerTimes()
        }
    }
}
