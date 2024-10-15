Class {
	#name : 'Circuit',
	#superclass : 'Object',
	#instVars : [
		'id',
		'components'
	],
	#category : 'Circuit',
	#package : 'Circuit'
}

{ #category : 'instance creation' }
Circuit >> collectComponentsFrom: aComponent [
    "Méthode récursive pour collecter tous les composants liés"
    (components includes: aComponent) ifFalse: [
        components add: aComponent.

        "Récupérer et parcourir les entrées du composant"
        aComponent inputs do: [ :input | 
            input ifNotNil: [ self collectComponentsFrom: input ] ].
    ].
]

{ #category : 'accessing' }
Circuit >> components [ 
	^ components 
]

{ #category : 'instance creation' }
Circuit >> fromOutput: aComponent [
    "Naviguer dans les composants et les ajouter à la collection"
    components := OrderedCollection new.
    self collectComponentsFrom: aComponent.
]

{ #category : 'as yet unclassified' }
Circuit >> generateID [
	^ UUID new asString 
]

{ #category : 'initialization' }
Circuit >> initialize [ 
	id := self generateID 
]

{ #category : 'instance creation' }
Circuit >> printOn: aStream [
    aStream
        nextPutAll: 'Circuit (', id, ') with components: '; cr.
    components do: [ :each | 
        each printOn: aStream.
        aStream cr ].
]
