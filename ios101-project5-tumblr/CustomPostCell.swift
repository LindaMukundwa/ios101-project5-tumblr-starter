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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
    }
    
    // Making cell look better
    override func awakeFromNib() {
        super.awakeFromNib()
        postImageView.contentMode = .scaleAspectFill  // Fill image area, crop if needed
        postImageView.clipsToBounds = true            // Prevent overflow
        summaryLabel.numberOfLines = 0                // Allow multiline text
        
        summaryLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
 
        // Add margin to label
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            summaryLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 12),
            summaryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
}
