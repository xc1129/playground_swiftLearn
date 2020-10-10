struct Player {
    static var allPlayers: [Player] = []
    
    
    var name:String
    var livesRemaing = 5 {
        willSet {
            print("alert! \(newValue) remains")
        }
        didSet {
            if livesRemaing != 0 {
                print("relive with full health")
            } else {
                print("game over")
            }
        }
    }
    let maxHealth = 100
    lazy var currentHealth = maxHealth
    var inventoryItems: [inventoryItem] = []
    var isPlayerOutOfLives: Bool {
        get {
            livesRemaing == 0 ? true : false
        }
        set {
            if newValue {
                livesRemaing = 0
            }
        }
    }
    init(name: String) {
        self.name = name
    }
    
    init(name: String, livesRemaing: Int, currentHealth: Int) {
        self.name = name
        self.livesRemaing = livesRemaing
        self.currentHealth = currentHealth
    }
    
    init(name: String, livesRemaing: Int) {
        self.name = "VIP" + name
        self.livesRemaing = livesRemaing
        currentHealth = 10000
    }
    
    mutating func welcomePlayer()  {
        print("current player is \(name), livesRemaing \(livesRemaing), current health is \(currentHealth)")
    }
    
    mutating func damaged(by health: Int) {
        currentHealth -= health
        
        if currentHealth <= 0 && livesRemaing > 0 {
            livesRemaing -= 1
            currentHealth = maxHealth
        }
        
        if livesRemaing == 0 {
            print("game over")
        }
    }
    
    mutating func stateReport() {
        print("current health is \(currentHealth), player have \(livesRemaing) lives")
    }
    
    static func recentAddedPlayer() -> Player{
        allPlayers[allPlayers.count - 1]
    }
    
    mutating func addItem(name: String, description: String, bonusHealth: Int) {
        let newItem = inventoryItem(name: name, description: description, bonusHealth: bonusHealth)
        inventoryItems.append(newItem)
    }
    
    mutating func consumeItem(at itemIndex: Int) {
        currentHealth += self.inventoryItems[itemIndex - 1].bonusHealth
    }
}


struct inventoryItem {
    var name: String
    var description: String
    let bonusHealth: Int
    
}



var playerWang = Player(name: "wang", livesRemaing: 10)
var playerZhou = Player(name: "zhou")
Player.allPlayers.append(contentsOf: [playerWang, playerZhou])
playerZhou.addItem(name: "apple1", description: "one apple", bonusHealth: 50)

playerZhou.damaged(by: 100)
playerZhou.damaged(by: 90)
playerZhou.consumeItem(at: 1)
playerZhou.stateReport()
