Class {
	#name : 'Display',
	#superclass : 'Component',
	#instVars : [
		'input'
	],
	#category : 'Circuit-Object',
	#package : 'Circuit',
	#tag : 'Object'
}

{ #category : 'initialization' }
Display >> initialize [ 
	super initialize .
	input := nil
]

{ #category : 'accessing' }
Display >> input: aSignal [
	input := aSignal 
]

{ #category : 'printing' }
Display >> printOn: aStream [
    aStream
        nextPutAll: self class name;
        nextPutAll: ' (';
        nextPutAll: id;
        nextPutAll: ') input: ';
        nextPutAll: (input isNil
            ifTrue: ['not connected']
            ifFalse: [input getID printString]).
]

{ #category : 'accessing - structure variables' }
Display >> state [

	^ input isNil
		  ifTrue: [ LowSignal new ]
		  ifFalse: [ input state ]
]
