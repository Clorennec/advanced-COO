Class {
	#name : 'Knight',
	#superclass : 'Unit',
	#category : 'Civilization-unit',
	#package : 'Civilization',
	#tag : 'unit'
}

{ #category : 'as yet unclassified' }
Knight >> attack: anUnit [

	hp := hp - (anUnit defendAgainstKnight: self)
]

{ #category : 'initialization' }
Knight >> initialize [

	super initialize.
	ap := 20.
	dp := 5
]
