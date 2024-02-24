# Indie Dev Game Jam #3

## Theme: One Tool, Many Uses
Link: https://itch.io/jam/indie-dev-jam-3
Time: 3 days
Timestamps:
	30min Readme

Main idea: Zelda-like game about child controlling ball of water.

Core mechanic: MC have control over ball of water, that can change it's properties, depending on player's needs.

Water ball can be used as:
	- Attack projectile icecle
	- Protective shield (dome?)
	- Fist of wall destruction / melee damage
	- ? Smoke screen to block enemy vision
	- Consumable to replenish life

Graphical style choice:
	- pixel art
	- POV: top-down-ish (Zelda-like)
	- pastel tones

Code pricicals:
	- Grid-based game
	- State-machine characters

Graphical assets to find/make:
	- Generic teen-like character
		- idle
		- walk/run
		- attacks
			- range palm-like attack
			- melee fist hit
		- death
		- life replenish (meditation?)
	- WaterBall
		- idle
		- icycle
		- ice dome
		- 
	- Background
		- walkable tiles
			- grass
			- road
		- non-walkable tiles
			- water
		- walls
			- rocks
			- rocks with cracks
	- Enemies
		- Squishy melee normal
		- Tanky melee slow 
		- Squishy ranged normal
		- Boss?
	
	
	
Code to write:
	- State-machine
		- For player
			- keep ball as separate entity
		- For enemies
		- For ball
	- Adapt movement of Characters on grid
	- Link player with ball
		// played doesnt controll ball, but signas comands, that recieved by ball