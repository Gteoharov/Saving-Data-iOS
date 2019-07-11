
import Foundation


FileManager.documentDirectoryURL.path

try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

let mysteryDataURL = URL(fileURLWithPath: "mystery", relativeTo: FileManager.documentDirectoryURL)

let mysteryBytes: [UInt8] = [
    240,          159,          152,          184,
    240,          159,          152,          185,
    0b1111_0000,  0b1001_1111,  0b1001_1000,  186,
    0xF0,         0x9F,         0x98,         187
]

let mysteryData = Data(mysteryBytes)
try mysteryData.write(to: mysteryDataURL)

let savedMysteryData = try Data(contentsOf: mysteryDataURL)
let savedMysteryBytes = Array(savedMysteryData)

savedMysteryBytes == mysteryBytes
savedMysteryData == mysteryData

try mysteryData.write(to: mysteryDataURL.appendingPathExtension("txt"))

let string = String(data: savedMysteryData, encoding: .utf8)
let stringURL = FileManager.documentDirectoryURL
    .appendingPathComponent("string")
    .appendingPathExtension("txt")

try string?.write(to: stringURL, atomically: true, encoding: .utf8)
try String(contentsOf: stringURL)

stringURL.path


// Challenge

let challengeString = "High level Swift"
let challengeStringURL = URL(
    fileURLWithPath: challengeString,
    relativeTo: FileManager.documentDirectoryURL
).appendingPathExtension("txt")

let challengeStringData = challengeString.data(using: .utf8)!
try challengeStringData.write(to: challengeStringURL, options: .atomic)
let savedChallengeString = try String(contentsOf: challengeStringURL)
