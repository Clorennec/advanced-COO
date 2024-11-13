Class {
	#name : 'GameManager',
	#superclass : 'Object',
	#instVars : [
		'gameObjects',
		'blSpace',
		'gameLoopProcess',
		'player',
		'asteroidGenerationProcess'
	],
	#classInstVars : [
		'instance'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'as yet unclassified' }
GameManager class >> instanceWithSpace: aBlSpace [
    instance ifNil: [ 
        instance := self basicNew.
        instance initializeWithSpace: aBlSpace
    ] ifNotNil: [
        instance blSpace: aBlSpace
    ].
    ^ instance
]

{ #category : 'instance creation' }
GameManager class >> new [
    self error: 'Utilisez GameManager class>>instance pour obtenir l''instance unique.'.
]

{ #category : 'initialization' }
GameManager class >> reset [
    instance ifNotNil: [instance cleanup. instance := nil].
]

{ #category : 'adding' }
GameManager >> addAsteroid [

	| asteroid |
	asteroid := Asteroid new.
	blSpace root addChild: asteroid blElement.
	asteroid currentPosition: 200 @ 50.
	gameObjects add: asteroid
]

{ #category : 'adding' }
GameManager >> addPlayer [

	player := Player newType: 'Type1' color: 'GREEN'.
	blSpace root addChild: player blElement.
	blSpace
		addEventHandlerOn: BlKeyDownEvent
		do: [ :event | player adjustVelocityForKey: event key ].
	player currentPosition: 400 @ 300.
	gameObjects add: player
]

{ #category : 'adding' }
GameManager >> addPlayerWithType: aType color: aColor [
    Transcript show: 'blSpace: '; show: blSpace printString; cr.
    blSpace ifNil: [ self error: 'BlSpace not initialized' ].
    blSpace root ifNil: [ self error: 'BlSpace root not initialized' ].
    
    player := Player newType: aType color: aColor.
    blSpace root addChild: player blElement.
    blSpace addEventHandlerOn: BlKeyDownEvent
        do: [ :event | player adjustVelocityForKey: event key ].
    player currentPosition: 400 @ 300.
    gameObjects add: player
]

{ #category : 'as yet unclassified' }
GameManager >> addRandomAsteroid [

	| randPos randVect asteroid |
	randPos := (1 to: 3000) atRandom @ 0 - 300.
	randVect := Random new next * 3 - 1.5 @ (Random new next * 5 + 3).

	asteroid := Asteroid new.
	asteroid currentPosition: randPos.
	asteroid velocity: randVect.

	blSpace root addChild: asteroid blElement.
	gameObjects add: asteroid
]

{ #category : 'accessing' }
GameManager >> blSpace [
	blSpace ifNil: [ self error: 'blSpace is not initialized.' ].
	^ blSpace
]

{ #category : 'accessing' }
GameManager >> blSpace: aSpace [

	blSpace := aSpace 
]

{ #category : 'initialization' }
GameManager >> checkCollisions [

	| toCollide toRemove |
	toCollide := Set new.
	toRemove := Set new.
	gameObjects withIndexDo: [ :obj1 :i |
		obj1 exploded ifFalse: [
			(i + 1 to: gameObjects size) do: [ :j |
				| obj2 |
				obj2 := gameObjects at: j.
				obj2 exploded ifFalse: [
					(obj1 blElement boundsInSpace intersects:
						 obj2 blElement boundsInSpace) ifTrue: [
						(obj1 collidesPixelPerfectWith: obj2) ifTrue: [
						toCollide add: {
								obj1.
								obj2 } ] ] ] ] ] ].

	toCollide do: [ :collisionPair |
		collisionPair first collideWith: collisionPair second ].

	gameObjects do: [ :obj |
		obj exploded ifTrue: [
			obj currentFrame >= 42 ifTrue: [ toRemove add: obj ] ] ].

	toRemove do: [ :obj |
		blSpace root removeChild: obj blElement.
		gameObjects remove: obj ]
]

{ #category : 'accessing' }
GameManager >> cleanup [

	gameLoopProcess ifNotNil: [ gameLoopProcess terminate ].
	asteroidGenerationProcess ifNotNil: [ asteroidGenerationProcess terminate ].
	
	gameObjects := OrderedCollection new.

	blSpace ifNotNil: [
		blSpace root ifNotNil: [ blSpace root removeChildren ] ]
]

{ #category : 'initialization' }
GameManager >> initialize [
    super initialize.
    gameObjects := OrderedCollection new.
    ^ self
]

{ #category : 'instance creation' }
GameManager >> initializeWithSpace: aBlSpace [
    self initialize. 
    gameObjects := OrderedCollection new.
    blSpace := aBlSpace.
    ^ self
]

{ #category : 'as yet unclassified' }
GameManager >> removeFarAsteroids [
	|toRemove|
	
	toRemove := gameObjects select: [ :o | o currentPosition x > 1400 ].
    
    toRemove do: [ :o |
        o blElement removeFromParent.
        gameObjects remove: o ].
]

{ #category : 'as yet unclassified' }
GameManager >> startAsteroidGeneration [

	asteroidGenerationProcess := [
	                             [ blSpace isOpened ] whileTrue: [
		                             self addRandomAsteroid.
											 self removeFarAsteroids.
		                             400 milliSeconds wait ].
	                             self class reset ] fork
]

{ #category : 'as yet unclassified' }
GameManager >> startGameLoop [
	self startAsteroidGeneration.
	gameLoopProcess := [
	                   [ blSpace isOpened ] whileTrue: [
		                   self update.
		                   self checkCollisions.
		                   25 milliSeconds wait ].
	                   self class reset ] fork
]

{ #category : 'initialization' }
GameManager >> update [

	gameObjects do: [ :object |
		object update.]
]
