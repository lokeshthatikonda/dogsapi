//
//  Utils.swift
//  TheDog
//
//  Created by Lokesh on 12/21/23.
//

import Foundation
import UIKit
import MBProgressHUD

func showAlert(withTitle title: String, andMessage message: String, completion: @escaping () -> Void) {
    DispatchQueue.main.async {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (_) in
            completion()
        }
        alert.addAction(action)
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        let keyWindow = sceneDelegate?.window ?? UIWindow()
        keyWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

func readJSON(_ fileName:String) -> Data {
    if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
          } catch {
                print("JSON File Error \(fileName)")
          }
    }
    return Data()
}
func isMockEnabled() -> Bool {
    if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
        return true
    }
    return false
}
func showIndicator(withTitle title: String? = "loading...", and Description:String? = "Fetching Dogs..") {
    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    let loadingIndicator = MBProgressHUD.showAdded(to: sceneDelegate?.window ?? UIWindow(), animated: true)
    loadingIndicator.bezelView.color = UIColor.darkGray
    loadingIndicator.bezelView.style = .solidColor
    loadingIndicator.contentColor = .white
    loadingIndicator.label.text = title ?? ""
    loadingIndicator.isUserInteractionEnabled = false
    loadingIndicator.detailsLabel.text = Description ?? ""
    loadingIndicator.show(animated: true)
}
func hideIndicator() {
    DispatchQueue.main.async {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        let keyWindow = sceneDelegate?.window ?? UIWindow()
        MBProgressHUD.hide(for: keyWindow, animated: true)
    }
}
