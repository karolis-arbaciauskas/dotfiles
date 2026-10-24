import Carbon

// Query the active source directly; HIToolbox preferences are not reliable.
let source = TISCopyCurrentKeyboardInputSource().takeRetainedValue()
func property(_ key: CFString) -> String? {
    guard let pointer = TISGetInputSourceProperty(source, key) else { return nil }
    return Unmanaged<CFString>.fromOpaque(pointer).takeUnretainedValue() as String
}

let id = property(kTISPropertyInputSourceID) ?? ""
if id == "com.apple.keylayout.ABC" || id == "com.apple.keylayout.US" {
    print("EN")
} else if let pointer = TISGetInputSourceProperty(source, kTISPropertyInputSourceLanguages) {
    let languages = Unmanaged<CFArray>.fromOpaque(pointer).takeUnretainedValue() as! [String]
    if let language = languages.first {
        print(language.components(separatedBy: CharacterSet(charactersIn: "-_"))[0].uppercased())
    } else {
        print(property(kTISPropertyLocalizedName) ?? "?")
    }
} else {
    print(property(kTISPropertyLocalizedName) ?? "?")
}
