Class {
	#name : 'GameApp',
	#superclass : 'Object',
	#instVars : [
		'gameManager',
		'gameUI',
		'blSpace',
		'activePlayerName',
		'leaderboard'
	],
	#classInstVars : [
		'instance'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'execution' }
GameApp class >> play [

	^ self new start
]

{ #category : 'accessing' }
GameApp >> activePlayerName [
	^activePlayerName 
]

{ #category : 'accessing' }
GameApp >> activePlayerName: aName [
	activePlayerName := aName 
]

{ #category : 'accessing' }
GameApp >> blSpace [
	^blSpace
]

{ #category : 'accessing' }
GameApp >> cleanup [

	gameManager ifNotNil: [ gameManager cleanup ].
	blSpace ifNotNil: [
		blSpace root ifNotNil: [ blSpace root removeChildren ] ]
]

{ #category : 'initialization' }
GameApp >> clearDisplay [
	blSpace root removeChildren
]

{ #category : 'as yet unclassified' }
GameApp >> getHighScores [
	^ leaderboard scores.
]

{ #category : 'initialization' }
GameApp >> initialize [

	super initialize.
	self setupBlSpace.
	leaderboard := Leaderboard new.
	gameUI := GameUI createWithApp: self.
	activePlayerName := 'DefaultPlayer'.
	^ self
]

{ #category : 'as yet unclassified' }
GameApp >> setupBlSpace [

	blSpace := BlSpace new.
	blSpace root background: Color black.
	blSpace extent: 2400 @ 1350.
	blSpace position: 0@45.
	blSpace
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ :event | self cleanup ]
]

{ #category : 'initialization' }
GameApp >> showMainMenu [ 
	gameUI showMainMenu .
]

{ #category : 'initialization' }
GameApp >> start [

	blSpace show.
	gameManager ifNotNil: [ gameManager cleanup. ].
	self showMainMenu
]

{ #category : 'initialization' }
GameApp >> startGameWithShipType: aType color: aColor [

	blSpace root background: Color black.
	gameManager := GameManager createWithSpace: blSpace gameUI: gameUI.
	gameUI setupHUD.
	gameManager addPlayerWithType: aType color: aColor.
	gameManager startGameLoopProcess
]

{ #category : 'as yet unclassified' }
GameApp >> stopGame [

	self cleanup.
	leaderboard addScore: gameManager score playerName: activePlayerName.
	gameUI showGameOverScreen: gameManager score
]
