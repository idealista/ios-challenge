import UIKit

class IDResultListTableViewCell: UITableViewCell
{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        backgroundColor = .white
        selectionStyle = .none
        separatorInset = .zero
    }
    
    func fill(withResult result: IDResultDTO)
    {
        titleLabel.text = title(forResult: result)
        subtitleLabel.text = String(format: "%@ €", String(result.price ?? 0))
        
        if let multimedia = result.multimedia, let firstImageURL = multimedia.images.first?.url {
            URLSession.shared.dataTask(with: URL(string: firstImageURL)!) {
                    (data, response, error) in

                    guard let data = data, error == nil, let image = UIImage(data: data) else {
                        return
                    }

                DispatchQueue.main.sync {
                    self.photo.image = image
                }
                }.resume()
        }
    }
    
    private func title(forResult result: IDResultDTO) -> String
    {
        guard let operation = result.operation, let typology = result.propertyType else { return "" }
        
        switch (operation, typology) {
        case ("sale", "flat"):
            return "Piso en venta"
        case ("rent", "flat"):
            return "Piso en alquiler"
        case ("sale", "penthouse"):
            return "Ático en venta"
        case ("rent", "penthouse"):
            return "Ático en alquiler"
        case ("sale", "studio"):
            return "Estudio en venta"
        case ("rent", "studio"):
            return "Estudio en alquiler"
        case ("sale", "chalet"):
            return "Chalet en venta"
        case ("rent", "chalet"):
            return "Chalet en alquiler"
        case ("sale", "duplex"):
            return "Dúplex en venta"
        case ("rent", "duplex"):
            return "Dúplex en alquiler"
        default: return ""
        }
    }
}
