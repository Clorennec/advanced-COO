Class {
	#name : 'FlameSprite',
	#superclass : 'AbstractSprite',
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'accessing' }
FlameSprite class >> loadImages [

	Images add:
		(Form fromFileNamed: 'C:\Users\louis\Downloads\PNG\Flame_01.png').
	Images add:
		(Form fromFileNamed: 'C:\Users\louis\Downloads\PNG\Flame_02.png').
]
