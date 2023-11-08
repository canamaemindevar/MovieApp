//
//  MainView.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 6.11.2023.
//

import SwiftUI

protocol MainViewInterface: AnyObject {
    func prepare()
    func reloadCollectionView()
    func presentEmptyDataAlert()
}

final class MainView: UIViewController, UISearchControllerDelegate {
    
    private lazy var viewModel = MainViewModel(view: self, manager: NetworkManager.shared)
    private var navVc = UINavigationController()

    //MARK: - Components
    private let searchVc = UISearchController(searchResultsController: nil)
    let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.layer.cornerRadius = 5
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.register(FilmCollectionViewCell.self, forCellWithReuseIdentifier: FilmCollectionViewCell.identifier)
        collection.register(LastSearchsCell.self, forCellWithReuseIdentifier: LastSearchsCell.identifier)
        collection.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier)
        return collection
    }()

    //MARK: - Life Cycle

    override func viewDidLoad() {
        viewModel.viewDidLoad()
        super.viewDidLoad()
        prepare()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
}

private extension MainView {
    func setupNavigationView() {
        navigationItem.searchController = searchVc
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(showFilters))
        if LocalState.hasOnboarded == false {
            let premiumButton = UIBarButtonItem(image: UIImage(systemName: "wand.and.stars"), style: .plain, target: self, action: #selector(showPremium))

            navigationItem.rightBarButtonItems = [searchButton,premiumButton]
        } else {
            navigationItem.rightBarButtonItems = [searchButton]
        }
    }

    @objc func showFilters() {
        presentPickerForFilter()
    }
    @objc func showPremium() {
        presentPremiumView()
    }
}

//MARK: - MainViewViewInterface

extension MainView: MainViewInterface {
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }


  func prepare() { 
      setupNavigationView()
      view.addSubview(mainCollectionView)
      mainCollectionView.frame = view.bounds
      mainCollectionView.delegate = self
      mainCollectionView.dataSource = self
      mainCollectionView.collectionViewLayout = createLayout()
      searchVc.searchBar.delegate = self
      view.backgroundColor = UIColor(named: "backgroundColor")
  }

}
//MARK: - QueryFiltersMakeble

extension MainView :QueryFiltersMakeble {
    func makeQueryFilter(model: SearchOptions) {
        viewModel.filterModel = model
    }
}
//MARK: - Presenting Modals

extension MainView {
   private func presentPickerForFilter() {
        lazy var vc = SearchOptionsViewController()
        vc.delegate = self
        navVc = UINavigationController(rootViewController: vc)
        if let sheet = navVc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        navigationController?.present(navVc,animated: true)
    }

   private func presentPremiumView() {
        let vc = PremiumView()
        let premiumView = UIHostingController(rootView: vc)
        self.navigationController?.present(premiumView, animated: true)
    }

    func presentEmptyDataAlert() {
        DispatchQueue.main.async {
            self.presentAlert(message: "No Result")
        }

    }
}
//MARK: - UICollectionViewDelegate

extension MainView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if indexPath.section == 0 {
            let vc = DetailView()
            vc.id = viewModel.searchData[indexPath.item].imdbID
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
}
//MARK: - UICollectionViewDataSource

extension MainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 0:
                return viewModel.searchData.count
            default:
                return viewModel.lastSearchData.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.section {
            case 0 :
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCollectionViewCell.identifier, for: indexPath) as? FilmCollectionViewCell else {return UICollectionViewCell()}
                cell.item = viewModel.searchData[indexPath.item]
                return cell
            default:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LastSearchsCell.identifier, for: indexPath) as? LastSearchsCell else { return UICollectionViewCell() }
                cell.item = viewModel.lastSearchData[indexPath.item]
                return cell
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return   2
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier, for: indexPath) as? SectionHeader else {
            return UICollectionReusableView()
        }

        if indexPath.section == 0 {
            header.configure(text: "Search Results")
        } else {
            header.configure(text: "Last Searchs")
        }

        return header
    }

}
// MARK: - UICollectionViewCompositionalLayout

private extension MainView {

    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex,_ in
            switch sectionIndex {
                case 0:
                    return self.makeVLayout()
                default:
                    return self.makeHLayout(isSmall: true)
            }
        }
    }

    func makeVLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 12, leading: 4, bottom: 12, trailing: 4)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.5))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 32, leading: 0, bottom: 32, trailing: 0)
        section.boundarySupplementaryItems = [header]
        return section
    }

    func makeHLayout(isSmall: Bool) -> NSCollectionLayoutSection {
        let size = isSmall ? 0.3 : 0.6
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(size),
                                               heightDimension: .estimated(70))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)

        section.boundarySupplementaryItems = [header]
        section.contentInsets = .init(top: 16, leading: 12, bottom: 16, trailing: 12)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
}
//MARK: - UISearchBarDelegate
extension MainView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {return }
        viewModel.makeQuery(withWord: text)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.makeQuery(withWord: "Batman")
    }
}
