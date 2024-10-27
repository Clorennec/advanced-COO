Class {
	#name : 'GameManager',
	#superclass : 'Object',
	#instVars : [
		'gameObjects',
		'blSpace',
		'gameLoopProcess'
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
	asteroid currentPosition: 50 @ 50.
	gameObjects add: asteroid
]

{ #category : 'adding' }
GameManager >> addPlayer [

	| player |
	player := Player newType: 'Type1' color: ''.
	blSpace root addChild: player blElement.
	player currentPosition: 400 @ 300.
	gameObjects add: player
]

{ #category : 'accessing' }
GameManager >> blSpace [
	^ blSpace 
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
		                   25 milliSeconds wait ].
	                   self class reset ] fork
]

{ #category : 'initialization' }
GameManager >> update [

	gameObjects do: [ :object |
		object update.]
]
