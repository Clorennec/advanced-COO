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

	| displayContainer gameOverText playerNameText scoreText menuButton buttonText |
	displayContainer := BlElement new
		                    layout: BlFrameLayout new;
		                    extent: 2400 @ 1350.

	app blSpace root addChild: displayContainer.

	playerNameText := BlTextElement new
		                  text:
			                  (app activePlayerName asRopedText attributes: {
						                   (BlTextForegroundAttribute paint: Color white).
						                   (BlFontSizeAttribute size: 100) });
		                  constraintsDo: [ :c |
			                  c frame vertical alignCenter.
			                  c frame horizontal alignCenter ];
		                  transformDo: [ :t | t translateBy: 0 @ -300 ].


	gameOverText := BlTextElement new
		                text: ('Game Over' asRopedText attributes: {
						                 (BlTextForegroundAttribute paint: Color white).
						                 (BlFontSizeAttribute size: 200).
						                 BlFontWeightAttribute bold });
		                constraintsDo: [ :c |
			                c frame vertical alignCenter.
			                c frame horizontal alignCenter ].

	scoreText := BlTextElement new
		             text:
			             (('Score: ' , aScore asString) asRopedText
				              attributes: {
						              (BlTextForegroundAttribute paint: Color white).
						              (BlFontSizeAttribute size: 100) });
		             constraintsDo: [ :c |
			             c frame vertical alignCenter.
			             c frame horizontal alignCenter ];
		             transformDo: [ :t | t translateBy: 0 @ 300 ].
		
	menuButton := BlElement new extent: 200 @ 150.
	menuButton geometry: (BlRoundedRectangleGeometry cornerRadius: 25).
	menuButton constraintsDo: [ :c | c frame horizontal alignCenter ].
	menuButton background: Color pink.
	menuButton layout: BlFrameLayout new.
	menuButton
		addEventHandlerOn: BlMouseDownEvent
		do: [ :e | self showMainMenu ].
	menuButton transformDo: [ :t | t translateBy: 0 @ 950 ].

	buttonText := BlTextElement new.
	buttonText text: ('PLAY' asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color black) }).
	buttonText text fontSize: 88.
	buttonText constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	menuButton addChild: buttonText.

	displayContainer addChild: menuButton.


	displayContainer addChild: gameOverText.
	displayContainer addChild: playerNameText.
	displayContainer addChild: scoreText
]

{ #category : 'as yet unclassified' }
GameUI >> showMainMenu [

	app blSpace root removeChildren.
	Menu showOn: app
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
