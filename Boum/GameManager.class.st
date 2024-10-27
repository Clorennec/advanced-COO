Class {
	#name : 'GameManager',
	#superclass : 'Object',
	#instVars : [
		'gameObjects',
		'blSpace',
		'gameLoopProcess',
		'player'
	],
	#classInstVars : [
		'instance'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'accessing' }
GameManager class >> instance [

	instance ifNil: [ instance := self basicNew initialize ].
	instance blSpace ifNil: [ instance initialize ]. 
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

	player := Player newType: 'Type1' color: ''.
	blSpace root addChild: player blElement.
	blSpace addEventHandlerOn: BlKeyDownEvent
		do: [ :event | player adjustVelocityForKey: event key ].
	player currentPosition: 400 @ 300.
	gameObjects add: player
]

{ #category : 'accessing' }
GameManager >> blSpace [
	^ blSpace 
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

    gameLoopProcess ifNotNil: [gameLoopProcess terminate].
    gameObjects := nil.
    blSpace close.
    blSpace := nil.
]

{ #category : 'initialization' }
GameManager >> initialize [

	gameObjects := OrderedCollection new.
	blSpace ifNil: [
		blSpace := BlSpace new.
		blSpace extent: 2400@1350.
		blSpace
			addEventHandlerOn: BlSpaceClosedEvent
			do: [ :event | self cleanup ].
		blSpace show ].
	^ self
]

{ #category : 'as yet unclassified' }
GameManager >> startGameLoop [

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
