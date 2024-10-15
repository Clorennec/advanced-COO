Class {
	#name : 'HighSignal',
	#superclass : 'LogicalSignal',
	#category : 'LogicalSignals',
	#package : 'LogicalSignals'
}

{ #category : 'controlling' }
HighSignal >> and: aLogicalSignal [
	^aLogicalSignal
]

{ #category : 'initialization' }
HighSignal >> initialize [ 
	value := 1.
]

{ #category : 'logical operations' }
HighSignal >> not [
	^ LowSignal new
]

{ #category : 'controlling' }
HighSignal >> or: aLogicalSignal [

	^ HighSignal new
]
