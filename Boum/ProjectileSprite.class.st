Class {
	#name : 'ProjectileSprite',
	#superclass : 'Sprite',
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'as yet unclassified' }
ProjectileSprite class >> loadImages [

	| relativePath |
	imagesCollection := OrderedCollection new.
	relativePath := FileSystem workingDirectory / 'pharo-local'
	                 / 'iceberg' / 'Clorennec' / 'advanced-COO' / 'Boum'
	                 / 'assets' / 'Laser Sprite' / '03.png'.
	imagesCollection add:
		((Form fromFileNamed: relativePath fullName)
			 rotateBy: #left
			 centerAt: 62 @ 60).
	^ imagesCollection
]
