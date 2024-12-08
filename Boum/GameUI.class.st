Class {
	#name : 'GameUI',
	#superclass : 'Object',
	#instVars : [
		'app',
		'hud',
		'scoreDisplay',
		'heartsContainer',
		'heartImage'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'instance creation' }
GameUI class >> createWithApp: anApp [

	^ self new initializeWithApp: anApp
]

{ #category : 'initialization' }
GameUI >> initialize [

	heartImage := (Form fromFileNamed:
		               'C:\Users\louis\Downloads\pixel-heart-png.png')
		              scaledToSize: 150 @ 150
]

{ #category : 'initialization' }
GameUI >> initializeWithApp: anApp [
	
	self initialize.
	app := anApp.
	^ self
]

{ #category : 'as yet unclassified' }
GameUI >> setupHUD [

	hud := BlElement new.
	hud layout: BlFrameLayout new.
	hud size: app blSpace extent.
	app blSpace root addChild: hud.

	scoreDisplay := BlTextElement new text:
		                ('Score: ' asRopedText attributes:
			                 { (BlTextForegroundAttribute paint: Color white) }).
	scoreDisplay size: 100 @ 100.
	scoreDisplay constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignTop ].
	hud addChild: scoreDisplay.

	heartsContainer := BlElement new.
	heartsContainer size: 600 @ 200.
	heartsContainer layout: BlFlowLayout new.
	heartsContainer constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignBottom ].
	hud addChild: heartsContainer
]

{ #category : 'as yet unclassified' }
GameUI >> showGameOverScreen: aScore [

	| displayContainer test |
	displayContainer := BlElement new
		                    layout: BlFrameLayout new;
		                    extent: 2400 @ 1350.

	app blSpace addChild: displayContainer.

	test := BlTextElement new.
	test text: (app activePlayerName asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color white) }).
	displayContainer addChild: test.
]

{ #category : 'as yet unclassified' }
GameUI >> showMainMenu [

	Menu showOn: app.
	app blSpace root background: Color black
]

{ #category : 'as yet unclassified' }
GameUI >> updateHearts: hearts [

	heartsContainer removeChildren.
	
	hearts = 0 ifTrue: [ app stopGame. ].

	1 to: hearts do: [ :i |
		| heart |
		heart := BlElement new.
		heart size: heartImage extent.
		heart background: heartImage.
		heartsContainer addChild: heart ]
]

{ #category : 'as yet unclassified' }
GameUI >> updateScore: aScore [

	scoreDisplay text: (('Score: ' , aScore asString) asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color white) })
]
