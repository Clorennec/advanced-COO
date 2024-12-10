Class {
	#name : 'SpaceshipSprite',
	#superclass : 'Sprite',
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'as yet unclassified' }
SpaceshipSprite class >> configureWithType: aType color: aColor [

	self loadImagesForType: aType color: aColor.
	^ self
]

{ #category : 'as yet unclassified' }
SpaceshipSprite class >> drawFlamesAtPositions: somePositions [

	1 to: 2 do: [ :i |
		| flame image |
		flame := FlameSprite imageAt: i.
		image := self imageAt: i.
		somePositions do: [ :pos |
			1 to: flame width do: [ :x |
				1 to: flame height do: [ :y |
					| pixelColor |
					pixelColor := flame colorAt: x @ y.
					pixelColor alpha > 0 ifTrue: [
						(image colorAt: pos + (x @ y)) alpha = 0 ifTrue: [
							image colorAt: pos + (x @ y) put: pixelColor ] ] ] ] ] ]
]

{ #category : 'as yet unclassified' }
SpaceshipSprite class >> loadImages [

	self loadImagesForType: 'Type1' color: 'RED'.
	^imagesCollection 
]

{ #category : 'as yet unclassified' }
SpaceshipSprite class >> loadImagesForType: aType color: aColor [

	| config reactorPositions relativePath absolutePath |
	imagesCollection := OrderedCollection new.

	config := self spaceshipConfigurations at: aType.
	reactorPositions := config at: 'reactorPositions'.

	relativePath := (config at: 'path') , aColor , '.png'.
	absolutePath := FileSystem workingDirectory / relativePath.

	2 timesRepeat: [
		imagesCollection add: (Form fromFileNamed: absolutePath fullName) ].

	self drawFlamesAtPositions: reactorPositions.
	^ imagesCollection
]

{ #category : 'as yet unclassified' }
SpaceshipSprite class >> spaceshipConfigurations [
    ^ {
        ('Type1' -> {
            ('reactorPositions' -> { (232 @ 369) }).
            ('path' -> 'pharo-local/iceberg/Clorennec/advanced-COO/Boum/assets/PNG/Spaceships/01/Spaceship_01_').
            ('cannonPositions' -> { (94 @ 135). (284 @ 135) })
        } asDictionary).
        ('Type2' -> {
            ('reactorPositions' -> { (192 @ 379). (272 @ 379) }).
            ('path' -> 'pharo-local/iceberg/Clorennec/advanced-COO/Boum/assets/PNG/Spaceships/02/Spaceship_02_').
            ('cannonPositions' -> { (74 @ 52). (304 @ 52) })
        } asDictionary).
        ('Type3' -> {
            ('reactorPositions' -> { (232 @ 362) }).
            ('path' -> 'pharo-local/iceberg/Clorennec/advanced-COO/Boum/assets/PNG/Spaceships/03/Spaceship_03_').
            ('cannonPositions' -> { (129 @ 138). (247 @ 138) })
        } asDictionary).
        ('Type4' -> {
            ('reactorPositions' -> { (205 @ 374). (259 @ 374) }).
            ('path' -> 'pharo-local/iceberg/Clorennec/advanced-COO/Boum/assets/PNG/Spaceships/04/Spaceship_04_').
            ('cannonPositions' -> { (144 @ 128). (234 @ 128) })
        } asDictionary).
        ('Type5' -> {
            ('reactorPositions' -> { (232 @ 366) }).
            ('path' -> 'pharo-local/iceberg/Clorennec/advanced-COO/Boum/assets/PNG/Spaceships/05/Spaceship_05_').
            ('cannonPositions' -> { (63 @ 159). (314 @ 159) })
        } asDictionary).
        ('Type6' -> {
            ('reactorPositions' -> { (102 @ 366). (362 @ 366) }).
            ('path' -> 'pharo-local/iceberg/Clorennec/advanced-COO/Boum/assets/PNG/Spaceships/06/Spaceship_06_').
            ('cannonPositions' -> { (122 @ 70). (256 @ 70) })
        } asDictionary)
    } asDictionary

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
