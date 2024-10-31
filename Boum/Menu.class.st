Class {
	#name : 'Menu',
	#superclass : 'Object',
	#instVars : [
		'blSpace',
		'blElement',
		'menu',
		'title',
		'spaceshipSelector',
		'spaceShipPreview',
		'currentSpaceship',
		'currentColor',
		'spaceshipColors'
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
		              ('Type' , currentSpaceship asString)) at: 'path')
	             , currentColor , '.png'.
	image := Form fromFileNamed: imagePath.
	^ image
]

{ #category : 'initialization' }
Menu >> initialize [

	currentSpaceship := 1.
	spaceshipColors := { 'RED'. 'GREEN' . 'NAVY BLUE' . 'ORANGE' . 'PURPLE' . 'YELLOW' }.
	currentColor := 'GREEN'
]

{ #category : 'as yet unclassified' }
Menu >> nextSpaceship [

	currentSpaceship < 6
		ifTrue: [ currentSpaceship := currentSpaceship + 1 ]
		ifFalse: [ currentSpaceship := 1 ].
	spaceShipPreview background:
		(self getSpaceshipImage)
]

{ #category : 'as yet unclassified' }
Menu >> previousSpaceship [

	currentSpaceship > 1
		ifTrue: [ currentSpaceship := currentSpaceship - 1 ]
		ifFalse: [ currentSpaceship := 6 ].
	spaceShipPreview background:
		(self getSpaceshipImage)
]

{ #category : 'as yet unclassified' }
Menu >> setupColorSelector [

	
]

{ #category : 'as yet unclassified' }
Menu >> setupElements [

	blElement := BlElement new
		             extent: blSpace extent;
		             layout: BlFrameLayout new.

	self setupMenu.

	self setupTitle.
	self setupSpaceshipSelector.
	self setupColorSelector
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

	spaceShipPreview := BlElement new extent: 500 @ 500.
	spaceshipImage := self getSpaceshipImage.
	spaceShipPreview background: spaceshipImage.

	spaceshipSelector addChild: leftButton.
	spaceshipSelector addChild: rightButton.
	spaceshipSelector addChild: spaceShipPreview.

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
