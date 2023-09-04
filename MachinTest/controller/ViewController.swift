//
//  ViewController.swift
//  MachinTest
//
//  Created by STC on 01/09/23.
//

import UIKit
import SDWebImage
class ViewController: UIViewController {
    
    
    @IBOutlet weak var userCollectionView: UICollectionView!
    
    
  //Mark - declaring Array for storing user Data
var usersArray = [UserData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Userapifeching {
            self.userCollectionView.reloadData()
        }
        //mark - collection view devide 2 column
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        userCollectionView.setCollectionViewLayout(layout, animated: true)
        
        registerNib()
        
    }
    
    func registerNib(){
        userCollectionView.delegate = self
        userCollectionView.dataSource = self
        let nibName = UINib(nibName: "userCollectionViewCell", bundle: nil)
        userCollectionView.register(nibName, forCellWithReuseIdentifier: "userCollectionViewCell")
    }
    
    //mark - UserPApi Calling function ...
    func Userapifeching(completed : @escaping() -> ()){
            let apiUrl = "https://reqres.in/api/users?page=2"
            guard let url = URL(string: apiUrl) else{
                print("url not found")
                return
            }
            URLSession.shared.dataTask(with: url){data,response, error in
                print(response)
                print(data)
                if(error == nil){
                   
                    do{
                       let jsondecoder = JSONDecoder()
                      var result = try jsondecoder.decode(UserApiResponce.self, from: data!)
                        self.usersArray = result.data
                   
                        
                    }catch {
                        print("error")
                    }
                    DispatchQueue.main.async {
                        completed()
                    }
                }
            
        }.resume()
}

}
extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.usersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = userCollectionView.dequeueReusableCell(withReuseIdentifier: "userCollectionViewCell", for: indexPath) as! userCollectionViewCell
        cell.firstName.text = usersArray[indexPath.row].firstName
        cell.lastName.text = usersArray[indexPath.row].lastName
        cell.email.text = usersArray[indexPath.row].email
        var imgurl = URL(string: usersArray[indexPath.row].avatar)
        cell.userImage.sd_setImage(with: imgurl)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
            let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
            
            return CGSize(width:widthPerItem, height:200)
    }
}

