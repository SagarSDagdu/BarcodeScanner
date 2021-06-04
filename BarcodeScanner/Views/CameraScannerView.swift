//
//  CameraScannerView.swift
//  BarcodeScanner
//
//  Created by Sagar Dagdu on 04/06/21.
//

import SwiftUI

struct CameraScannerView: UIViewControllerRepresentable {
    
    @Binding var scannedBarcode: String
    @Binding var alertItem: AlertItem?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(cameraScannerView: self)
    }
    
    func makeUIViewController(context: Context) -> ScannerVC {
        return ScannerVC(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {
        
    }
    
    final class Coordinator: NSObject, ScannerVCDelegate {
        private var cameraScannerView: CameraScannerView
        
        init(cameraScannerView: CameraScannerView) {
            self.cameraScannerView = cameraScannerView
        }
        
        // MARK:- Scanner Delegate
        
        func didFind(barcode: String) {
            cameraScannerView.scannedBarcode = barcode
        }
        
        func didSurface(error: CameraError) {
            cameraScannerView.alertItem = AlertItem.getAlertItem(for: error)
        }
        
    }
}
