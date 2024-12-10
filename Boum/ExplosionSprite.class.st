Class {
	#name : 'ExplosionSprite',
	#superclass : 'Sprite',
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'as yet unclassified' }
ExplosionSprite class >> loadImages [

	| spriteSheet imageWidth imageHeight relaticePath |
	imagesCollection := OrderedCollection new.
	relaticePath := FileSystem workingDirectory / 'pharo-local'
	                 / 'iceberg' / 'Clorennec' / 'advanced-COO' / 'Boum'
	                 / 'assets' / 'output-onlinepngtools.png'.
	spriteSheet := Form fromFileNamed: relaticePath fullName.
	imageWidth := spriteSheet extent x / 6.
	imageHeight := spriteSheet extent y / 7.
	1 to: 7 do: [ :i |
		1 to: 6 do: [ :j |
			imagesCollection add: (spriteSheet copy: (Rectangle
						  origin: j - 1 * imageWidth @ (i - 1 * imageHeight)
						  extent: imageWidth @ imageHeight)) ] ].
	^ imagesCollection
]
