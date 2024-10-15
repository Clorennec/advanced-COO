Class {
	#name : 'Gate1Input',
	#superclass : 'Component',
	#instVars : [
		'input'
	],
	#category : 'Circuit-Object',
	#package : 'Circuit',
	#tag : 'Object'
}

{ #category : 'initialization' }
Gate1Input >> initialize [ 
	super initialize.
	input := nil

]

{ #category : 'as yet unclassified' }
Gate1Input >> inputs [

	^ Array with: input
]
