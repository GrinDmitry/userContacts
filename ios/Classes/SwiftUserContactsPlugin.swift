import Flutter
import UIKit
import Contacts

public class SwiftUserContactsPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "userContacts", binaryMessenger: registrar.messenger())
        let instance = SwiftUserContactsPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "getContacts" {
            if #available(iOS 9.0, *) {
                result(getContacts())
            }
        } else {
            result("iOS " + UIDevice.current.systemVersion)
        }
    }
    
    @available(iOS 9.0, *)
    public func getContacts() -> String? {
        let contactsObject = createContacts()
        return contactsObject
    }
    
    @available(iOS 9.0, *)
    private func createContacts() -> String? {
        var contacts = [ContactUnit]()
        
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("there was some error getting permission \(error.localizedDescription)")
            }
            
            if granted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey,
                            CNContactPhoneNumbersKey, CNContactThumbnailImageDataKey] as [CNKeyDescriptor]
                let request = CNContactFetchRequest(keysToFetch: keys)
                
                do {
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointerIfYouWantToStopEnumerating) in
                        let numbers = contact.phoneNumbers.map { $0.value.stringValue }
                        
                        let imageData = contact.thumbnailImageData?.base64EncodedString()
                        contacts.append(ContactUnit(name: contact.givenName, familyName: contact.familyName, imageData: imageData, phones: numbers))
                    })
                } catch {
                    print("Unable to fetch contacts")
                }
                
            } else {
                print("ACCESS Denied")
            }
        }
        
        let jsonString = JsonCodec.encodeToJsonString(contacts)
        return jsonString
    }
}
