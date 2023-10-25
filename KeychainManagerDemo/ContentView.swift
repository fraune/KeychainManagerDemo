//
//  ContentView.swift
//  KeychainManagerDemo
//
//  Created by Brandon Fraune on 7/17/23.
//

import SwiftUI
import OktaSecureStorage
import KeychainAccess
import Valet

struct ContentView: View {
    @State var oktaSecureStorageKey = ""
    @State var oktaSecureStorageValue = ""
    @State var keychainAccessKey = ""
    @State var keychainAccessValue = ""
    @State var valetKey = ""
    @State var valetValue = ""
    
    var body: some View {
        Form {
            Section(header: Text("OktaSecureStorage")) {
                HStack {
                    Text("Key")
                    TextField("Key", text: $oktaSecureStorageKey)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                }
                HStack {
                    Text("Value")
                    TextField("Value", text: $oktaSecureStorageValue)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                }
                Button("Get") {
                    let okta = OktaSecureStorage()
                    do {
                        oktaSecureStorageValue = try okta.get(key: oktaSecureStorageKey)
                    } catch {
                        print("Okta could not get")
                    }
                }
                Button("Set") {
                    let okta = OktaSecureStorage()
                    do {
                        try okta.set(oktaSecureStorageValue, forKey: oktaSecureStorageKey)
                    } catch {
                        print("Okta could not set")
                    }
                }
            }
            Section(header: Text("KeychainAccess")) {
                HStack {
                    Text("Key")
                    TextField("Key", text: $keychainAccessKey)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                }
                HStack {
                    Text("Value")
                    TextField("Value", text: $keychainAccessValue)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                }
                Button("Get") {
                    let keychain = Keychain()
                    keychainAccessValue = keychain[keychainAccessKey] ?? ""
                }
                Button("Set") {
                    let keychain = Keychain()
                    keychain[keychainAccessKey] = keychainAccessValue
                }
            }
            Section(header: Text("Valet")) {
                HStack {
                    Text("Key")
                    TextField("Key", text: $valetKey)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                }
                HStack {
                    Text("Value")
                    TextField("Value", text: $valetValue)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                }
                Button("Get") {
                    let valet = Valet.valet(with: Identifier(nonEmpty: "Test Value")!, accessibility: .afterFirstUnlock)
                    do {
                        valetValue = try valet.string(forKey: valetKey)
                    } catch {
                        print("Valet could not get")
                    }
                }
                Button("Set") {
                    let valet = Valet.valet(with: Identifier(nonEmpty: "Test Value")!, accessibility: .afterFirstUnlock)
                    do {
                        try valet.setString(valetValue, forKey: valetKey)
                    } catch {
                        print("Valet could not set")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
