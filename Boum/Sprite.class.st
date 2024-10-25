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
Sprite class >> new [

	self error:
		'Sprite est une classe abstraite et ne peut pas être instanciée directement.'
]

{ #category : 'accessing' }
Sprite class >> uniqueInstance [

	self subclassResponsibility 
]

{ #category : 'accessing' }
Sprite >> images [ 
	^ images
]

{ #category : 'as yet unclassified' }
Sprite >> initialize [
	images := OrderedCollection new.
	self loadImages
]

{ #category : 'as yet unclassified' }
Sprite >> loadImages [ 
	self subclassResponsibility 
]
