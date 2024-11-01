//
//  TimeView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 9.07.2024.
//

import UIKit

protocol TimeViewModelProtocol {
    var data: TimeView.TimeModel? { get set }
    var currentTime: PrayerTimeManager.TimeType? { get set }
}

struct TimeViewModel: TimeViewModelProtocol {
    var data: TimeView.TimeModel? = nil
    var currentTime: PrayerTimeManager.TimeType?
}

class TimeView: BaseNibLoadableView {
    var viewModel: TimeViewModelProtocol!
    
    @IBOutlet weak var timeInfoLabel: Label!
    @IBOutlet weak var timeIcon: UIImageView!
    @IBOutlet weak var timeLabel: Label!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        timeInfoLabel.configure(with: .init(font: .xs3Bold, textColor: .whiteBase, alignment: .center))
        timeLabel.configure(with: .init(font: .xs3SemiBold, textColor: .whiteBase, alignment: .center))
    }
    
    func updateTimes(with viewModel: TimeViewModelProtocol) {
        self.viewModel = viewModel
        timeInfoLabel.text = viewModel.data?.timeType.title
        timeIcon.image = .namazAsset(named: viewModel.data?.timeType.icon ?? "")
        timeIcon.tintColor = .whiteBase
        timeLabel.text = viewModel.data?.time
        
        updateCurrentTimeUI()
    }
    
    func updateCurrentTimeUI() {
        guard let viewModel, let data = viewModel.data else { return }
        if viewModel.currentTime == data.timeType {
            timeInfoLabel.textColor = .secondaryBase
            timeIcon.tintColor = .secondaryBase
            timeIcon.image = .namazAsset(named: data.timeType.filledIcon)
            timeLabel.textColor = .secondaryBase
        }
    }
}

extension TimeView {
    struct TimeModel {
        var timeType: PrayerTimeManager.TimeType
        var time: String
    }
}
