//
//  HomeViewController.swift
//  GS_Test
//
//  Created by roshan on 16/06/21.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {

    let homeViewmodel = HomeViewModel()
    @IBOutlet weak var tableview : UITableView!
    @IBOutlet weak var genderFilterSegment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Users"
        homeViewmodel.getUsersData()
        Bind()
        genderFilterSegment.replaceSegments(segments: homeViewmodel.genderSegment)
    }
    
    
    func Bind(){
        homeViewmodel.filteredUsers.bindAndFire({ (users) in
            DispatchQueue.main.async {[weak self] in
                self?.tableview.reloadData()
                if users.count > 0{
                    self?.tableview.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
            }
        })
        homeViewmodel.errorMessage.bindAndFire { [weak self](errorMessage) in
            if(!errorMessage.isEmpty){
                DispatchQueue.main.async {[weak self] in
                    self?.showAlert(withTitle: "Error", message: errorMessage)
                }
                
            }
        }
    }
    
    @IBAction func segmentChnaged(_ sender: UISegmentedControl){
        homeViewmodel.Filter(homeViewmodel.genderSegment[sender.selectedSegmentIndex])
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewmodel.filteredUsers.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        cell.userTableViewCellViewModel = UserTableViewCellViewModel(userData: homeViewmodel.filteredUsers.value[indexPath.row],homeviewmodel: homeViewmodel)
        return cell
    }
}
