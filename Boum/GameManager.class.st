Class {
	#name : 'GameManager',
	#superclass : 'Object',
	#instVars : [
		'instance'
	],
	#classInstVars : [
		'instance'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'accessing' }
GameManager class >> instance [
    "Renvoie l'instance unique de GameManager"
    ^instance ifNil: [ instance := self new ].
]

{ #category : 'instance creation' }
GameManager class >> new [
    self error: 'Utilisez GameManager class>>instance pour obtenir l''instance unique.'.
]

{ #category : 'initialization' }
GameManager >> initialize [ 
	super initialize 
]
