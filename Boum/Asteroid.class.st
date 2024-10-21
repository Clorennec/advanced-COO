Class {
	#name : 'Asteroid',
	#superclass : 'BlElement',
	#instVars : [
		'spriteCollection',
		'process',
		'currentIndex'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'initialization' }
Asteroid >> initialize [

	| spriteSheet imageWidth imageHeight |
	super initialize.
	currentIndex := (1 to: 100) atRandom.
	spriteCollection := OrderedCollection new.
	spriteSheet := Form fromFileNamed:
		               'C:\Users\louis\Downloads\o001Sp.png'.
	imageWidth := spriteSheet extent x / 10.
	imageHeight := spriteSheet extent y / 10.
	1 to: 10 do: [ :i |
		1 to: 10 do: [ :j |
			spriteCollection add: (spriteSheet copy: (Rectangle
						  origin: j - 1 * imageWidth @ (i - 1 * imageHeight)
						  extent: imageWidth @ imageHeight)) ] ].
	self extent: 100@100
]

{ #category : 'as yet unclassified' }
Asteroid >> startAnimation [

	^ self startAnimation: 30
]

{ #category : 'as yet unclassified' }
Asteroid >> startAnimation: anInteger [

	process := [
	           [ true ] whileTrue: [
		           currentIndex := currentIndex + 1.
		           currentIndex > 100 ifTrue: [ currentIndex := 1 ].
		           self background:
			           (spriteCollection at: currentIndex).
		           anInteger milliSeconds wait ] ] fork
]

{ #category : 'as yet unclassified' }
Asteroid >> stopAnimation [

	process terminate
]
