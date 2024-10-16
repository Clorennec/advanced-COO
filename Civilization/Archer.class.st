Class {
	#name : 'Archer',
	#superclass : 'Unit',
	#category : 'Civilization-unit',
	#package : 'Civilization',
	#tag : 'unit'
}

{ #category : 'as yet unclassified' }
Archer >> attack: anUnit [

	hp := hp - (anUnit defendAgainstArcher: self)
]

{ #category : 'initialization' }
Archer >> initialize [

	super initialize.
	ap := 20.
	dp := 5
]
