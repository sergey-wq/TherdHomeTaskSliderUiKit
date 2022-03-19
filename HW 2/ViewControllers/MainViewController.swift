//
//  SecondViewController.swift
//  HW 2
//
//  Created by Sergey Runovich on 19.03.22.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func getCurrentColor(color: UIColor)
}

class MainViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let firsVC = segue.destination as? SettingsViewController else { return }

        firsVC.currentColor = view.backgroundColor
        firsVC.delegate = self
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func getCurrentColor(color: UIColor) {
        view.backgroundColor = color
    }
}
