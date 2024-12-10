Class {
	#name : 'AsteroidSprite',
	#superclass : 'Sprite',
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'as yet unclassified' }
AsteroidSprite class >> loadImages [

	| spriteSheet imageWidth imageHeight relaticePath |
	imagesCollection := OrderedCollection new.
	relaticePath := FileSystem workingDirectory / 'pharo-local'
	                / 'iceberg' / 'Clorennec' / 'advanced-COO'
	                / 'assets' / 'o001Sp.png'.
	spriteSheet := Form fromFileNamed: relaticePath fullName.

	imageWidth := spriteSheet extent x / 10.
	imageHeight := spriteSheet extent y / 10.
	1 to: 10 do: [ :i |
		1 to: 10 do: [ :j |
			imagesCollection add: (spriteSheet copy: (Rectangle
						  origin: j - 1 * imageWidth @ (i - 1 * imageHeight)
						  extent: imageWidth @ imageHeight)) ] ].
	^ imagesCollection
]
