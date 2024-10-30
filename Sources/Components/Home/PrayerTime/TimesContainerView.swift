//
//  TimesContainerView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 9.07.2024.
//

import UIKit


protocol TimesContainerViewModelProtocol {
    var data: PrayerTime.Time? { get set }
    var currentPrayerTime: PrayerTimeManager.TimeType? { get set }
}

struct TimesContainerViewModel: TimesContainerViewModelProtocol {
    var data: PrayerTime.Time? = nil
    var currentPrayerTime: PrayerTimeManager.TimeType? = nil
}

class TimesContainerView: BaseNibLoadableView {
    var viewModel: TimesContainerViewModelProtocol!
    
    @IBOutlet weak var stackView: UIStackView!
    
    func configure(with viewModel: TimesContainerViewModelProtocol) {
        self.viewModel = viewModel
        setUI()
    }

    func setUI() {
        stackView.removeAll()
        
        let prayerTimes: [(timeType: PrayerTimeManager.TimeType, time: String?)] = [
            ( .fajr, viewModel.data?.fajr),
            ( .sunrise ,viewModel.data?.sunrise),
            ( .dhuhr ,viewModel.data?.dhuhr),
            ( .asr ,viewModel.data?.asr),
            ( .maghrib ,viewModel.data?.maghrib),
            ( .isha ,viewModel.data?.isha)
        ]
        
        for prayerTime in prayerTimes {
            let model = TimeView.TimeModel(timeType: prayerTime.timeType, time: prayerTime.time ?? "-")
            let timeView = TimeView()
            timeView.updateTimes(with: TimeViewModel(data: model, currentTime: viewModel.currentPrayerTime))
            stackView.addArrangedSubview(timeView)
        }
    }
}
