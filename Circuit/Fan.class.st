Class {
	#name : 'Fan',
	#superclass : 'Component',
	#instVars : [
		'input'
	],
	#category : 'Circuit-Object',
	#package : 'Circuit',
	#tag : 'Object'
}

{ #category : 'initialization' }
Fan >> initialize [ 
	super initialize 
]

{ #category : 'accessing' }
Fan >> input: aSignal [
	input := aSignal 
]

{ #category : 'as yet unclassified' }
Fan >> inputs [ 
	^ Array with: input 
]

{ #category : 'accessing - structure variables' }
Fan >> state [ 
	^ input state
]
