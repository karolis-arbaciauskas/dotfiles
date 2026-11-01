import Carbon

// Query the active source directly; HIToolbox preferences are not reliable.
let source = TISCopyCurrentKeyboardInputSource().takeRetainedValue()
func property(_ key: CFString) -> String? {
    guard let pointer = TISGetInputSourceProperty(source, key) else { return nil }
    return Unmanaged<CFString>.fromOpaque(pointer).takeUnretainedValue() as String
}

func displayLanguage(_ language: String) -> String {
    let code = language.components(separatedBy: CharacterSet(charactersIn: "-_"))[0].uppercased()
    switch code {
    case "EN": return "🇺🇸"
    case "LT": return "🇱🇹"
    default: return code
    }
}

let id = property(kTISPropertyInputSourceID) ?? ""
if id == "com.apple.keylayout.ABC" || id == "com.apple.keylayout.US" {
    print(displayLanguage("EN"))
} else if let pointer = TISGetInputSourceProperty(source, kTISPropertyInputSourceLanguages) {
    let languages = Unmanaged<CFArray>.fromOpaque(pointer).takeUnretainedValue() as! [String]
    if let language = languages.first {
        print(displayLanguage(language))
    } else {
        print(property(kTISPropertyLocalizedName) ?? "?")
    }
} else {
    print(property(kTISPropertyLocalizedName) ?? "?")
}
