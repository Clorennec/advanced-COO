Class {
	#name : 'FlameSprite',
	#superclass : 'Sprite',
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'as yet unclassified' }
FlameSprite class >> loadImages [

	imagesCollection := OrderedCollection new.

	imagesCollection add:
		(Form fromFileNamed: (FileSystem workingDirectory / 'pharo-local'
	                 / 'iceberg' / 'Clorennec' / 'advanced-COO' / 'Boum'
	                 / 'assets' / 'PNG' / 'Flame_01.png') fullName).
	imagesCollection add:
		(Form fromFileNamed: (FileSystem workingDirectory / 'pharo-local'
	                 / 'iceberg' / 'Clorennec' / 'advanced-COO' / 'Boum'
	                 / 'assets' / 'PNG' / 'Flame_02.png') fullName).
	^ imagesCollection
]
