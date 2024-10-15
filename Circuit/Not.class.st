Class {
	#name : 'Not',
	#superclass : 'Gate1Input',
	#category : 'Circuit-Object',
	#package : 'Circuit',
	#tag : 'Object'
}

{ #category : 'initialization' }
Not >> initialize [ 
	super initialize 
]

{ #category : 'accessing' }
Not >> input: aSignal [
	input := aSignal 
]

{ #category : 'accessing' }
Not >> state [ 
	^ input state not
]
