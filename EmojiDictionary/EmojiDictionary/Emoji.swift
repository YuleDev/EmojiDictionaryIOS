import Foundation

struct Emoji: Codable {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    static var archiveUrl: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appending(component: "emoji_data.plist")
    }
    
    static func saveToFile(emojis: [Emoji]){
        let encoder = PropertyListEncoder()
        let encodedEmoji = try? encoder.encode(emojis)
        
        try? encodedEmoji?.write(to: archiveUrl, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Emoji]? {
        let decoder = PropertyListDecoder()
        
        if let retrievedEmojiData = try? Data(contentsOf: archiveUrl),
           let decodedEmoji = try? decoder.decode([Emoji].self, from: retrievedEmojiData) {
             return decodedEmoji
        }
        return nil
    }
}
