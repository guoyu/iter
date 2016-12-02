//
//  ITBarCodeScanViewController.swift
//  ITer
//
//  Created by salmon on 16/11/11.
//  Copyright © 2016年 giv. All rights reserved.
//

import UIKit
import AVFoundation
import RKDropdownAlert

protocol ITScanDelegate: AnyObject {
    func succeedWithCodeString(_ str: String)
}

/*
 iOS7.0之后 iOS系统支持识别二维码和条形码
 */
class ITBarCodeScanViewController: UIViewController {
    
    
    weak var delegate: ITScanDelegate?
    
    fileprivate var hint: Bool = false
    fileprivate var highlightView: UIView!
    
    fileprivate var captureSession: AVCaptureSession!
    fileprivate var captureDevice: AVCaptureDevice!
    fileprivate var captureDeviceInput: AVCaptureDeviceInput!
    fileprivate var captureMetadataOutput: AVCaptureMetadataOutput!
    fileprivate var previewLayer: AVCaptureVideoPreviewLayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCapture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hint = false
        captureSession.startRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        captureSession.stopRunning()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func initCapture() {
        captureSession = AVCaptureSession()
        captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        do {
            captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(captureDeviceInput)
            captureMetadataOutput = AVCaptureMetadataOutput()
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
            captureSession.addOutput(captureMetadataOutput)
            captureMetadataOutput.metadataObjectTypes = captureMetadataOutput.availableMetadataObjectTypes
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = self.view.bounds
            previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            self.view.layer.addSublayer(previewLayer)
        } catch {
            RKDropdownAlert.title("未能初始化扫描", time: 2)
        }
        
        highlightView = UIView(frame: CGRect.zero)
        highlightView.layer.borderColor = UIColor.green.cgColor
        highlightView.layer.borderWidth = 3
        self.view.addSubview(highlightView)
    }
    
    fileprivate func reset() {
        captureSession.stopRunning()
        highlightView.frame = CGRect.zero
        hint = false
        captureSession.startRunning()
    }
}

extension ITBarCodeScanViewController: AVCaptureMetadataOutputObjectsDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        var highlightViewRect: CGRect = CGRect.zero
        let barCodeTypes: [String] = [
            AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code, AVMetadataObjectTypeEAN13Code,
            AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypePDF417Code,
            AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode
        ]
        for metadata in metadataObjects {
            if let data: AVMetadataObject = metadata as? AVMetadataObject {
                if barCodeTypes.contains(data.type) {
                    if let barCodeObject = previewLayer.transformedMetadataObject(for: data) as? AVMetadataMachineReadableCodeObject {
                        highlightViewRect = barCodeObject.bounds
                        if !hint {
                            hint = true
                            debugPrint(barCodeObject.stringValue)
                            delegate?.succeedWithCodeString(barCodeObject.stringValue)
                            if let _ = self.navigationController {
                                let _ = self.navigationController?.popViewController(animated: true)
                            } else {
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                        break
                    }
                }
            }
        }
        highlightView.frame = highlightViewRect
    }
}
