Class {
	#name : 'Explosion',
	#superclass : 'BlElement',
	#instVars : [
		'spriteCollection',
		'currentIndex',
		'process'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'initialization' }
Explosion >> initialize [

	| spriteSheet imageWidth imageHeight |
	super initialize.
	spriteCollection := OrderedCollection new.
	spriteSheet := Form fromFileNamed:
		               'C:\Users\louis\Downloads\expl001Sp_Fire_fixed.png'.
	imageWidth := spriteSheet extent x / 6.
	imageHeight := spriteSheet extent y / 7.
	1 to: 7 do: [ :i |
		1 to: 6 do: [ :j |
			spriteCollection add: (spriteSheet copy: (Rectangle
						  origin: j - 1 * imageWidth @ (i - 1 * imageHeight)
						  extent: imageWidth @ imageHeight)) ] ].
	self extent: 100 @ 100.
	currentIndex := 1
]

{ #category : 'as yet unclassified' }
Explosion >> startAnimation [

	1 to: 42 do: [ :i |
		self background: (spriteCollection at: i).
		30 milliSeconds wait ]
]
