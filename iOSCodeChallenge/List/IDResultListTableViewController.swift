import UIKit

class IDResultListTableViewController: UITableViewController
{
    private let resultListURL = URL(string: "https://www.mocky.io/v3/364d4f62-c183-4f12-ba16-49bfc5c820ab")!
    private var results: IDResultsDTO?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "idealista"
        
        let nib = UINib(nibName: String(describing: IDResultListTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "IDResultListTableViewCell")
        tableView.estimatedRowHeight = 240.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)

        fetchResults()
    }
    
    private func fetchResults()
    {
        var urlRequest = URLRequest(url: resultListURL)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let data = data, error == nil {
                let jsonDecoder = JSONDecoder()
                if let results = try? jsonDecoder.decode(IDResultsDTO.self, from: data) {
                    DispatchQueue.main.async {
                        self.didObtain(results: results)
                    }
                }
            } else if let _ = error {}
        }.resume()
    }
    
    private func didObtain(results: IDResultsDTO)
    {
        self.results = results
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard let results = results else { return 0 }
        
        return results.elementList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IDResultListTableViewCell", for: indexPath) as! IDResultListTableViewCell
        let elementCell = results!.elementList[indexPath.row]
        cell.fill(withResult: elementCell)

        return cell
    }
}
