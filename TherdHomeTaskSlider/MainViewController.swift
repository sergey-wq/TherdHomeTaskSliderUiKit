//
//  ViewController.swift
//  TherdHomeTaskSlider
//
//  Created by Sergey Runovich on 5.03.22.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet private weak var mainView: UIView!

    @IBOutlet private weak var redColorInfoLabel: UILabel!
    @IBOutlet private weak var greenColorInfoLabel: UILabel!
    @IBOutlet private weak var blueColorInfoLabel: UILabel!

    @IBOutlet private weak var redSlider: UISlider!
    @IBOutlet private weak var greenSlider: UISlider!
    @IBOutlet private weak var blueSlider: UISlider!

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - IB Actions
    @IBAction func slidersAction(_ sender: UISlider) {
        configureSlidersLabelInfo()
        configureMainViewColor(
            redColor: CGFloat(redSlider.value),
            greenColor: CGFloat(greenSlider.value),
            blueColor: CGFloat(blueSlider.value)
        )
    }

    // MARK: - Private Methods
    private func configureMainViewColor(
        redColor: CGFloat,
        greenColor: CGFloat,
        blueColor: CGFloat
    ) {
        mainView.backgroundColor = UIColor(
            red: CGFloat(redColor),
            green: CGFloat(greenColor),
            blue: CGFloat(blueColor),
            alpha: 1
        )
    }
}

extension MainViewController {

    // MARK: - Public Methods
    func configureSlidersLabelInfo() {
        redColorInfoLabel.text = String(format: "%.2f", redSlider.value)
        greenColorInfoLabel.text = String(format: "%.2f", greenSlider.value)
        blueColorInfoLabel.text = String(format: "%.2f", blueSlider.value)
    }

    func configureUI() {
        configureSlidersLabelInfo()

        mainView.layer.cornerRadius = 20

        redSlider.value = 0.05
        greenSlider.value = 0.27
        blueSlider.value = 0.49

        configureMainViewColor(
            redColor: CGFloat(redSlider.value),
            greenColor: CGFloat(greenSlider.value),
            blueColor: CGFloat(blueSlider.value)
        )
    }
}
