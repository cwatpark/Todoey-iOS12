
import UIKit
import CoreData

class CatagoryViewController: UITableViewController {

    var categotyArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        self.loadCategory()
        
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categotyArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let categoryL = categotyArray[indexPath.row]
        
        cell.textLabel?.text = categoryL.name
        
        return cell
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var TxtfieldCate = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = TxtfieldCate.text!
            self.categotyArray.append(newCategory)
            self.saveCategory()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create Category"
            TxtfieldCate = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
        
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Select : \(indexPath.row)")
        print("Data : \((categotyArray[indexPath.row].name ?? "" ))")
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categotyArray[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    func saveCategory(){
        do{
            try context.save()
        }catch{
            print("Context cant save : \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest() ){
        
        //let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do{
            categotyArray = try context.fetch(request)
        }catch{
            print("Cant fetch data from coredata : \(error)")
        }
        self.tableView.reloadData()
    }
    
    
}
