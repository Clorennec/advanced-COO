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
		'projectiles'
	],
	#classInstVars : [
		'instance'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'as yet unclassified' }
GameManager class >> createWithSpace: aBlSpace [
    ^ self new initializeWithSpace: aBlSpace
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

	Transcript
		show: 'blSpace: ';
		show: blSpace printString;
		cr.
	blSpace ifNil: [ self error: 'BlSpace not initialized' ].
	blSpace root ifNil: [ self error: 'BlSpace root not initialized' ].

	player := Player newType: aType color: aColor.
	blSpace root addChild: player blElement.
	blSpace
		addEventHandlerOn: BlKeyDownEvent
		do: [ :event | self keyDown: event key ].
	blSpace
		addEventHandlerOn: BlKeyUpEvent
		do: [ :event | self keyUp: event key ].
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

	| toCollide notExploded removed projectileBounds objBounds |

	toCollide := Set new.

	notExploded := gameObjects select: [ :obj |
		obj ~~ player and: [ obj exploded not ] ].

	projectiles do: [ :proj |
		projectileBounds := (proj blElement boundsInSpace) insetBy: 50.

		notExploded do: [ :obj |
			objBounds := (obj blElement boundsInSpace) insetBy: 15.

			(projectileBounds intersects: objBounds) ifTrue: [
				toCollide add: { proj. obj } ] ] ].

	toCollide do: [ :collisionPair |
		collisionPair first collideWith: collisionPair second ].

	removed := projectiles select: [ :proj | proj exploded ].
	removed do: [ :proj | projectiles remove: proj ].

]

{ #category : 'accessing' }
GameManager >> cleanup [

	gameLoopProcess ifNotNil: [ gameLoopProcess terminate ].
	asteroidGenerationProcess ifNotNil: [
		asteroidGenerationProcess terminate ].

	gameObjects := OrderedCollection new.
	pressedKeys := Dictionary new.

	blSpace ifNotNil: [
		blSpace root ifNotNil: [ blSpace root removeChildren ] ]
]

{ #category : 'initialization' }
GameManager >> initialize [

	super initialize.
	gameObjects := OrderedCollection new.
	projectiles := OrderedCollection new.
	pressedKeys := Dictionary new.
	^ self
]

{ #category : 'instance creation' }
GameManager >> initializeWithSpace: aBlSpace [

	self initialize.
	blSpace := aBlSpace.
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

	| objectsToRemove projectilesToRemove|
	objectsToRemove := gameObjects select: [ :o |
		            o currentPosition y > 1400 or:
			            o currentPosition y < -300 ].

	objectsToRemove do: [ :o |
		o blElement removeFromParent.
		gameObjects remove: o ].
	
	projectilesToRemove := projectiles select: [  :p |
		p currentPosition y < -250 ].
	
	projectilesToRemove do: [ :p | 
		p blElement removeFromParent.
		projectiles remove: p ]
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
	gameLoopProcess := [
	                   [ blSpace isOpened ] whileTrue: [
		                   self update.
		                   25 milliSeconds wait ].
	                   self class reset ] fork
]

{ #category : 'as yet unclassified' }
GameManager >> startPlayerControllerProcess [

	playerControllerProcess := [
	                           [ blSpace isOpened ] whileTrue: [
		                           self updatePlayerVelocity.
		                           (pressedKeys at: #SPACE ifAbsent: [false]) ifTrue: [self playerShoot].
		                           25 milliSeconds wait ] ] fork
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
