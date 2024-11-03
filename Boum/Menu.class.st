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
		'currentColor',
		'spaceshipColors',
		'colorSelector',
		'colorPreview',
		'currentColorIndex',
		'playButton'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'drawing' }
Menu class >> showOn: aBlSpace [

	| menu |
	menu := self new.
	menu blSpace: aBlSpace.
	menu setupElements.
	menu showOn: aBlSpace.
	^ menu
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
	colorSelector transformDo: [ :t | t translateBy: 0 @ 800 ].


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
		addEventHandlerOn: BlMouseDownEvent
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
		addEventHandlerOn: BlMouseDownEvent
		do: [ :e | self nextColor ].
	rightButton addChild: rightArrow.

	colorPreview := BlTextElement new.
	colorPreview constraintsDo: [ :c | c frame horizontal alignCenter.
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
	
	playButton := BlElement new.
	playButton geometry: (BlRoundedRectangleGeometry cornerRadius: 25).
	playButton constraintsDo: [ :c | c frame horizontal alignCenter ].
	playButton background: Color pink.
	playButton layout: BlFrameLayout.
	playButton addEventHandlerOn: BlMouseDownEvent do: self startGame.
	
	buttonText := BlTextElement new.
	buttonText text: ('PLAY' asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color white) }).
	buttonText text fontSize: 88.
	buttonText constraintsDo: [ :c | c frame horizontal alignCenter.
		c frame vertical alignCenter ]
	
	
]

{ #category : 'as yet unclassified' }
Menu >> setupSpaceshipSelector [

	| leftButton leftArrow rightButton rightArrow spaceshipImage |
	spaceshipSelector := BlElement new
		                     extent: 800 @ 500;
		                     layout: BlFrameLayout new.
	spaceshipSelector constraintsDo: [ :c |
		c frame horizontal alignCenter ].
	spaceshipSelector transformDo: [ :t | t translateBy: 0 @ 300 ].


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
		addEventHandlerOn: BlMouseDownEvent
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
		addEventHandlerOn: BlMouseDownEvent
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
Menu >> showOn: aBlSpace [

	blSpace root addChild: blElement
]
