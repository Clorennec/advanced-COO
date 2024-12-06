Class {
	#name : 'ProjectileSprite',
	#superclass : 'Sprite',
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'as yet unclassified' }
ProjectileSprite class >> loadImages [

	imagesCollection := OrderedCollection new.
	imagesCollection add:
		((Form fromFileNamed: 'C:\Users\louis\Downloads\Laser Sprite\03.png')
			 rotateBy: #left
			 centerAt: 62 @ 60).
	^ imagesCollection
]
