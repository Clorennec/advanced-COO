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

	^ instance ifNil: [ instance := self basicNew initialize ]
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
	asteroid position: 50@50.
	blSpace addChild: asteroid blElement.
	gameObjects add: asteroid
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
	blSpace := BlSpace new.
	blSpace addEventHandlerOn: BlSpaceClosedEvent
		do: [ :event | self cleanup ].
	blSpace open
]

{ #category : 'as yet unclassified' }
GameManager >> startGameLoop [
    gameLoopProcess := [
        [blSpace isOpen] whileTrue: [
            self update.
            25 milliSeconds wait.
        ].
        self class reset.
    ] fork.
]

{ #category : 'initialization' }
GameManager >> update [

	gameObjects do: [ :object |
		object update.]
]
