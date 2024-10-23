Class {
	#name : 'ExplosionSprite',
	#superclass : 'Sprite',
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'as yet unclassified' }
ExplosionSprite class >> loadImages [ 
	| spriteSheet imageWidth imageHeight |
	images := OrderedCollection new.
	spriteSheet := Form fromFileNamed:
		               'C:\Users\louis\Downloads\expl001Sp_Fire_fixed.png'.
	imageWidth := spriteSheet extent x / 6.
	imageHeight := spriteSheet extent y / 7.
	1 to: 7 do: [ :i |
		1 to: 6 do: [ :j |
			images add: (spriteSheet copy: (Rectangle
						  origin: j - 1 * imageWidth @ (i - 1 * imageHeight)
						  extent: imageWidth @ imageHeight)) ] ].
]
