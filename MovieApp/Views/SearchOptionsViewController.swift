//
//  SearchOptionsViewController.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 6.11.2023.
//

import UIKit

protocol QueryFiltersMakeble: AnyObject {
    func makeQueryFilter(model: SearchOptions)
}

final class SearchOptionsViewController: UIViewController  {

    weak var delegate: QueryFiltersMakeble?

    var myList: [SearchOptions] = [
        .init(option: .generalSearch, filters:
                [
                .init(secondOption: .all),
                .init(secondOption: .type),
                .init(secondOption: .year)
                ]),

            .init(option: .id),
        .init(option: .title)

    ]
    private var mypicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    var firstChoice: SearchTypes = .generalSearch
    var secondChoice: SecondOptions = .all
    var thirdChoice: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationBar()
    }
}
private extension SearchOptionsViewController {
    func setup() {
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

    func setupNavigationBar() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancel))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(done))
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = doneButton
    }

    @objc  func cancel() {
        self.navigationController?.dismiss(animated: true)
    }
    @objc  func done() {
        let model = SearchOptions(option: .generalSearch,selectedSecond: secondChoice,thirdOption: thirdChoice)
        delegate?.makeQueryFilter(model: model)
    }
}

extension SearchOptionsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
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
                return 0
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
        if first < myList.count {
            self.firstChoice = myList[first].option
            if let secondChoice = myList[first].filters, second < secondChoice.count {
                self.secondChoice = secondChoice[second].secondOption
                if let thirdChoice = myList[first].filters?[second].secondOption.nextOptionArray, third < thirdChoice.count {
                    self.thirdChoice = thirdChoice[third]
                } else {
                    print("third index out of range")
                }
            } else {
                print("second index out of range")
            }
        } else {
            print("first index out of range")
        }
    }
}
