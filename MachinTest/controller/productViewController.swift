//
//  productViewController.swift
//  MachinTest
//
//  Created by STC on 01/09/23.
//

import UIKit

class productViewController: UIViewController {
    
    
    @IBOutlet weak var productTableView: UITableView!
    
    var productsArray = [Product]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        productApiFetching{
            self.productTableView.reloadData()
        }
        
      registerNib()
    }
    //Mark - register nib
    func registerNib(){
        productTableView.dataSource = self
        productTableView.delegate = self
        let nibName = UINib(nibName: "productTableViewCell", bundle: nil)
        productTableView.register(nibName, forCellReuseIdentifier: "productTableViewCell")
    }
    //mark - apiFeching function 
    func productApiFetching(completed : @escaping() -> ()){
        
            let apiUrl = "https://dummyjson.com/products"
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
                      var result = try jsondecoder.decode(ProductApiResponce.self, from: data!)
                        self.productsArray = result.products
                   
                        
                    }catch {
                        print("product error")
                    }
                    DispatchQueue.main.async {
                        completed()
                    }
                }
            
        }.resume()
}

    
}
extension productViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTableView.dequeueReusableCell(withIdentifier: "productTableViewCell", for: indexPath) as! productTableViewCell
        cell.TitleLabel.text = productsArray[indexPath.row].title
        cell.descriptionsLabel.text = productsArray[indexPath.row].description
        cell.ratingLabel.text = String(productsArray[indexPath.row].rating)
        cell.priceLabel.text = "$\(String(productsArray[indexPath.row].price))"
        return cell
    }
    
    
}
