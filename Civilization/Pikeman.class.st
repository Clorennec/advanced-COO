Class {
	#name : 'Pikeman',
	#superclass : 'Unit',
	#category : 'Civilization-unit',
	#package : 'Civilization',
	#tag : 'unit'
}

{ #category : 'as yet unclassified' }
Pikeman >> attack: anUnit [

	hp := hp - (anUnit defendAgainstPikeman: self)
]

{ #category : 'as yet unclassified' }
Pikeman >> defendAgainstKnight: aKnight [

	hp := hp
	      -
	      (aKnight ap * aKnight getAtkLvlMultiplier
	       + (self terrain dti * 2)).
	^ self dp * self getDefLvlMultiplier * 2 + self terrain ati
]

{ #category : 'initialization' }
Pikeman >> initialize [

	super initialize.
	ap := 5.
	dp := 20
]
