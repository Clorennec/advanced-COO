Class {
	#name : 'Component',
	#superclass : 'Object',
	#instVars : [
		'id'
	],
	#category : 'Circuit',
	#package : 'Circuit'
}

{ #category : 'as yet unclassified' }
Component >> generateId [

	^ UUID new asString
]

{ #category : 'initialization' }
Component >> initialize [

	id := self generateId
]
