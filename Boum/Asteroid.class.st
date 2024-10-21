Class {
	#name : 'Asteroid',
	#superclass : 'BlElement',
	#instVars : [
		'spriteCollection',
		'process',
		'currentIndex',
		'speed',
		'direction'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'accessing' }
Asteroid >> direction: aDirection [
	direction := aDirection 
]

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
	direction := (0 to: 360) atRandom degreesToRadians.
	speed := (1 to: 5) atRandom.
	1 to: 10 do: [ :i |
		1 to: 10 do: [ :j |
			spriteCollection add: (spriteSheet copy: (Rectangle
						  origin: j - 1 * imageWidth @ (i - 1 * imageHeight)
						  extent: imageWidth @ imageHeight)) ] ].
	self background: (spriteCollection at: currentIndex).
	self extent: 102 @ 102
]

{ #category : 'accessing' }
Asteroid >> move [

	| deltaX deltaY oldPosition |
	deltaX := speed * direction cos.
	deltaY := speed * direction sin.
	oldPosition := self position.
	self haltIf:[self position = (0@0)].
	self position: self position + (deltaX @ deltaY).
	self position: self position + (deltaX @ deltaY).
]

{ #category : 'accessing' }
Asteroid >> speed: aSpeed [

	speed := aSpeed 
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
		           self background: (spriteCollection at: currentIndex).
					  self move.
		           anInteger milliSeconds wait ] ] fork
]

{ #category : 'as yet unclassified' }
Asteroid >> stopAnimation [

	process terminate
]
