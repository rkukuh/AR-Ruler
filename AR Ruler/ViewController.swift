//
//  ViewController.swift
//  AR Ruler
//
//  Created by R. Kukuh on 23/01/18.
//  Copyright © 2018 R. Kukuh. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("########## \n \(touches) \n ##########")
        
        if let touchLocation = touches.first?.location(in: sceneView) {
            
            let locations = sceneView.hitTest(touchLocation, types: .featurePoint)
            
            if let location = locations.first {
                
                addCircle(at: location)
            }
        }
    }
    
    func addCircle(at location : ARHitTestResult) {
        
        let circle = SCNSphere(radius: 0.005)
        let material = SCNMaterial()
        
        material.diffuse.contents = UIColor.red
        circle.materials = [material]
        
        let circleNode = SCNNode(geometry: circle)
        
        circleNode.position = SCNVector3(
            x: location.worldTransform.columns.3.x,
            y: location.worldTransform.columns.3.y,
            z: location.worldTransform.columns.3.z
        )
        
        sceneView.scene.rootNode.addChildNode(circleNode)
    }
}
