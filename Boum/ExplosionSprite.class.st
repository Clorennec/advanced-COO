Class {
	#name : 'ExplosionSprite',
	#superclass : 'Sprite',
	#classVars : [
		'uniqueInstance'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'accessing' }
ExplosionSprite class >> uniqueInstance [

	uniqueInstance ifNil: [ uniqueInstance := self basicNew initialize ].
	^ uniqueInstance
]

{ #category : 'as yet unclassified' }
ExplosionSprite >> initialize [ 
	super initialize 
]

{ #category : 'as yet unclassified' }
ExplosionSprite >> loadImages [

	| spriteSheet imageWidth imageHeight |
	spriteSheet := Form fromFileNamed:
		               'C:\Users\louis\Downloads\output-onlinepngtools.png'.
	imageWidth := spriteSheet extent x / 6.
	imageHeight := spriteSheet extent y / 7.
	1 to: 7 do: [ :i |
		1 to: 6 do: [ :j |
			images add: (spriteSheet copy: (Rectangle
						  origin: j - 1 * imageWidth @ (i - 1 * imageHeight)
						  extent: imageWidth @ imageHeight)) ] ]
]
