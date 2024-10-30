import UIKit

class CircularProgressBar: BaseNibLoadableView {
    
    private var progressLayer = CAShapeLayer()
    private var trackLayer = CAShapeLayer()
    
    var startTime: String?
    var endTime: String?
    var times: PrayerTime.Time? {
        didSet {
            addIcons(startAngle: startAngle.degreesToRadians, endAngle: endAngle.degreesToRadians)
        }
    }
    
    var progressColor: UIColor = .whiteBase {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var trackColor: UIColor = .primary100 {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    var progress: CGFloat = 0 {
        didSet {
            progressLayer.strokeEnd = progress
        }
    }
    
    var startAngle: CGFloat = -130 {
        didSet {
            updateCircularPath()
        }
    }
    
    var endAngle: CGFloat = -50 {
        didSet {
            updateCircularPath()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
        startTimer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
        startTimer()
    }
    
    private var timer: Timer?
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func updateProgress() {
        guard let startTime, let endTime else { return }
        let startTimeString = startTime
        let endTimeString = endTime
        
        if let normalizedTime = Date().getCurrentTimeNormalized(from: startTimeString, to: endTimeString), normalizedTime > 0 {
            setProgressWithAnimation(duration: 0.5, value: Float(normalizedTime))
            checkIfTimeReached(endTimeString: endTimeString)
        } else {
            stopTimer()
        }
    }
    
    private func checkIfTimeReached(endTimeString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        guard let endTime = dateFormatter.date(from: endTimeString) else {
            print("Error: Invalid end time format.")
            return
        }
        
        let calendar = Calendar.current
        let currentDate = Date()
        let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
        let endTimeComponents = calendar.dateComponents([.hour, .minute], from: endTime)
        
        var combinedComponents = DateComponents()
        combinedComponents.year = currentDateComponents.year
        combinedComponents.month = currentDateComponents.month
        combinedComponents.day = currentDateComponents.day
        combinedComponents.hour = endTimeComponents.hour
        combinedComponents.minute = endTimeComponents.minute
        
        guard let combinedDate = calendar.date(from: combinedComponents) else {
            print("Error: Unable to combine date components.")
            return
        }
        
        if currentDate >= combinedDate {
            stopTimer()
        }
    }
    
    func setProgressWithAnimation(duration: TimeInterval, value: Float) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = progressLayer.presentation()?.strokeEnd ?? 0
        animation.toValue = value
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        progressLayer.strokeEnd = CGFloat(value)
        progressLayer.add(animation, forKey: "animateProgress")
    }
    
    private func setupLayers() {
        let circularPath = createCircularPath()
        
        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = 10.0
        trackLayer.strokeEnd = 1.0
        trackLayer.lineCap = .round
        layer.addSublayer(trackLayer)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 10.0
        progressLayer.strokeEnd = 0.0
        progressLayer.lineCap = .round
        layer.addSublayer(progressLayer)
    }
    
    private func createCircularPath() -> UIBezierPath {
        let center = CGPoint(x: frame.size.width / 2, y: 300)
        let radius = frame.size.width / 1.3
        
        return UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle.degreesToRadians, endAngle: endAngle.degreesToRadians, clockwise: true)
    }
    
    private func updateCircularPath() {
        let circularPath = createCircularPath()
        
        trackLayer.path = circularPath.cgPath
        progressLayer.path = circularPath.cgPath
    }
    
    private func addIcons(startAngle: CGFloat, endAngle: CGFloat) {
        guard let times else { return }
        let center = CGPoint(x: frame.size.width / 2, y: 300)
        let radius = frame.size.width / 1.3
        let icons = ["icon_imsak_active", "icon_gunes_ogle_active", "icon_gunes_ogle_active", "icon_ikindi_active", "icon_aksam_active", "icon_yatsi_active"]
        
        // Total angle span
        let totalAngle = endAngle - startAngle
        let timeAngles = [
            getAngle(for: times.fajr, startTime: startTime, endTime: endTime, startAngle: startAngle, endAngle: endAngle),
            getAngle(for: times.sunrise, startTime: startTime, endTime: endTime, startAngle: startAngle, endAngle: endAngle),
            getAngle(for: times.dhuhr, startTime: startTime, endTime: endTime, startAngle: startAngle, endAngle: endAngle),
            getAngle(for: times.asr, startTime: startTime, endTime: endTime, startAngle: startAngle, endAngle: endAngle),
            getAngle(for: times.maghrib, startTime: startTime, endTime: endTime, startAngle: startAngle, endAngle: endAngle),
            getAngle(for: times.isha, startTime: startTime, endTime: endTime, startAngle: startAngle, endAngle: endAngle)
        ]
        
        for (index, iconName) in icons.enumerated() {
            let angle = timeAngles[index]
            
            // Calculate the position of the icon
            let x = center.x + radius * cos(angle)
            let y = center.y + radius * sin(angle)
            
            // Create and configure the imageView
            let imageView = UIImageView(image: UIImage.namazAsset(named: iconName))
            imageView.backgroundColor = .clear // Optionally set background color
            imageView.frame.size = CGSize(width: 26, height: 26) // Customize the size as needed
            imageView.center = CGPoint(x: x, y: y)
            addSubview(imageView)
        }
    }
    
    private func getAngle(for time: String?, startTime: String?, endTime: String?, startAngle: CGFloat, endAngle: CGFloat) -> CGFloat {
        guard let time = time, let startTime = startTime, let endTime = endTime else { return 0 }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        guard let start = dateFormatter.date(from: startTime),
              let end = dateFormatter.date(from: endTime),
              let time = dateFormatter.date(from: time) else { return 0 }
        
        let totalDuration = end.timeIntervalSince(start)
        let timeOffset = time.timeIntervalSince(start)
        
        let angleOffset = CGFloat(timeOffset / totalDuration) * (endAngle - startAngle)
        return startAngle + angleOffset
    }
}

extension CGFloat {
    var degreesToRadians: CGFloat {
        return self * .pi / 180
    }
}
