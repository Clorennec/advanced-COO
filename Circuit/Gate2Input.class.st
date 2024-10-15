Class {
	#name : 'Gate2Input',
	#superclass : 'Component',
	#instVars : [
		'input1',
		'input2'
	],
	#category : 'Circuit-Object',
	#package : 'Circuit',
	#tag : 'Object'
}

{ #category : 'accessing' }
Gate2Input >> firstInput: aSignal [
	input1 := aSignal 
]

{ #category : 'initialization' }
Gate2Input >> initialize [
	super initialize.
	input1 := nil.
	input2 := nil.
]

{ #category : 'as yet unclassified' }
Gate2Input >> inputs [ 
	^ Array with: input1 with: input2 
]

{ #category : 'accessing' }
Gate2Input >> secondInput: aSignal [

	input2 := aSignal
]
