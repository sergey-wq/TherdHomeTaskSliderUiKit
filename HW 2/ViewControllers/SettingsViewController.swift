//
//  ViewController.swift
//  HW 2
//
//  Created by Sergey Runovich on 19.03.22.

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!

    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!

    // MARK: - Public Properties
    var currentColor: UIColor?
    var delegate: SettingsViewControllerDelegate?

    // MARK: - Live Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configurtUI()
        callMainMethods()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    // MARK: - IB Actions
    @IBAction func rgbSlider(_ sender: UISlider) {
        setColor()
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
            redTextField.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
            greenTextField.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
            blueTextField.text = string(from: blueSlider)
        }
    }

    @IBAction func dismissToSecondVC() {
        delegate?.getCurrentColor(color: colorView.backgroundColor ?? .blue)
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Private Methods

    private func configurtUI() {
        colorView.layer.cornerRadius = 15
        colorView.backgroundColor = currentColor

        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
    }

    private func callMainMethods() {
        settingSliders(color: currentColor ?? .black)
        setValue(for: redLabel, greenLabel, blueLabel)
        setValueInTextField(for: redTextField, greenTextField, blueTextField)
        addDoneButtonOnKeyboard(for: redTextField, greenTextField, blueTextField)
    }

    private func setColor() {
        let color = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
        colorView.backgroundColor = color
    }

    private func settingSliders(color: UIColor) {
        let color = CIColor(color: color)

        redSlider.value = Float(color.red)
        blueSlider.value = Float(color.blue)
        greenSlider.value = Float(color.green)
    }

    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = string(from: redSlider)
            case greenLabel:
                greenLabel.text = string(from: greenSlider)
            default:
                blueLabel.text = string(from: blueSlider)
            }
        }
    }

    private func setValueInTextField(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField:
                redTextField.text = string(from: redSlider)
            case greenTextField:
                greenTextField.text = string(from: greenSlider)
            default:
                blueTextField.text = string(from: blueSlider)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        guard let floatText = Float(text) else { return }

        switch textField {
        case redTextField:
            redLabel.text = text
            redSlider.value = floatText
        case greenTextField:
            greenLabel.text = text
            greenSlider.value = floatText
        default:
            blueLabel.text = text
            blueSlider.value = floatText
        }
        setColor()
    }
}

// MARK: - Work With Keyboard
extension SettingsViewController {
    func addDoneButtonOnKeyboard(for textFields: UITextField...) {
        let doneToolbar = UIToolbar(frame: CGRect.init(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width, height: 50
        ))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace, target: nil, action: nil
        )
        let done = UIBarButtonItem(
            title: "Done", style: .done,
            target: self,
            action: #selector(self.doneButtonAction)
        )

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        textFields.forEach { $0.inputAccessoryView = doneToolbar }
    }

    @objc func doneButtonAction() {
        view.endEditing(true)
    }
}
