Class {
	#name : 'GameUI',
	#superclass : 'Object',
	#instVars : [
		'app',
		'hud',
		'scoreDisplay'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'instance creation' }
GameUI class >> createWithApp: anApp [

	^ self new initializeWithApp: anApp
]

{ #category : 'initialization' }
GameUI >> initializeWithApp: anApp [
    app := anApp.
    ^ self
]

{ #category : 'as yet unclassified' }
GameUI >> setupHUD [

	hud := BlElement new.
	hud size: app blSpace extent.
	app blSpace root addChild: hud.

	scoreDisplay := BlTextElement new text: ('Score: ' asRopedText attributes:
			                 { (BlTextForegroundAttribute paint: Color white) }).
	scoreDisplay size: 100@100.
	hud addChild: scoreDisplay
]

{ #category : 'as yet unclassified' }
GameUI >> showMainMenu [

	Menu showOn: app
]

{ #category : 'as yet unclassified' }
GameUI >> updateScore: aScore [

	scoreDisplay text: (('Score: ' , aScore asString) asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color white) })
]
