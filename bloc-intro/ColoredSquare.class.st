Class {
	#name : 'ColoredSquare',
	#superclass : 'BlElement',
	#category : 'bloc-intro',
	#package : 'bloc-intro'
}

{ #category : 'instance creation' }
ColoredSquare class >> newWithSize: size [
        ^ self new initializeWithSize: size
]

{ #category : 'initialization' }
ColoredSquare >> initializeWithSize: size [

	self extent: size @ size. "Définir la taille du carré"
	self background: Color random. "Remplir le carré avec une couleur aléatoire"
	^ self
]
