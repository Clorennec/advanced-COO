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
		(Form fromFileNamed: 'C:\Users\louis\Downloads\PNG\Flame_01.png').
	imagesCollection add:
		(Form fromFileNamed: 'C:\Users\louis\Downloads\PNG\Flame_02.png').
	^imagesCollection 
]
