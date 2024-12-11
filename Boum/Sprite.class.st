Class {
	#name : 'Sprite',
	#superclass : 'Object',
	#classInstVars : [
		'imagesCollection'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'accessing' }
Sprite class >> extent [
	^(self imageAt: 1) extent
]

{ #category : 'accessing' }
Sprite class >> imageAt: anInteger [
	imagesCollection ifNil: [ self loadImages ].
	^imagesCollection at: anInteger 
]

{ #category : 'accessing' }
Sprite class >> images [
	^imagesCollection ifNil: [ self loadImages ]
]

{ #category : 'as yet unclassified' }
Sprite class >> loadImages [

	self subclassResponsibility
]

{ #category : 'instance creation' }
Sprite class >> new [

	self error:
		'Sprite est une classe abstraite et ne peut pas être instanciée directement.'
]
