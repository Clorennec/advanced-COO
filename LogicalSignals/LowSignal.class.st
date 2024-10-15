Class {
	#name : 'LowSignal',
	#superclass : 'LogicalSignal',
	#category : 'LogicalSignals',
	#package : 'LogicalSignals'
}

{ #category : 'controlling' }
LowSignal >> and: aLogicalSignal [
	^ LowSignal new
]

{ #category : 'initialization' }
LowSignal >> initialize [ 
	value := 0
]

{ #category : 'logical operations' }
LowSignal >> not [

	^ HighSignal new
]

{ #category : 'controlling' }
LowSignal >> or: aLogicalSignal [

	^ aLogicalSignal 
]
