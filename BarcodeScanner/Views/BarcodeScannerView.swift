//
//  BarcodeScannerView.swift
//  BarcodeScanner
//
//  Created by Sagar Dagdu on 04/06/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: String
    var message: String
    var dismissButton: Alert.Button
    
    static func getAlertItem(for cameraError: CameraError) -> AlertItem {
        var title = ""
        var message = ""
        
        switch cameraError {
        case .invalidDeviceInput:
            title = "Invalid Device Input"
            message = "Could not get input from camera"
        case .invalidScannedValue:
            title = "Invalid Scanned Value"
            message = "The scanner supports only EAN8, EAN13 barcode formats"
        }
        
        return AlertItem(title: title, message: message, dismissButton: .default(Text("OK")))
    }
}

struct BarcodeScannerView: View {
    
    @State var scannedBarcode = ""
    @State var alertItem: AlertItem?
    
    var body: some View {
        NavigationView {
            VStack {
                CameraScannerView(scannedBarcode: $scannedBarcode, alertItem: $alertItem)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                Spacer().frame(height: 60)
                Label("Scanned Barcode:", systemImage: "barcode.viewfinder").font(.title)
                Text(scannedBarcode)
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .padding()
            }
            .alert(item: $alertItem, content: { alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: alertItem.dismissButton)
            })
            .navigationTitle("Barcode Scanner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScannerView()
            .preferredColorScheme(.dark)
    }
}
