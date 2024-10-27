Class {
	#name : 'FlameSprite',
	#superclass : 'Sprite',
	#classVars : [
		'uniqueInstance'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'accessing' }
FlameSprite class >> uniqueInstance [

	uniqueInstance ifNil: [ uniqueInstance := self basicNew initialize ].
	^ uniqueInstance
]

{ #category : 'as yet unclassified' }
FlameSprite >> initialize [ 
	super initialize 
]

{ #category : 'as yet unclassified' }
FlameSprite >> loadImages [

	images add: (Form fromFileNamed: 'C:\Users\louis\Downloads\PNG\Flame_01.png').
	images add: (Form fromFileNamed: 'C:\Users\louis\Downloads\PNG\Flame_02.png').
]
