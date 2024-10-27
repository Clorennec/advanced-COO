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

	| menu glowEffect label |
	menu := BlElement new.
	menu geometry: (BlRoundedRectangleGeometry cornerRadius: 50).
	menu extent: 1200 @ 1200.
	menu border: (BlBorder builder
			 paint: Color pink;
			 width: 5;
			 build).
	menu background: ((BlLinearGradientPaint direction: 1 @ 1)
			 from: Color darkGray
			 to: Color lightBlue).
	glowEffect := BlGaussianShadowEffect
		              color: Color pink
		              offset: 0 @ 0
		              width: 50.
	glowEffect extraShadowSpace.
	menu effect: glowEffect.
	menu position: 600 @ 75.
	label := BlTextElement new.
	label text: 'Jeu 12'.
	label fontSize: 28.
	label constraintsDo: [ :c |
		c frame horizontal alignCenter ].
	menu addChild: label.
	app blSpace root addChild: menu.
]
