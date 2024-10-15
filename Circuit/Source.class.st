Class {
	#name : 'Source',
	#superclass : 'Component',
	#instVars : [
		'state'
	],
	#category : 'Circuit-Object',
	#package : 'Circuit',
	#tag : 'Object'
}

{ #category : 'as yet unclassified' }
Source >> getID [
	^id
]

{ #category : 'initialization' }
Source >> initialize [
	super initialize.
	self on.
]

{ #category : 'as yet unclassified' }
Source >> inputs [ 
	^#()
]

{ #category : 'as yet unclassified' }
Source >> off [

	state := LowSignal new
]

{ #category : 'as yet unclassified' }
Source >> on [

	state := HighSignal new
]

{ #category : 'accessing' }
Source >> state [ 
	^ state
]

{ #category : 'operations' }
Source >> toggle [
	state := state not
]
