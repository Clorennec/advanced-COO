Class {
	#name : 'Sprite',
	#superclass : 'Object',
	#instVars : [
		'images'
	],
	#classInstVars : [
		'images'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'instance creation' }
Sprite class >> images [

	images ifNil: [ images := self loadImages ].
	^ images
]

{ #category : 'as yet unclassified' }
Sprite class >> loadImages [
	^ self subclassResponsibility 
]

{ #category : 'instance creation' }
Sprite class >> new [

	self error:
		'Sprite est une classe abstraite et ne peut pas être instanciée directement.'
]
