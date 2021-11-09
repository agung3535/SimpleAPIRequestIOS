//
//  HomeViewController.swift
//  GetUntukBella
//
//  Created by Putra on 09/11/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var listReto: UITableView!
    var resto: [Resto] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        APIService.shared.getListResto{(result) in
            switch result {
            case .success(let restoData):
                self.resto = restoData
                self.listReto.reloadData()
            case .failure(let error):
                print("error is :\(error.localizedDescription)")
            }
        }
        listReto.dataSource = self
        listReto.delegate = self
        registerCell()
        
        
    }
    

    private func registerCell() {
        listReto.register(UINib(nibName: ItemTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ItemTableViewCell.identifier)
    }
   

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as! ItemTableViewCell
        cell.setup(resto: resto[indexPath.row])
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resto.count
    }
    
    
    
    
}
