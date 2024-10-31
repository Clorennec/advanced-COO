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
	Menu showOn: app blSpace.
]
