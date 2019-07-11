import UIKit

public struct Scene: Codable, Equatable {
    public init(
        width: Int,
        hasReverseGravity: Bool,
        backgroundName: String,
        stickers: [Sticker]
        ) {
        self.width = width
        self.hasReverseGravity = hasReverseGravity
        self.backgroundName = backgroundName
        self.stickers = stickers
    }
    
    public let width: Int
    public let hasReverseGravity: Bool
    public let backgroundName: String
    public let stickers: [Sticker]
}

//MARK: public
public extension Scene {
    var background: UIImage? {
        return Image.getPNGFromDocumentDirectory(kind: .scene, name: backgroundName)
    }
    
    var view: UIImageView? {
        guard let background = background
            else { return nil }
        
        let sceneWidth = CGFloat(width)
        let sceneHeight = background.size.height / background.size.width * sceneWidth
        
        let sceneView = UIImageView(
            frame: CGRect(
                x: 0, y: 0,
                width: sceneWidth, height: sceneHeight
            )
        )
        sceneView.image = background
        
        for sticker in stickers {
            guard let stickerImage = sticker.image
                else { continue }
            
            let size = stickerImage.size
            let height = sceneHeight / 3
            let view = UIImageView(
                frame: CGRect(
                    x: sticker.normalizedPosition.x * sceneWidth,
                    y: sticker.normalizedPosition.y * sceneHeight,
                    width: size.width / size.height * height,
                    height: height
                )
            )
            view.image = stickerImage
            view.transform = CGAffineTransform(
                rotationAngle: hasReverseGravity ? .pi : 0
            )
            
            sceneView.addSubview(view)
        }
        
        return sceneView
    }
}
