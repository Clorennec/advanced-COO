Class {
	#name : 'Menu',
	#superclass : 'Object',
	#instVars : [
		'blSpace',
		'blElement',
		'menu',
		'title',
		'spaceshipSelector'
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
	spaceshipSelector := BlElement new extent: 800@400; layout: BlFrameLayout new.
	spaceshipSelector background: Color black.
	
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
