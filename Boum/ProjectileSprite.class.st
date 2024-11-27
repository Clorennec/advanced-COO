Class {
	#name : 'ProjectileSprite',
	#superclass : 'AbstractSprite',
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'as yet unclassified' }
ProjectileSprite class >> loadImages [

	| collection |
	collection := OrderedCollection new.
	collection add:
		((Form fromFileNamed: 'C:\Users\louis\Downloads\Laser Sprite\03.png')
			 rotateBy: #left
			 centerAt: 62 @ 60).
	images := collection.
	^images 
]
