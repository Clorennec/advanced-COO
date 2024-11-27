Class {
	#name : 'AbstractSprite',
	#superclass : 'Object',
	#classVars : [
		'Images'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'accessing' }
AbstractSprite class >> imageAt: anIndex [
        ^ self images at: anIndex.
]

{ #category : 'accessing' }
AbstractSprite class >> images [

	Images ifEmpty: [ self loadImages ].
	^ Images
]

{ #category : 'class initialization' }
AbstractSprite class >> initialize [ 
	Images := OrderedCollection new.
]

{ #category : 'as yet unclassified' }
AbstractSprite class >> loadImages [

	^ self subclassResponsibility
]
