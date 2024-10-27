Class {
	#name : 'SpaceshipSprite',
	#superclass : 'Sprite',
	#instVars : [
		'reactorPositions',
		'spaceshipImagePath'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'as yet unclassified' }
SpaceshipSprite class >> spaceshipConfigurations [

	^ {
		  ('Type1' -> {
			   ('reactorPositions' -> { (232 @ 369) }).
			   ('path'
			    -> 'C:\Users\louis\Downloads\PNG\Spaceships\01\Spaceship_01_') }
			   asDictionary).
		  ('Type2' -> {
			   ('reactorPositions' -> {
				    (192 @ 379).
				    (272 @ 379) }).
			   ('path'
			    -> 'C:\Users\louis\Downloads\PNG\Spaceships\02\Spaceship_02_') }
			   asDictionary).
		  ('Type3' -> {
			   ('reactorPositions' -> { (232 @ 362) }).
			   ('path'
			    -> 'C:\Users\louis\Downloads\PNG\Spaceships\03\Spaceship_03_') }
			   asDictionary).
		  ('Type4' -> {
			   ('reactorPositions' -> {
				    (205 @ 374).
				    (259 @ 374) }).
			   ('path'
			    -> 'C:\Users\louis\Downloads\PNG\Spaceships\04\Spaceship_04_') }
			   asDictionary).
		  ('Type5' -> {
			   ('reactorPositions' -> { (232 @ 366) }).
			   ('path'
			    -> 'C:\Users\louis\Downloads\PNG\Spaceships\05\Spaceship_05_') }
			   asDictionary).
		  ('Type6' -> {
			   ('reactorPositions' -> {
				    (102 @ 366).
				    (362 @ 366) }).
			   ('path'
			    -> 'C:\Users\louis\Downloads\PNG\Spaceships\06\Spaceship_06_') }
			   asDictionary) } asDictionary
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

	reactorPositions := config at: 'reactorPositions'.
	spaceshipImagePath := (config at: 'path'), aColor, '.png'
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

	super initialize.
	self drawFlames.
	self scaleSize: 1
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
