//
//  File.swift
//  
//
//  Created by Ugur Cakmakci on 4.04.2024.
//

import Foundation
import UIKit
import AVFoundation

final class DeviceManager {
    
    public class func toggleFlash() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video), device.hasTorch else { return }
        do {
            try device.lockForConfiguration()
            if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                device.torchMode = AVCaptureDevice.TorchMode.off
            } else {
                try device.setTorchModeOn(level: 1.0)
            }
            
            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
    
    public class func showDeviceSettings(action: UIAlertAction) {
        if #available(iOS 10.0, *) {
            let settingsURL = URL(string: UIApplication.openSettingsURLString)!
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        } else if let url = NSURL(string:UIApplication.openSettingsURLString) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    public class func callNumber(_ phoneNumber: String?) {
        if let phoneNumber = phoneNumber,
           let url = URL(string: "tel://\(phoneNumber)"),
           UIApplication.shared.canOpenURL(url) {
            openUrl(link: url)
        }
    }
    
    public class func openUrl(link: URL?) {
        guard let url = link else { return }
        UIApplication.shared.open(url)
    }
    
    public class func vibrate() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}
