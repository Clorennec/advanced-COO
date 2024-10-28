Class {
	#name : 'GameApp',
	#superclass : 'Object',
	#instVars : [
		'gameManager',
		'gameUI',
		'blSpace'
	],
	#classInstVars : [
		'instance'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'accessing' }
GameApp class >> instance [
	instance ifNil: [ instance := self basicNew initialize ].
	^ instance
]

{ #category : 'accessing' }
GameApp >> blSpace [
	^blSpace
]

{ #category : 'initialization' }
GameApp >> cleanup [

	gameManager cleanup.
	blSpace root removeChildren.
	blSpace close
]

{ #category : 'initialization' }
GameApp >> initialize [

	blSpace := BlSpace new.
	blSpace extent: 2400 @ 1350.
	blSpace
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ :event | self cleanup ].
	gameManager := GameManager instanceWithSpace: blSpace.
	gameUI := GameUI newWithApp: self.
	^ self
]

{ #category : 'initialization' }
GameApp >> start [
    gameUI showMainMenu.
    blSpace show.
]

{ #category : 'initialization' }
GameApp >> startGameWithShipType: aType color: aColor [

	gameManager addPlayerWithType: aType color: aColor.
	gameManager startGameLoop
]