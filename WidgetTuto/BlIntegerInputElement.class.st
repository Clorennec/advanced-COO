Class {
	#name : 'BlIntegerInputElement',
	#superclass : 'BlElement',
	#instVars : [
		'plus',
		'minus',
		'inputValue',
		'value',
		'inputLabel',
		'callbackBlock'
	],
	#category : 'WidgetTuto-Input',
	#package : 'WidgetTuto',
	#tag : 'Input'
}

{ #category : 'as yet unclassified' }
BlIntegerInputElement >> backgroundPaint [

	^ Color black
]

{ #category : 'initialization' }
BlIntegerInputElement >> callbackBlock: aBlock [

	callbackBlock := aBlock
]

{ #category : 'initialization' }
BlIntegerInputElement >> changeValueTo: aValue [

	inputValue text: (self configuredString: aValue asString).
	inputValue text fontSize: 30.
	value := aValue.
	callbackBlock value: aValue
]

{ #category : 'as yet unclassified' }
BlIntegerInputElement >> configuredString: aString [

	^ aString asRopedText attributes: { (BlTextForegroundAttribute paint: Color white) }
]

{ #category : 'as yet unclassified' }
BlIntegerInputElement >> createCircle [

	| circle |
	circle := BlElement new
		          background: Color black;
		          border: (BlBorder paint: Color pink width: 2);
		          layout: BlFrameLayout new;
		          geometry: BlCircleGeometry new.
	^ circle
]

{ #category : 'as yet unclassified' }
BlIntegerInputElement >> decreaseInput [

	value > 0 ifTrue: [ self changeValueTo: value - 1 ]
]

{ #category : 'as yet unclassified' }
BlIntegerInputElement >> increaseInput [

	self changeValueTo: value + 1
]

{ #category : 'as yet unclassified' }
BlIntegerInputElement >> initialize [

	super initialize.
	self size: self inputExtent.
	self background: self backgroundPaint.
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 20).
	self layout: BlFrameLayout new.
	self border: (BlBorder paint: Color pink).
	self initializePlusButton.
	self initializeMinusButton.
	self initializeInputValue: 20.
	self label: 'Input'
]

{ #category : 'initialization' }
BlIntegerInputElement >> initializeInputValue: aValue [

	callbackBlock := [ :newInputValue | ].
	inputValue := BlTextElement new.
	inputValue constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	self changeValueTo: aValue.
	self addChild: inputValue
]

{ #category : 'as yet unclassified' }
BlIntegerInputElement >> initializeMinusButton [

	| circle |
	circle := self createCircle.
	circle constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignCenter ].
	circle transformDo: [ :t | t translateBy: 15 @ 0 ].

	minus := BlTextElement new text: (self configuredString: '-').
	minus text fontSize: 55.
	minus constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	circle
		addEventHandlerOn: BlMouseDownEvent
		do: [ :e | self decreaseInput ].
	circle addChild: minus.
	self addChild: circle.
	self minus: circle 
]

{ #category : 'as yet unclassified' }
BlIntegerInputElement >> initializePlusButton [

	| circle |
	circle := self createCircle.
	circle constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignCenter ].
	circle transformDo: [ :t | t translateBy: -15 @ 0 ].

	plus := BlTextElement new text: (self configuredString: '+').
	plus text fontSize: 55.
	plus constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	circle
		addEventHandlerOn: BlMouseDownEvent
		do: [ :e | self increaseInput ].
	circle addChild: plus.
	self addChild: circle.
	self plus: circle
]

{ #category : 'as yet unclassified' }
BlIntegerInputElement >> inputExtent [ 

	^ 300@120
]

{ #category : 'accessing' }
BlIntegerInputElement >> label [ 
	^ inputLabel
]

{ #category : 'as yet unclassified' }
BlIntegerInputElement >> label: aString [

	inputLabel := BlTextElement new.
	inputLabel text: (self configuredString: aString).
	inputLabel text fontSize: 25.
	inputLabel constraintsDo: [ :c | c frame horizontal alignCenter ].
	inputLabel transformDo: [ :t | t translateBy: 0 @ 10 ].
	self addChild: inputLabel
]

{ #category : 'accessing' }
BlIntegerInputElement >> minus [

	^ minus
]

{ #category : 'accessing' }
BlIntegerInputElement >> minus: anElement [

	minus := anElement 
]

{ #category : 'accessing' }
BlIntegerInputElement >> plus [

	^ plus
]

{ #category : 'accessing' }
BlIntegerInputElement >> plus: anElement [

	plus := anElement 
]

{ #category : 'evaluating' }
BlIntegerInputElement >> value [ 
	^ inputValue 
]
