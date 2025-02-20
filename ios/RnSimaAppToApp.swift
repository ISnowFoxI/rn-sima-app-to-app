import NitroModules
import CryptoKit
import CommonCrypto

class RnSimaAppToApp: HybridRnSimaAppToAppSpec {
  var SIMA_SCHEME = "sima"
  var SIMA_URL = "https://apps.apple.com/us/app/si-ma-beta/id1602500636" // Sima App store fallback URL
  var SIGN_CHALLENGE_OPERATION = "sign-challenge" // operation type to sign challenge

  var EXTRA_RETURN_SCHEME_FIELD = "scheme"
  var EXTRA_CHALLENGE_FIELD = "challenge"
  var EXTRA_SIGNATURE_FIELD = "signature"
  var EXTRA_SERVICE_FIELD = "service-name"
  var EXTRA_LOGO_FIELD = "service-logo"
  var EXTRA_USER_CODE_FIELD = "user-code"
  var EXTRA_CLIENT_ID_FIELD = "client-id"
  var EXTRA_REQUEST_ID_FIELD = "request-id"
      
  var EXTRA_RETURN_SCHEME_VALUE = "" // your app scheme
  var EXTRA_CLIENT_ID_VALUE: Double = 1 // your client id
  var EXTRA_SERVICE_VALUE = "" // service name to be displayed
  var EXTRA_USER_CODE_VALUE = "" // user FIN code
  var CLIENT_MASTER_KEY = "" // your master key
  var EXTRA_LOGO_VALUE = ""; // Image to be displayed in popup, max 500KB
  
  func setDataForSimaSignInChallenge(data: SimaData) throws -> String {
    EXTRA_RETURN_SCHEME_VALUE = data.scheme
    EXTRA_CLIENT_ID_VALUE = data.clientId
    EXTRA_SERVICE_VALUE = data.serviceName
    EXTRA_USER_CODE_VALUE = data.userPinCode
    EXTRA_LOGO_VALUE = data.logo;
    CLIENT_MASTER_KEY = data.masterKey
    
    
    var randomBytes = Data(count: 64)
      
    let challenge = Data(randomBytes)

    let hash = Data(SHA256.hash(data: challenge))
    let key = SymmetricKey(data: CLIENT_MASTER_KEY.data(using: .utf8)!)
    let signature = HMAC<SHA256>.authenticationCode(for: hash, using: key)

    let requestId = UUID().uuidString

    var components = URLComponents()
    components.scheme = SIMA_SCHEME
    components.host = SIGN_CHALLENGE_OPERATION
    components.path = ""
    components.queryItems = [
        URLQueryItem(name: EXTRA_RETURN_SCHEME_FIELD, value: EXTRA_RETURN_SCHEME_VALUE),
        URLQueryItem(name: EXTRA_CHALLENGE_FIELD, value: challenge.base64EncodedString()),
        URLQueryItem(name: EXTRA_SERVICE_FIELD, value: EXTRA_SERVICE_VALUE),
        URLQueryItem(name: EXTRA_CLIENT_ID_FIELD, value: String(EXTRA_CLIENT_ID_VALUE)),
        URLQueryItem(name: EXTRA_SIGNATURE_FIELD, value: Data(signature).base64EncodedString()),
        URLQueryItem(name: EXTRA_LOGO_FIELD, value: EXTRA_LOGO_VALUE),
        URLQueryItem(name: EXTRA_REQUEST_ID_FIELD, value: requestId)]
          
    return components.url?.absoluteString ?? ""
  }
}
