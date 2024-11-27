Class {
	#name : 'ExplosionSprite',
	#superclass : 'AbstractSprite',
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'as yet unclassified' }
ExplosionSprite class >> loadImages [

	| spriteSheet imageWidth imageHeight |
	spriteSheet := Form fromFileNamed:
		               'C:\Users\louis\Downloads\output-onlinepngtools.png'.
	imageWidth := spriteSheet extent x / 6.
	imageHeight := spriteSheet extent y / 7.
	1 to: 7 do: [ :i |
		1 to: 6 do: [ :j |
			Images add: (spriteSheet copy: (Rectangle
						  origin: j - 1 * imageWidth @ (i - 1 * imageHeight)
						  extent: imageWidth @ imageHeight)) ] ].
]
