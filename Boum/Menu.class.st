Class {
	#name : 'Menu',
	#superclass : 'Object',
	#instVars : [
		'blSpace',
		'blElement',
		'menu',
		'title',
		'spaceshipSelector',
		'spaceshipPreview',
		'currentSpaceship',
		'spaceshipColors',
		'colorSelector',
		'colorPreview',
		'currentColorIndex',
		'playButton',
		'app',
		'playerNameInput',
		'activePlayerName'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'drawing' }
Menu class >> showOn: anApp [

	| menu |
	menu := self new.
	menu app: anApp.
	menu blSpace: anApp blSpace.
	menu setupElements.
	menu showOn: anApp .
	^ menu
]

{ #category : 'drawing' }
Menu >> app: anApp [
	app := anApp
]

{ #category : 'accessing' }
Menu >> blSpace: aBlSpace [
	blSpace := aBlSpace 
]

{ #category : 'as yet unclassified' }
Menu >> createCircle [

	| circle |
	circle := BlElement new
		          background: Color black;
		          border: (BlBorder paint: Color pink width: 2);
		          layout: BlFrameLayout new;
		          geometry: BlCircleGeometry new.
	circle constraintsDo: [  :c | c frame vertical alignCenter ].
	^ circle
]

{ #category : 'as yet unclassified' }
Menu >> getSpaceshipImage [

	| imagePath image |
	imagePath := ((SpaceshipSprite spaceshipConfigurations at:
		               'Type' , currentSpaceship asString) at: 'path')
	             , (spaceshipColors at: currentColorIndex) , '.png'.
	image := Form fromFileNamed: imagePath.
	^ image
]

{ #category : 'initialization' }
Menu >> initialize [

	currentSpaceship := 1.
	currentColorIndex := 1.
	spaceshipColors := { 'RED'. 'GREEN'. 'NAVY BLUE'. 'ORANGE'. 'PURPLE'.
	                   'YELLOW' }.
	activePlayerName := 'DefaultPlayer'
]

{ #category : 'as yet unclassified' }
Menu >> nextColor [

	currentColorIndex := currentColorIndex \\ 6 + 1.
	spaceshipPreview background: self getSpaceshipImage.
	colorPreview text: ((spaceshipColors at: currentColorIndex) asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color white) }).
]

{ #category : 'as yet unclassified' }
Menu >> nextSpaceship [
    currentSpaceship := (currentSpaceship \\ 6) + 1.
    spaceshipPreview background: self getSpaceshipImage

]

{ #category : 'as yet unclassified' }
Menu >> previousColor [

	currentColorIndex := currentColorIndex - 2 \\ 6 + 1.
	spaceshipPreview background: self getSpaceshipImage.
	colorPreview text: ((spaceshipColors at: currentColorIndex) asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color white) }).
]

{ #category : 'as yet unclassified' }
Menu >> previousSpaceship [

	currentSpaceship := currentSpaceship - 2 \\ 6 + 1.
	spaceshipPreview background: self getSpaceshipImage
]

{ #category : 'as yet unclassified' }
Menu >> setupColorSelector [

	| leftButton leftArrow rightButton rightArrow |
	colorSelector := BlElement new
		                 extent: 800 @ 300;
		                 layout: BlFrameLayout new.
	colorSelector constraintsDo: [ :c | c frame horizontal alignCenter ].
	colorSelector transformDo: [ :t | t translateBy: 0 @ 650 ].


	leftButton := self createCircle.
	leftButton constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignCenter ].

	leftArrow := BlTextElement new text: ('<' asRopedText attributes:
			              { (BlTextForegroundAttribute paint: Color pink) }).
	leftArrow text fontSize: 55.
	leftArrow constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	leftButton
		addEventHandlerOn: BlClickEvent
		do: [ :e | self previousColor ].
	leftButton addChild: leftArrow.

	rightButton := self createCircle.
	rightButton constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignCenter ].

	rightArrow := BlTextElement new text: ('>' asRopedText attributes:
			               { (BlTextForegroundAttribute paint: Color pink) }).
	rightArrow text fontSize: 55.
	rightArrow constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	rightButton
		addEventHandlerOn: BlClickEvent
		do: [ :e | self nextColor ].
	rightButton addChild: rightArrow.

	colorPreview := BlTextElement new.
	colorPreview text:
		((spaceshipColors at: currentColorIndex) asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color white) }).
	colorPreview constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	colorSelector addChild: leftButton.
	colorSelector addChild: rightButton.
	colorSelector addChild: colorPreview.

	menu addChild: colorSelector
]

{ #category : 'as yet unclassified' }
Menu >> setupElements [

	blElement := BlElement new
		             extent: blSpace extent;
		             layout: BlFrameLayout new.

	self setupMenu.

	self setupTitle.
	self setupSpaceshipSelector.
	self setupColorSelector.
	self setupPlayButton.
	self setupPlayerNameInput.
	self setupLeaderboardDisplay.
	blElement background: Color black
]

{ #category : 'as yet unclassified' }
Menu >> setupLeaderboardDisplay [

	| leaderboard leaderboardTitle scoresListItem scores |
	scores := app getHighScores.
	leaderboard := BlElement new
		               extent: 400 @ 1000;
		               layout: BlFrameLayout new.
	leaderboard constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignLeft ].
	leaderboard transformDo: [ :t | t translateBy: 100 @ 0 ].

	leaderboardTitle := BlTextElement new.
	leaderboardTitle text: ('Leaderboard' asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color white) }).
	leaderboardTitle text fontSize: 40.
	leaderboard addChild: leaderboardTitle.

	scores do: [ :score |
		| entry |
		scoresListItem := BlTextElement new.
		entry := (score at: 'name') , '     -     '
		         , (score at: 'score' asString).
		scoresListItem text: (entry asRopedText attributes:
				 { (BlTextForegroundAttribute paint: Color white) }).
		scoresListItem text fontSize: 20.
		leaderboard addChild: scoresListItem ].

	blElement addChild: leaderboard
]

{ #category : 'initialization' }
Menu >> setupMenu [

	| glowEffect |
	menu := BlElement new
		        extent: 1200 @ 1200;
		        layout: BlFrameLayout new;
		        geometry: (BlRoundedRectangleGeometry cornerRadius: 50).
	menu border: (BlBorder builder
			 paint: Color pink;
			 width: 5;
			 build).
	menu background: ((BlLinearGradientPaint direction: 1 @ 1)
			 from: Color darkGray
			 to: Color lightBlue).
	menu constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	glowEffect := BlGaussianShadowEffect
		              color: Color pink
		              offset: 0 @ 0
		              width: 50.
	glowEffect extraShadowSpace.
	menu effect: glowEffect.

	blElement addChild: menu
]

{ #category : 'as yet unclassified' }
Menu >> setupPlayButton [

	| buttonText |
	playButton := BlElement new extent: 200 @ 150.
	playButton geometry: (BlRoundedRectangleGeometry cornerRadius: 25).
	playButton constraintsDo: [ :c | c frame horizontal alignCenter ].
	playButton background: Color pink.
	playButton layout: BlFrameLayout new.
	playButton addEventHandlerOn: BlMouseDownEvent do: [ :e | self startGame].
	playButton transformDo: [ :t | t translateBy: 0 @ 950 ].

	buttonText := BlTextElement new.
	buttonText text: ('PLAY' asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color black) }).
	buttonText text fontSize: 88.
	buttonText constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	playButton addChild: buttonText.

	menu addChild: playButton
]

{ #category : 'as yet unclassified' }
Menu >> setupPlayerNameInput [

	playerNameInput := ToTextField new
		                   placeholderText: 'Enter you username here';
		                   extent: 400 @ 50.
	playerNameInput constraintsDo: [ :c | c frame horizontal alignCenter ].
	playerNameInput transformDo: [ :t | t translateBy: 0 @ 150 ].
	menu addChild: playerNameInput
]

{ #category : 'as yet unclassified' }
Menu >> setupSpaceshipSelector [

	| leftButton leftArrow rightButton rightArrow spaceshipImage |
	spaceshipSelector := BlElement new
		                     extent: 800 @ 500;
		                     layout: BlFrameLayout new.
	spaceshipSelector constraintsDo: [ :c |
		c frame horizontal alignCenter ].
	spaceshipSelector transformDo: [ :t | t translateBy: 0 @ 150 ].


	leftButton := self createCircle.
	leftButton constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignCenter ].

	leftArrow := BlTextElement new text: ('<' asRopedText attributes:
			              { (BlTextForegroundAttribute paint: Color pink) }).
	leftArrow text fontSize: 55.
	leftArrow constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	leftButton
		addEventHandlerOn: BlClickEvent
		do: [ :e | self previousSpaceship ].
	leftButton addChild: leftArrow.

	rightButton := self createCircle.
	rightButton constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignCenter ].

	rightArrow := BlTextElement new text: ('>' asRopedText attributes:
			               { (BlTextForegroundAttribute paint: Color pink) }).
	rightArrow text fontSize: 55.
	rightArrow constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	rightButton
		addEventHandlerOn: BlClickEvent
		do: [ :e | self nextSpaceship ].
	rightButton addChild: rightArrow.

	spaceshipPreview := BlElement new extent: 500 @ 500.
	spaceshipImage := self getSpaceshipImage.
	spaceshipPreview background: spaceshipImage.
	spaceshipPreview constraintsDo: [ :c |
		c frame horizontal alignCenter ].

	spaceshipSelector addChild: leftButton.
	spaceshipSelector addChild: rightButton.
	spaceshipSelector addChild: spaceshipPreview.

	menu addChild: spaceshipSelector
]

{ #category : 'as yet unclassified' }
Menu >> setupTitle [

	title := BlTextElement new.
	title text: ('Jeu 12' asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color white) }).
	title text fontSize: 112.
	title constraintsDo: [ :c | c frame horizontal alignCenter ].
	title transformDo: [ :t | t translateBy: 0 @ 50 ].
	menu addChild: title
]

{ #category : 'drawing' }
Menu >> showOn: anApp [

	anApp blSpace root addChild: blElement
]

{ #category : 'as yet unclassified' }
Menu >> startGame [

	blElement removeFromParent.
	playerNameInput edited
		ifTrue: [ app activePlayerName: playerNameInput text asString ].
	app
		startGameWithShipType: 'Type' , currentSpaceship asString
		color: (spaceshipColors at: currentColorIndex)
]
