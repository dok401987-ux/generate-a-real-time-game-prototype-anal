pragma solidity ^0.8.0;

contract GamePrototypeAnalyzer {
    // Game Prototype Properties
    struct GamePrototype {
        address developer;
        string gameName;
        uint256 rating;
        uint256 playtime;
        uint256 revenue;
        uint256 numPlayers;
        string genre;
        string description;
    }

    // Mapping of Game Prototypes
    mapping(address => GamePrototype) public gamePrototypes;

    // Event emitted when a new game prototype is added
    event NewGamePrototype(address indexed developer, string gameName);

    // Event emitted when a game prototype is updated
    event UpdateGamePrototype(address indexed developer, string gameName);

    // Function to add a new game prototype
    function addGamePrototype(
        string memory _gameName,
        uint256 _rating,
        uint256 _playtime,
        uint256 _revenue,
        uint256 _numPlayers,
        string memory _genre,
        string memory _description
    ) public {
        // Only allow unique game prototypes
        require(gamePrototypes[msg.sender].developer == address(0), "Game prototype already exists");

        // Create a new game prototype
        GamePrototype memory newPrototype = GamePrototype(
            msg.sender,
            _gameName,
            _rating,
            _playtime,
            _revenue,
            _numPlayers,
            _genre,
            _description
        );

        // Add the new game prototype to the mapping
        gamePrototypes[msg.sender] = newPrototype;

        // Emit the NewGamePrototype event
        emit NewGamePrototype(msg.sender, _gameName);
    }

    // Function to update an existing game prototype
    function updateGamePrototype(
        string memory _gameName,
        uint256 _rating,
        uint256 _playtime,
        uint256 _revenue,
        uint256 _numPlayers,
        string memory _genre,
        string memory _description
    ) public {
        // Only allow updates from the original developer
        require(gamePrototypes[msg.sender].developer == msg.sender, "Only the original developer can update the game prototype");

        // Update the game prototype
        gamePrototypes[msg.sender].rating = _rating;
        gamePrototypes[msg.sender].playtime = _playtime;
        gamePrototypes[msg.sender].revenue = _revenue;
        gamePrototypes[msg.sender].numPlayers = _numPlayers;
        gamePrototypes[msg.sender].genre = _genre;
        gamePrototypes[msg.sender].description = _description;

        // Emit the UpdateGamePrototype event
        emit UpdateGamePrototype(msg.sender, _gameName);
    }

    // Function to retrieve a game prototype
    function getGamePrototype(address _developer) public view returns (GamePrototype memory) {
        return gamePrototypes[_developer];
    }
}