Class {
	#name : 'GameUI',
	#superclass : 'Object',
	#instVars : [
		'gameManager',
		'app'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'instance creation' }
GameUI class >> newWithApp: anApp [
    ^ self basicNew initializeWithApp: anApp
]

{ #category : 'instance creation' }
GameUI class >> newWithGameManager: aGameManager [
    ^ self new initializeWithGameManager: aGameManager
]

{ #category : 'initialization' }
GameUI >> initializeWithApp: anApp [
    app := anApp.
    ^ self
]

{ #category : 'instance creation' }
GameUI >> initializeWithGameManager: aGameManager [
    gameManager := aGameManager.
    ^ self
]

{ #category : 'as yet unclassified' }
GameUI >> showMainMenu [
	Menu showOn: app blSpace.
]
