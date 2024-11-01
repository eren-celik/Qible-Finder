//
//  RemainTimeView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 6.07.2024.
//

import UIKit


protocol RemainTimeViewModelProtocol {
    var data: PrayerTime.Time? { get set }
    var nextPrayerTime: PrayerTimeManager.TimeType? { get set }
}

struct RemainTimeViewModel: RemainTimeViewModelProtocol {
    var data: PrayerTime.Time?
    var nextPrayerTime: PrayerTimeManager.TimeType?
}

class RemainTimeView: BaseNibLoadableView {
    var viewModel: RemainTimeViewModelProtocol!
    
    @IBOutlet weak var hicriRemaingTimeLabel: Label!
    @IBOutlet weak var remaingTimeTitleLabel: Label!
    @IBOutlet weak var remaingTimeValueLabel: Label!
    
    var remainingTime: String? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.remaingTimeValueLabel.text = self?.remainingTime
            }
        }
    }

    func setUI() {
        hicriRemaingTimeLabel.configure(with: .init(font: .xs4Medium, textColor: .white400, alignment: .center))
        remaingTimeTitleLabel.configure(with: .init(alignment: .center))
        remaingTimeValueLabel.configure(with: .init(font: .xl4Bold, textColor: .whiteBase, alignment: .center))
    }
    
    func configure(with viewModel: RemainTimeViewModelProtocol) {
        self.viewModel = viewModel
        updateTimeUI()
    }
    
    func updateTimeUI() {
        hicriRemaingTimeLabel.text = "Kerahate: 02:12:24"
        let nextPrayerTime = viewModel.nextPrayerTime ?? .fajr
        let remainingTimeText = nextPrayerTime.title + " vaktine kalan süre"
        remaingTimeTitleLabel.setAttributedText(mainText: remainingTimeText, mainFont: .xs2Medium,
                                                mainColor: .white200,
                                                secondaryText: nextPrayerTime.title,
                                                secondaryFont: .xs2Bold,
                                                secondaryColor: .whiteBase)
    }
    
    
}

