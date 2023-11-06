//
//  SearchOptionsViewController.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 6.11.2023.
//

import UIKit

protocol QueryFiltersMakeble: AnyObject {
    func makeQueryFilter()
}

final class SearchOptionsViewController: UIViewController  {

    weak var delegate: QueryFiltersMakeble?

    var myList: [SearchOptions] = [
        .init(option: .generalSearch,
              filters: [
                .init(secondOption: .all),
                .init(secondOption: .type),
                .init(secondOption: .year)]),

        .init(option: .id),
        .init(option: .title)

    ]
    private var mypicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        mypicker.delegate = self
        mypicker.dataSource = self
        view.addSubview(mypicker)
        view.backgroundColor = .black
        let screen = self.view.frame
        NSLayoutConstraint.activate([
            mypicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mypicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mypicker.widthAnchor.constraint(equalToConstant: screen.width ),
            mypicker.heightAnchor.constraint(equalToConstant: screen.height / 1.5)
        ])
    }
}

extension SearchOptionsViewController: UIPickerViewDataSource {
    func numberOfComponents (in pickerView: UIPickerView) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let firstChoice = pickerView.selectedRow(inComponent: 0)
        switch component {
            case 0:
                return myList.count
            case 1:
                return myList[firstChoice].filters?.count ?? 0
            case 2:
                let secondChoice = pickerView.selectedRow(inComponent: 1)
                let count: Int
                let thirdOption = myList[firstChoice].filters?[secondChoice]
                if thirdOption?.secondOption.value == "Year" {
                    count = 10
                } else {
                    count = thirdOption?.secondOption.nextOptionArray.count ?? 0
                }
                return count
            default:
                return 10
        }
    }
}

extension SearchOptionsViewController: UIPickerViewDelegate{

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let firstChoice = pickerView.selectedRow(inComponent: 0)
        switch component {
            case 0:
                return myList[row].option.value
            case 1:
                return myList[firstChoice].filters?[row].secondOption.value
            case 2:
                let secondChoice = pickerView.selectedRow(inComponent: 1)
                let str: String
                let thirdChoice = myList[firstChoice].filters?[secondChoice]
                if thirdChoice?.secondOption.value == "Year" {
                    str = thirdChoice?.secondOption.nextOptionArray[row].capitalized ?? ""
                } else {
                    str = thirdChoice?.secondOption.nextOptionArray[row].capitalized ?? ""
                }
                return str
            default:
                return "err"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                    inComponent component: Int) {
        if component == 0 {
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
        } else if component == 1 {
            pickerView.reloadComponent(2)
        }
        let first = pickerView.selectedRow(inComponent: 0)
        let second = pickerView.selectedRow(inComponent: 1)
        let third = pickerView.selectedRow(inComponent: 2)
        delegate?.makeQueryFilter()
//        print(myList[first].option.value)
//        print(myList[first].filters?[second].secondOption.value.capitalized as Any)
//        print(myList[first].filters?[second].secondOption.nextOptionArray[third].capitalized as Any)
    }
}
