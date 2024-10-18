Class {
	#name : 'SpriteCollection',
	#superclass : 'Object',
	#instVars : [
		'images'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'as yet unclassified' }
SpriteCollection class >> path: aPath size: aSize numberOfImages: anInteger [

	| sprite spriteCollection spriteSheet imageWidth imageHeight |
	sprite := self new.
	spriteCollection := OrderedCollection new.
	spriteSheet := Form fromFileNamed: aPath.
	imageWidth := spriteSheet extent x / aSize.
	imageHeight := spriteSheet extent y / (anInteger / aSize).
	1 to: anInteger / aSize do: [ :i |
		1 to: aSize do: [ :j |
			spriteCollection add: (spriteSheet copy: (Rectangle
						  origin: j - 1 * imageWidth @ (i - 1 * imageHeight)
						  extent: imageWidth @ imageHeight)) ] ].
	sprite images: spriteCollection.
	^ sprite
]

{ #category : 'accessing' }
SpriteCollection >> images [
	^images
]

{ #category : 'as yet unclassified' }
SpriteCollection >> images: aCollection [

	images := aCollection
]
