Class {
	#name : 'And',
	#superclass : 'Gate2Input',
	#category : 'Circuit-Object',
	#package : 'Circuit',
	#tag : 'Object'
}

{ #category : 'initialization' }
And >> initialize [ 
	super initialize 
]

{ #category : 'accessing' }
And >> state [

	^ input1 state and: input2 state
]
