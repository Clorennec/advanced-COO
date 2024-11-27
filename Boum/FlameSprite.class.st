Class {
	#name : 'FlameSprite',
	#superclass : 'AbstractSprite',
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'accessing' }
FlameSprite class >> loadImages [

	| collection |
	collection := OrderedCollection new.
	collection add:
		(Form fromFileNamed: 'C:\Users\louis\Downloads\PNG\Flame_01.png').
	collection add:
		(Form fromFileNamed: 'C:\Users\louis\Downloads\PNG\Flame_02.png').
	images := collection.
	^images
]
