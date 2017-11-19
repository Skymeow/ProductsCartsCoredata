import UIKit
import CoreData

class InventoriesViewController: UIViewController {
    let stack = CoreDataStack.instance
    var cart: Cart?
    
    @IBOutlet weak var tableView: UITableView!
    var inventories = [Inventory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        /** if cart doesn't exsit in coredata, create a new cart,save to coredata and asign the cart to cart var in VC in either case
         */
        let fetchCartRequest = NSFetchRequest<Cart>(entityName: "Cart")
        do {
            let fetchResult = try stack.privateContext.fetch(fetchCartRequest)
            guard let cart = fetchResult.first else {
                let newCart = Cart(context: stack.privateContext)
//                newCart.name = "NewAwesomeCart"
                stack.saveTo(context: stack.privateContext)
                return
            }
            self.cart = cart
        } catch let error {
            print(error)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /** fetch inventory from viewContext so it'll load in vc
     **/
        let fetchInv = NSFetchRequest<Inventory>(entityName: "Inventory")
        do {
            let resultInv = try stack.viewContext.fetch(fetchInv)
            self.inventories = resultInv
            self.tableView.reloadData()
        }catch let error {
            print(error)
        }
    }
}


extension InventoriesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventories.count
    }
}

extension InventoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath)
        
        let item = inventories[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "x\(item.quantity)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedInventory = inventories[indexPath.row]
        
        defer {
            stack.saveTo(context: stack.privateContext)
        }
        self.cart!.addToToManyInventories(selectedInventory)
    }
}
