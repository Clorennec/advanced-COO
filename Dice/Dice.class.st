Class {
	#name : 'Dice',
	#superclass : 'Object',
	#instVars : [
		'faces'
	],
	#category : 'Dice',
	#package : 'Dice'
}

{ #category : 'as yet unclassified' }
Dice class >> withFaces: aNumber [

	| dice |
	dice := self new.
	dice faces: aNumber.
	^ dice
]

{ #category : 'accessing' }
Dice >> faces [

	^faces
]

{ #category : 'accessing' }
Dice >> faces: aNumber [

	faces := aNumber
]

{ #category : 'initialization' }
Dice >> initialize [
	faces := 6.
]

{ #category : 'printing' }
Dice >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		print: faces;
		nextPutAll: ')'
]

{ #category : 'as yet unclassified' }
Dice >> roll [
	^(1 to: faces) atRandom
]
