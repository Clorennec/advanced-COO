Class {
	#name : 'SpaceshipSprite',
	#superclass : 'Sprite',
	#instVars : [
		'color',
		'reactorPositions',
		'spaceshipImagePath'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'as yet unclassified' }
SpaceshipSprite class >> spaceshipConfigurations [

	^ {
		  ('Type1' -> { ('reactorPositions' -> {
			    (194 @ 379).
			    (278 @ 379) }) } asDictionary ).
		  ('Type2' -> { ('reactorPositions' -> { (15 @ 35) }) } asDictionary ) }
		  asDictionary
]

{ #category : 'as yet unclassified' }
SpaceshipSprite class >> type: aType color: aColor [

	| instance config |
	config := self spaceshipConfigurations at: aType.
	instance := self basicNew.
	instance configureWith: config color: aColor.
	instance initialize.
	^ instance
]

{ #category : 'as yet unclassified' }
SpaceshipSprite >> configureWith: config color: aColor [

	color := aColor.
	reactorPositions := config at: 'reactorPositions'
]

{ #category : 'as yet unclassified' }
SpaceshipSprite >> drawFlames [

	1 to: 2 do: [ :i |
		| flame image |
		flame := FlameSprite uniqueInstance images at: i.
		image := images at: i.
		reactorPositions do: [ :pos |
			1 to: flame width do: [ :x |
				1 to: flame height do: [ :y |
					| pixelColor |
					pixelColor := flame colorAt: x @ y.
					pixelColor alpha > 0 ifTrue: [
						(image colorAt: pos + (x @ y)) alpha = 0 ifTrue: [
							image colorAt: pos + (x @ y) put: pixelColor ] ] ] ] ]]
]

{ #category : 'as yet unclassified' }
SpaceshipSprite >> initialize [

	spaceshipImagePath := 'C:\Users\louis\Downloads\PNG\Spaceships\02\Spaceship_02_NAVY BLUE.png'.
	super initialize.
	self drawFlames.
	self scaleSize: 0.5
]

{ #category : 'as yet unclassified' }
SpaceshipSprite >> loadImages [

	| spaceshipImage |
	spaceshipImage := Form fromFileNamed: spaceshipImagePath.
	2 timesRepeat: [ images add: spaceshipImage deepCopy ]
]

{ #category : 'as yet unclassified' }
SpaceshipSprite >> scaleSize: scalingFactor [
    images := images collect: [ :image |
        image scaledToSize: (image width * scalingFactor) @ (image height * scalingFactor) ].
]
