Class {
	#name : 'Or',
	#superclass : 'Gate2Input',
	#category : 'Circuit-Object',
	#package : 'Circuit',
	#tag : 'Object'
}

{ #category : 'initialization' }
Or >> initialize [ 
	super initialize 
]

{ #category : 'accessing' }
Or >> state [

	^input1 state or: input2 state
]
