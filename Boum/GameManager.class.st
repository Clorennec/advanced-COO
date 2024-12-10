Class {
	#name : 'GameManager',
	#superclass : 'Object',
	#instVars : [
		'gameObjects',
		'blSpace',
		'gameLoopProcess',
		'player',
		'asteroidGenerationProcess',
		'collisionCheckProcess',
		'pressedKeys',
		'playerControllerProcess',
		'projectiles',
		'gameUI',
		'score'
	],
	#classInstVars : [
		'instance'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'as yet unclassified' }
GameManager class >> createWithSpace: aBlSpace gameUI: aGameUI [

	^ self new initializeWithSpace: aBlSpace gameUI: aGameUI
]

{ #category : 'adding' }
GameManager >> addAsteroid: anAsteroid [

	self renderObject: anAsteroid .
	gameObjects add: anAsteroid 
]

{ #category : 'adding' }
GameManager >> addPlayerWithType: aType color: aColor [

	player := Player newType: aType color: aColor.
	player addObserver: gameUI.
	self renderObject: player.
	self setupKeyEvents.
	player currentPosition: 400 @ 300.
	gameObjects add: player.
	player notifyObservers 
]

{ #category : 'as yet unclassified' }
GameManager >> addRandomAsteroid [

	| randPos randVect asteroid |
	randPos := (1 to: 3000) atRandom @ 0 - 300.
	randVect := Random new next * 3 - 1.5 @ (Random new next * 5 + 3).

	asteroid := Asteroid new.
	asteroid currentPosition: randPos.
	asteroid velocity: randVect.

	self addAsteroid: asteroid 
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

	| toCollide toRemove notExploded |
	toCollide := Set new.
	toRemove := Set new.

	notExploded := gameObjects select: [ :obj |
		               obj ~~ player and: [ obj exploded not ] ].

	notExploded do: [ :obj |
		(player blElement boundsInSpace intersects:
			 obj blElement boundsInSpace) ifTrue: [
			(player collidesPixelPerfectWith: obj) ifTrue: [
				toCollide add: {
						player.
						obj } ] ] ].

	toCollide do: [ :collisionPair |
		collisionPair first collideWith: collisionPair second ].

	notExploded do: [ :obj |
		obj exploded ifTrue: [
			obj currentFrame >= 42 ifTrue: [ toRemove add: obj ] ] ].

	toRemove do: [ :obj |
		blSpace root removeChild: obj blElement.
		gameObjects remove: obj ]
]

{ #category : 'as yet unclassified' }
GameManager >> checkProjectilesHit [

	| toCollide notExploded toRemove projectileBounds objBounds |
	toCollide := Set new.

	notExploded := gameObjects select: [ :obj |
		               obj ~~ player and: [ obj exploded not ] ].

	projectiles do: [ :proj |
		projectileBounds := proj blElement boundsInSpace insetBy: 50.

		notExploded do: [ :obj |
			objBounds := obj blElement boundsInSpace insetBy: 15.

			(projectileBounds intersects: objBounds) ifTrue: [
				toCollide add: {
						proj.
						obj } ] ] ].

	toCollide do: [ :collisionPair |
		collisionPair first collideWith: collisionPair second ].

	toRemove := projectiles select: [ :proj | proj exploded ].
	toRemove do: [ :proj |
		self increaseScoreBy: 100.
		self removeObject: proj.
		projectiles remove: proj ]
]

{ #category : 'accessing' }
GameManager >> cleanup [

	self stopProcesses.

	gameObjects := OrderedCollection new.
	projectiles := OrderedCollection new.
	pressedKeys := Dictionary new.

	blSpace ifNotNil: [
		blSpace root ifNotNil: [ blSpace root removeChildren ] ]
]

{ #category : 'as yet unclassified' }
GameManager >> increaseScoreBy: anInteger [

	score := score + anInteger.
	gameUI updateScore: score
]

{ #category : 'initialization' }
GameManager >> initialize [

	super initialize.
	gameObjects := OrderedCollection new.
	projectiles := OrderedCollection new.
	pressedKeys := Dictionary new.
	score := 0.
	^ self
]

{ #category : 'instance creation' }
GameManager >> initializeWithSpace: aBlSpace gameUI: aGameUI [

	self initialize.
	blSpace := aBlSpace.
	gameUI := aGameUI.
	^ self
]

{ #category : 'steps - interactions' }
GameManager >> keyDown: aKey [
	pressedKeys at: aKey name put: true
]

{ #category : 'steps - interactions' }
GameManager >> keyUp: aKey [
	pressedKeys at: aKey name put: false
]

{ #category : 'initialization' }
GameManager >> playerShoot [

	| newProjectiles |
	player cooldown ifTrue: [ ^ self ].
	newProjectiles := player shoot.
	newProjectiles do: [ :projectile |
		blSpace root addChild: projectile blElement.
		projectiles add: projectile ].
	player cooldown: true.
	[
	1000 milliSeconds wait.
	player cooldown: false ] fork
]

{ #category : 'as yet unclassified' }
GameManager >> removeFarObjects [

	| objectsToRemove projectilesToRemove |
	objectsToRemove := gameObjects select: [ :o |
		                   o currentPosition y > 1400 or:
			                   o currentPosition y < -300 ].

	objectsToRemove do: [ :o |
		self removeObject: o.
		gameObjects remove: o ].

	projectilesToRemove := projectiles select: [ :p |
		                       p currentPosition y < -250 ].

	projectilesToRemove do: [ :p |
		self removeObject: p.
		projectiles remove: p ]
]

{ #category : 'rendering' }
GameManager >> removeObject: anObject [

	blSpace root removeChild: anObject blElement
]

{ #category : 'rendering' }
GameManager >> renderObject: anObject [
    blSpace root addChild: anObject blElement.
]

{ #category : 'accessing' }
GameManager >> score [
	^score
]

{ #category : 'as yet unclassified' }
GameManager >> setupKeyEvents [
	blSpace
		addEventHandlerOn: BlKeyDownEvent
		do: [ :event | self keyDown: event key ].
	blSpace
		addEventHandlerOn: BlKeyUpEvent
		do: [ :event | self keyUp: event key ].
]

{ #category : 'as yet unclassified' }
GameManager >> startAsteroidGenerationProcess [

	asteroidGenerationProcess := [
	                             [ blSpace isOpened ] whileTrue: [
		                             self addRandomAsteroid.
		                             400 milliSeconds wait ].
	                              ] fork
]

{ #category : 'as yet unclassified' }
GameManager >> startCollisionCheckProcess [

	collisionCheckProcess := [
	                         [ blSpace isOpened ] whileTrue: [
										self checkProjectilesHit.
		                         self checkCollisions.
		                         self removeFarObjects.
		                         50 milliSeconds wait ] ] fork
]

{ #category : 'as yet unclassified' }
GameManager >> startGameLoopProcess [

	self startAsteroidGenerationProcess.
	self startCollisionCheckProcess.
	self startPlayerControllerProcess.
	score := 0.
	gameLoopProcess := [
	                   [ blSpace isOpened ] whileTrue: [
		                   self update.
		                   self increaseScoreBy: 1.
		                   25 milliSeconds wait ] ] fork
]

{ #category : 'as yet unclassified' }
GameManager >> startPlayerControllerProcess [

	playerControllerProcess := [
	                           [ blSpace isOpened ] whileTrue: [
		                           self updatePlayerVelocity.
		                           (pressedKeys at: #SPACE ifAbsent: [false]) ifTrue: [self playerShoot].
		                           25 milliSeconds wait ] ] fork
]

{ #category : 'as yet unclassified' }
GameManager >> stopProcesses [

	asteroidGenerationProcess ifNotNil: [
		asteroidGenerationProcess terminate ].
	playerControllerProcess ifNotNil: [
		playerControllerProcess terminate ].
	gameLoopProcess ifNotNil: [ gameLoopProcess terminate ].
	collisionCheckProcess ifNotNil: [ collisionCheckProcess terminate ].
]

{ #category : 'initialization' }
GameManager >> update [

	| toRemove |
	toRemove := Set new.
	gameObjects do: [ :object | object update ].
	gameObjects do: [ :obj |
		obj exploded ifTrue: [
			obj currentFrame >= 42 ifTrue: [ toRemove add: obj ] ] ].
	
	projectiles do: [ :obj | 
		obj update ].

	toRemove do: [ :obj |
		blSpace root removeChild: obj blElement.
		gameObjects remove: obj ]
]

{ #category : 'as yet unclassified' }
GameManager >> updatePlayerVelocity [

	pressedKeys keysAndValuesDo: [ :key :isPressed |
		isPressed ifTrue: [ player adjustVelocity: key ]
		 ].
	
]
