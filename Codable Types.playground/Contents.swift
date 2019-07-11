/*:
 Copyright (c) 2018 Razeware LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 distribute, sublicense, create a derivative work, and/or sell copies of the
 Software in any work that is designed, intended, or marketed for pedagogical or
 instructional purposes related to programming, coding, application development,
 or information technology.  Permission for such use, copying, modification,
 merger, publication, distribution, sublicensing, creation of derivative works,
 or sale is expressly withheld.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 ---
 */
import UIKit

for image in try! [Image](fileName: "images") {
  try! image.save(directory: .documentDirectory)
}


let sticker = Sticker(name: "David Meowie",
                      birthday: DateComponents(calendar: .current, year: 1947, month: 1, day: 8).date!,
                      normalizedPosition: CGPoint(x: 0.3, y: 0.5),
                      imageName: "cat"
)

// Challenge 1: Make at least one more Sticker.

let stickerTwo = Sticker(name: "Bendji Zaks", birthday: DateComponents(calendar: .current, year: 2014, month: 1, day: 8).date!, normalizedPosition: CGPoint(x: 0.3, y: 0.5), imageName: "dog")

// Challenge 2: Combine them in one Stickers array

let stickers: [Sticker] = [sticker, stickerTwo]

do {
   let jsonURL = URL(fileURLWithPath: "stickers", relativeTo: FileManager.documentDirectoryURL.appendingPathComponent(Image.Kind.sticker.rawValue)
    ).appendingPathExtension("json")
    
    let jsonEncoder = JSONEncoder()
    jsonEncoder.outputFormatting = .prettyPrinted
    let jsonData = try jsonEncoder.encode(stickers)
    try jsonData.write(to: jsonURL)
    
    let jsonDecoder = JSONDecoder()
    let saveJSONData = try Data(contentsOf: jsonURL)
    let jsonStickers = try jsonDecoder.decode([Sticker].self, from: saveJSONData)
    
    jsonStickers == stickers
    
    jsonStickers.map( { $0.image } )
}
catch {
    print(error)
}

