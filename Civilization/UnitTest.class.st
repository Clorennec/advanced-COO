Class {
	#name : 'UnitTest',
	#superclass : 'TestCase',
	#category : 'Civilization',
	#package : 'Civilization'
}

{ #category : 'tests' }
UnitTest >> testArcher1AgainstPikeman3OnFlat [

	| a p |
	a := Archer withLvl: 1.
	p := Pikeman withLvl: 3.
	a attack: p.
	self assert: a hp equals: 50.
	self assert: p hp equals: 80
]

{ #category : 'tests' }
UnitTest >> testArcher1AgainstPikeman3OnHilly [

	| a p |
	a := Archer withLvl: 1.
	p := Pikeman withLvl: 3.
	p terrain: HillyTile new.
	a attack: p.
	self assert: a hp equals: 50.
	self assert: p hp equals: 70
]

{ #category : 'tests' }
UnitTest >> testKnight2AgainstPikeman3OnFlat [

	| k p |
	k := Knight withLvl: 2.
	p := Pikeman withLvl: 3.
	k attack: p.
	self assert: k hp equals: 0.
	self assert: p hp equals: 70
]

{ #category : 'tests' }
UnitTest >> testKnight2AgainstPikeman3OnHilly [

	| k p |
	k := Knight withLvl: 2.
	p := Pikeman withLvl: 3.
	p terrain: HillyTile new.
	k attack: p.
	self assert: k hp equals: 0.
	self assert: p hp equals: 50
]

{ #category : 'tests' }
UnitTest >> testKnight2AgainstWarrior3OnHilly [

	| k w |
	k := Knight withLvl: 2.
	w := Warrior withLvl: 3.
	w terrain: HillyTile new.
	k attack: w.
	self assert: k hp equals: 75.
	self assert: w hp equals: 20
]

{ #category : 'tests' }
UnitTest >> testWarriorAgainstWarriorOnFlat [

	| w1 w2 |
	w1 := Warrior new.
	w2 := Warrior new.
	w1 attack: w2.
	self assert: w1 hp equals: 90
]
