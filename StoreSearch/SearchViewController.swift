//
//  ViewController.swift
//  StoreSearch
//
//  Created by Maryna Bolotska on 30/10/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    
    
    
    
    var searchResults = [SearchResult]()
    var hasSearched = false
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.becomeFirstResponder()
        
        
        tableView.contentInset = UIEdgeInsets(top: 51, left: 0, bottom:0, right: 0)
        
       var cellNib = UINib(nibName: "SearchResultCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "SearchResultCell")
        
        cellNib = UINib(nibName:TableView.CellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.nothingFoundCell)
    }
    func iTunesURL(searchText: String) -> URL {
        let encodedText = searchText.addingPercentEncoding(
            withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = String(
            format: "https://itunes.apple.com/search?term=%@",encodedText)
        let url = URL(string: urlString)
        return url!
    }
    
    func performStoreRequest(with url: URL) -> String? {
        do {
            return try String(contentsOf: url, encoding: .utf8)
        } catch {
            print("Download Error: \(error.localizedDescription)")
            return nil
        }
    }

}

// MARK: - Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      if !searchBar.text!.isEmpty {
        searchBar.resignFirstResponder()
        hasSearched = true
        searchResults = []
        let url = iTunesURL(searchText: searchBar.text!)
        print("URL: '\(url)'")
          
          if let jsonString = performStoreRequest(with: url) {
            print("Received JSON string '\(jsonString)'")
          }
        tableView.reloadData()
      }
    }
    
    
    
    
    
   
    
}


// MARK: - Table View Delegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !hasSearched {
          return 0
        } else if searchResults.count == 0 {
          return 1
        } else {
          return searchResults.count
        }
    }
    
    
    func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchResults.count == 0 {
            return tableView.dequeueReusableCell(
                withIdentifier:
                    TableView.CellIdentifiers.nothingFoundCell,
                for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        TableView.CellIdentifiers.searchResultCell,
                                                     for: indexPath) as! SearchResultCell
            let searchResult = searchResults[indexPath.row]
            cell.nameLabel.text = searchResult.name
            cell.artistNameLabel.text = searchResult.artistName
            return cell
        }
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
      return .topAttached
    }
    
    func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ){
        tableView.deselectRow(at: indexPath, animated: true)
      }
      func tableView(
        _ tableView: UITableView,
        willSelectRowAt indexPath: IndexPath
      ) -> IndexPath? {
        if searchResults.count == 0 {
          return nil
        } else {
          return indexPath
        }
      }
    
    
 
}


struct TableView {
  struct CellIdentifiers {
    static let searchResultCell = "SearchResultCell"
      static let nothingFoundCell = "NothingFoundCell"
  }
}
