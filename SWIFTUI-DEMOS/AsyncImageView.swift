//
//  AsyncImageView.swift
//  SWIFTUI-DEMOS
//
//  Created by Suneel on 18/01/23.
//

import Foundation
import SwiftUI



/*
 - AsyncImage is view - It loads image asynchornously and load imageview ( URL Session downlaod image async and display display)
 
 
 //MARK: Basic Loading (Step-1)
 - Until the image loads, the view displays a standard placeholder that fills the available space. After the load completes successfully, the view updates to display the image
 
 
 //MARK: URL and scaling (Step-2)
 - If scaling value is more, image will look small
 - If image scaling value is less, image will look bigger
 
 
 //MARK: Custom placeholder
 - For this example, SwiftUI shows a ProgressView first/custom place holder, and then the image scaled to fit in the specified frame
 
 //MARK: Image extensions
 - You can maintain subview for multiple subviews
 
 - You can’t apply image-specific modifiers, like resizable(capInsets:resizingMode:), directly to an AsyncImage view. Instead, apply them to the downloaded image
 
 
 
 
 //MARK: Phase (Async image phases)
 
 - The current phase of the asynchronous image loading operation.
 - Use the phase to decide what to draw. For example, you can draw the loaded image if it exists, a view that indicates an error, or a placeholder
 
 
 //MARK: Transaction
 - Use a transaction to pass an animation between views in a view hierarchy
 - Animation:

 
 limitations - 15.0 or later
 
 */


struct AsyncImageViewDetails: View {
    private let imageString: String = "https://credo.academy/credo-academy@3x.png"
    
    var body: some View {
        let imageURL: URL = URL(string: imageString)!
        // Basic loadig of the Image
        //        AsyncImage(url: URL(string: imageURL))
        //            .frame(width: 300, height: 300, alignment: .center)
        
        
        
        //MARK: 2 -  Scaling
        //  AsyncImage(url: imageURL, scale: 5.0).frame(minWidth: nil, idealWidth: nil, maxWidth: 300, minHeight: nil, idealHeight: nil, maxHeight: 300, alignment: .center)
        
        
        //MARK: 3 - Custom place holder
        //        AsyncImage(url: imageURL) { downlaodedImage in
        //            downlaodedImage.imageModifiers()
        //        } placeholder: {
        //            ProgressView()
        //        }.frame(width: 200, height: 200, alignment: .center)
        
        
        
        //MARK: Phase (Async image phases)
        
        //        AsyncImage(url: imageURL) { (downloadedImagePhase) in
        //            switch downloadedImagePhase {
        //            case .success(let downloadedImage):
        //                downloadedImage.imageModifiers()
        //            case .failure(_):
        //                Image(systemName: "ant.circle.fill").iconModifiers()
        //            case .empty:
        //                Image(systemName: "photo.circle.fill").iconModifiers()
        //            @unknown default:
        //                ProgressView()
        //            }
        //        }.frame(maxWidth: 300, maxHeight: 300)
        //            .padding(40)
        
        
        
        //MARK: Animations
        let transaction = Transaction(animation: .spring())
        AsyncImage(url: imageURL, transaction: transaction) { (downloadedImagePhase) in
            
            switch downloadedImagePhase {
            case .success(let downloadedImage):
                downloadedImage.imageModifiers()
                    .transition(.slide)
                
            case .failure(_):
                Image(systemName: "ant.circle.fill").iconModifiers()
                
            case .empty:
                Image(systemName: "photo.circle.fill").iconModifiers()
                
            @unknown default:
                ProgressView()
            }
            
        }.frame(maxWidth: 300, maxHeight: 300)
        
        
                
    }
}



extension Image {
    
    func imageModifiers() -> some View  {
        self.resizable()
            .scaledToFit()
        
    }
    
    func iconModifiers() -> some View {
        self.imageModifiers()
            .foregroundColor(.red)
            .opacity(0.2)
    }
    
}
