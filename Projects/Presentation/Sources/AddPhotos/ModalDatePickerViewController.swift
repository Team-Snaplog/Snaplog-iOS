//
//  ModalDatePickerViewController.swift
//  Presentation
//
//  Created by 강민성 on 11/14/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import DesignSystem

public final class ModalDatePickerViewController: UIViewController {

    var selectedDate: ((Date) -> Void)?

    var datePicker: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.backgroundColor = .white
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.date = Date.now
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.setValue(UIColor.black, forKeyPath: "textColor")
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -1, to: Date())
        datePicker.maximumDate = Date.now
        return datePicker
    }()

    var toolBar: UIToolbar = {
        var toolBar = UIToolbar()
        toolBar.backgroundColor = .white
        toolBar.barTintColor = .white
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        return toolBar
    }()

    private lazy var doneButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("완료", for: .normal)
        button.setTitleColor(DesignSystemAsset.NeutralColor.neutral500.color, for: .normal)
        button.titleLabel?.font = Fonts.bodyMedium.font
        button.addTarget(self, action: #selector(didDoneButtonTapped), for: .touchUpInside)
        return button
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        render()
    }

    private func setUp() {
        let doneButton = UIBarButtonItem(customView: doneButton)
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.items = [flexibleItem, doneButton]
        toolBar.sizeToFit()
    }

    private func render() {
        view.clipsToBounds = true
        view.layer.cornerRadius = 10

        view.addSubViews([toolBar, datePicker])

        toolBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
        }

        datePicker.snp.makeConstraints { make in
            make.top.equalTo(toolBar.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    @objc private func didDoneButtonTapped() {
        selectedDate?(datePicker.date)
        dismiss(animated: true, completion: nil)
    }
}
