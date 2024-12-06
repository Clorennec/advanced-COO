Class {
	#name : 'AsteroidSprite',
	#superclass : 'Sprite',
	#classVars : [
		'uniqueInstance'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'as yet unclassified' }
AsteroidSprite class >> loadImages [

	| spriteSheet imageWidth imageHeight |
	imagesCollection := OrderedCollection new.
	spriteSheet := Form fromFileNamed:
		               'C:\Users\louis\Downloads\o001Sp.png'.
	imageWidth := spriteSheet extent x / 10.
	imageHeight := spriteSheet extent y / 10.
	1 to: 10 do: [ :i |
		1 to: 10 do: [ :j |
			imagesCollection add: (spriteSheet copy: (Rectangle
						  origin: j - 1 * imageWidth @ (i - 1 * imageHeight)
						  extent: imageWidth @ imageHeight)) ] ].
	^imagesCollection 
]

{ #category : 'accessing' }
AsteroidSprite class >> uniqueInstance [

	uniqueInstance ifNil: [ uniqueInstance := self basicNew initialize ].
	^ uniqueInstance
]

{ #category : 'as yet unclassified' }
AsteroidSprite >> initialize [ 
	super initialize 
]

{ #category : 'as yet unclassified' }
AsteroidSprite >> loadImages [

	| spriteSheet imageWidth imageHeight |
	spriteSheet := Form fromFileNamed:
		               'C:\Users\louis\Downloads\o001Sp.png'.
	imageWidth := spriteSheet extent x / 10.
	imageHeight := spriteSheet extent y / 10.
	1 to: 10 do: [ :i |
		1 to: 10 do: [ :j |
			images add: (spriteSheet copy: (Rectangle
						  origin: j - 1 * imageWidth @ (i - 1 * imageHeight)
						  extent: imageWidth @ imageHeight)) ] ]
]
