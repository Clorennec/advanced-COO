Class {
	#name : 'AsteroidSprite',
	#superclass : 'Sprite',
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'as yet unclassified' }
AsteroidSprite class >> loadImages [

	| imageWidth imageHeight spriteSheet |
	images := OrderedCollection new.
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
