# Ethereum-Signer-App
A simple app to sign text messages with Ethereum private key and to verify them. 
Also, user can see the account balance and wallet address on the **Rinkeby network**.

## Installation
1. Navigate to project directory and run `pod install` command in Terminal
2. Open and run the project

## Project Structure 
I used MVVM pattern and I created a manager for signing, validating and getting information such as wallet address and balance. 

I used CocoaPods to manage third-party library dependencies.

Also unit tests added for view models and manager and some UI tests added.


## Third-party Libs

1. `web3swift` - Native Web3 for Swift and related on Ethereum 
2. `QRCodeReader.swift` - to read QR Code
