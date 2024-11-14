Class {
	#name : 'ProjectileSprite',
	#superclass : 'Sprite',
	#classVars : [
		'uniqueInstance'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'accessing' }
ProjectileSprite class >> uniqueInstance [

	uniqueInstance ifNil: [ uniqueInstance := self basicNew initialize ].
	^ uniqueInstance
]

{ #category : 'as yet unclassified' }
ProjectileSprite >> loadImages [

	images add:
		((Form fromFileNamed: 'C:\Users\louis\Downloads\Laser Sprite\03.png')
			 rotateBy: #left
			 centerAt: 62 @ 60)
]