//
//  ViewController.swift
//  ARColorGrading
//
//  Created by Toshihiro Goto on 2018/10/02.
//  Copyright © 2018 Toshihiro Goto. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    // Color Grading Camera
    private var cgCamera: SCNCamera!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/max.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // Setup Color Grading
        cgCamera = sceneView.pointOfView?.camera
        cgCamera.colorGrading.contents = UIImage(named:"lut001.png")
        cgCamera.colorGrading.intensity = 1.0

//        if let cgCamera = sceneView.pointOfView?.camera {
//            cgCamera.colorGrading.contents = UIImage(named:"lut001.png")
//            cgCamera.colorGrading.intensity = 1.0
//        }
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

    // Action: Segment Controller
    @IBAction func colorGrading(_ sender: UISegmentedControl) {
        let lut: UIImage?
        
        switch sender.selectedSegmentIndex {
        case 0:
            lut = nil
        case 1:
            lut = UIImage(named:"lut001.png")
        case 2:
            lut = UIImage(named:"lut002.png")
        default:
            lut = nil
        }
        
        cgCamera.colorGrading.contents = lut
    }
    
    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
