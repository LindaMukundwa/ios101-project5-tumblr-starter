//
//  CustomPostCell.swift
//  ios101-project5-tumblr
//
//  Created by Linda  Mukundwa on 02/04/2025.
//

// CustomPostCell.swift
import UIKit

class CustomPostCell: UITableViewCell {
    
    // Outlets for UI elements
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    
    // Configure cell appearance (optional)
    override func awakeFromNib() {
        super.awakeFromNib()
        postImageView.contentMode = .scaleAspectFill  // Fill image area, crop if needed
        postImageView.clipsToBounds = true            // Prevent overflow
        summaryLabel.numberOfLines = 0                // Allow multiline text
    }
}
