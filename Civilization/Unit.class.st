Class {
	#name : 'Unit',
	#superclass : 'Object',
	#instVars : [
		'hp',
		'lvl',
		'ap',
		'dp',
		'x',
		'y',
		'position',
		'terrain'
	],
	#category : 'Civilization-unit',
	#package : 'Civilization',
	#tag : 'unit'
}

{ #category : 'as yet unclassified' }
Unit class >> withLvl: anInteger [
	| unit |
	unit := self new.
	unit lvl: anInteger.
	^unit 
	
]

{ #category : 'accessing' }
Unit >> ap [
	^ap
]

{ #category : 'as yet unclassified' }
Unit >> attack: anUnit [
	^ self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
Unit >> defendAgainstArcher: anArcher [

	hp := hp
	      -
	      (anArcher ap * anArcher getAtkLvlMultiplier + self terrain dti).
	^ self dp * self getDefLvlMultiplier + self terrain ati
]

{ #category : 'as yet unclassified' }
Unit >> defendAgainstKnight: aKnight [

	hp := hp
	      -
	      (aKnight ap * aKnight getAtkLvlMultiplier * 2
	       + (self terrain dti * 2)).
	^ self dp * self getDefLvlMultiplier + self terrain ati
]

{ #category : 'as yet unclassified' }
Unit >> defendAgainstPikeman: aPikeman [

	hp := hp
	      -
	      (aPikeman ap * aPikeman getAtkLvlMultiplier + self terrain dti).
	^ self dp * self getDefLvlMultiplier + self terrain ati
]

{ #category : 'as yet unclassified' }
Unit >> defendAgainstWarrior: aWarrior [

	hp := hp
	      -
	      (aWarrior ap * aWarrior getAtkLvlMultiplier + self terrain dti).
	^ self dp * self getDefLvlMultiplier + self terrain ati
]

{ #category : 'accessing' }
Unit >> dp [
	^dp
]

{ #category : 'as yet unclassified' }
Unit >> getAtkLvlMultiplier [

	^ 1 + (lvl - 1 * 0.5)
]

{ #category : 'as yet unclassified' }
Unit >> getDefLvlMultiplier [

	^ 1 + (lvl - 1 * 0.75)
]

{ #category : 'accessing' }
Unit >> hp [
	^hp
]

{ #category : 'initialization' }
Unit >> initialize [

	terrain := FlatTile new.
	lvl := 1.
	hp := 100
]

{ #category : 'accessing' }
Unit >> lvl: anInteger [

	lvl := anInteger
]

{ #category : 'accessing' }
Unit >> terrain [
	^terrain 
]

{ #category : 'accessing' }
Unit >> terrain: aTerrain [
	terrain := aTerrain 
]
