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

{ #category : 'as yet unclassified' }
GameUI >> createCircle [

	| circle |
	circle := BlElement new
		          background: Color black;
		          border: (BlBorder paint: Color pink width: 2);
		          layout: BlFrameLayout new;
		          geometry: BlCircleGeometry new.
	^ circle
]

{ #category : 'as yet unclassified' }
GameUI >> createColorSelector [
    | colorSelector leftButton rightArrow colorLabel leftArrow rightButton |
    colorSelector := BlElement new.
    colorSelector extent: 400 @ 100.
    colorSelector position: 100 @ 500.

    "Flèche gauche"
	leftButton := self createCircle.
	leftButton constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignCenter ].
	leftButton transformDo: [ :t | t translateBy: 100 @ 0 ].

	leftArrow := BlTextElement new text: ('<' asRopedText attributes: { (BlTextForegroundAttribute paint: Color pink)}).
	leftArrow text fontSize: 55.
	leftArrow constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	leftButton 
		addEventHandlerOn: BlMouseDownEvent
		do: [ :e | self previousColor ].
	leftButton addChild: leftArrow .
	colorSelector addChild: leftButton.

    "Label Couleur"
    colorLabel := BlTextElement new.
    colorLabel text: ('Color' asRopedText attributes: { (BlTextForegroundAttribute paint: Color pink)}).
    colorLabel text fontSize: 55.
    colorLabel position: 200 @ 50.

    rightButton := self createCircle.
	rightButton constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignCenter ].
	rightButton transformDo: [ :t | t translateBy: 151 @ 0 ].

	rightArrow := BlTextElement new text: ('>' asRopedText attributes: { (BlTextForegroundAttribute paint: Color pink)}).
	rightArrow text fontSize: 55.
	rightArrow constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	rightButton 
		addEventHandlerOn: BlMouseDownEvent
		do: [ :e | self nextColor ].
	rightButton addChild: rightArrow .
	colorSelector addChild: rightButton.

    ^colorSelector

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

	| menu glowEffect label colorSelector |
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
	label text: ('Jeu 12' asRopedText attributes: { (BlTextForegroundAttribute paint: Color white) }).
	label text fontSize: 112.
	menu addChild: label.
	label transformDo: [ :t | 
		t translateBy: 0@ 50 ].
	app blSpace root addChild: menu.
	colorSelector := self createColorSelector.
	menu addChild: colorSelector. 
	colorSelector transformDo: [ :t |
		t translateBy: 800@0 ]
	
]
