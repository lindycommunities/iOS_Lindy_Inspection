//
//  File.swift
//  MySports Pro
//
//  Created by S S D on 27/02/17.
//  Copyright © 2017 Bonnie Jaiswal. All rights reserved.
//

import Foundation
import VzaarSwift

@objc protocol VzaarVideoClassProgressDelegate {
    func vzaarVideoUploadProgress(progress: Double)
}

@objc class VzaarVideoClass:NSObject,VzaarUploadProgressDelegate{
    
    var delegate: VzaarVideoClassProgressDelegate?

    func vzaarUploadProgress(progress: Double) {
      //  let percentageString = String(Int(progress*100))
        
        delegate?.vzaarVideoUploadProgress(progress: progress)

        
//        loadingView.percentageLabel.text = "\(percentageString)%"
    }

    
    func uploadVideo(name: String, fileURLWithPath: URL,success: @escaping (_ videos:VzaarVideo) -> Void,
    failure: @escaping (_ error:VzaarError?) -> Void,
    noResponse: @escaping (_ error:Error?) -> Void){
    
        let singlePartVideoSignatureParameters = VzaarSinglePartVideoSignatureParameters()
        singlePartVideoSignatureParameters.filename = name
        
        let directory = NSTemporaryDirectory()
        let lastPathComponent = (fileURLWithPath.absoluteString as NSString).lastPathComponent
        let fullPath = directory + lastPathComponent
        let fileURLPath = URL(fileURLWithPath: fullPath)
        
        Vzaar.sharedInstance().uploadVideo(uploadProgressDelegate: self,
                                           singlePartVideoSignatureParameters: singlePartVideoSignatureParameters,
                                           fileURLPath: fileURLPath,
                                           success: { (video) in
                                            
                                            DispatchQueue.main.async {
                                                
                                                success(video!)

                                                
                                            }
                                            
                                            
        }, failure: { (vzaarError) in
            DispatchQueue.main.async {
                
                failure(vzaarError)

            }
            if let vzaarError = vzaarError{
                if let errors = vzaarError.errors{
                    print(errors)
                }
            }
        }) { (error) in
            DispatchQueue.main.async {
                
                noResponse(error)

                
            }
            if let error = error{
                print(error)
            }
        }
    }
    
    
}
