Class {
	#name : 'SpriteElement',
	#superclass : 'BlElement',
	#instVars : [
		'spriteCollection',
		'currentIndex',
		'totalImages',
		'running',
		'position',
		'velocity',
		'size'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'initialization' }
SpriteElement >> initializeWith: aSpriteCollection [

	spriteCollection := aSpriteCollection.
       currentIndex := 1.
       totalImages := spriteCollection images size.
       self extent: 100@100.
       self background: (spriteCollection images at: currentIndex).
       running := false. "Permet de contrôler l'animation"
]

{ #category : 'as yet unclassified' }
SpriteElement >> initializeWith: aSpriteCollection size: aSize [
       spriteCollection := aSpriteCollection.
       currentIndex := 1.
       totalImages := spriteCollection images size.
       position := 0@0.
       velocity := 5@5.
       size := aSize ifNil: [ 100@100 ]. "Définir une taille par défaut si non spécifiée"
       self extent: size.
       self background: (spriteCollection images at: currentIndex).
       running := false.
]

{ #category : 'as yet unclassified' }
SpriteElement >> startAnimation [

	running := true.
	[
	[ running ] whileTrue: [
		currentIndex := currentIndex + 1.
		currentIndex > totalImages ifTrue: [ currentIndex := 1 ].
		self background: (spriteCollection images at: currentIndex).
		30 milliSeconds wait ] ] fork
]

{ #category : 'as yet unclassified' }
SpriteElement >> startAnimation: anInteger [

	running := true.
	[
	[ running ] whileTrue: [
		currentIndex := currentIndex + 1.
		currentIndex > totalImages ifTrue: [ currentIndex := 1 ].
		self background: (spriteCollection images at: currentIndex).
		anInteger milliSeconds wait ] ] fork
]

{ #category : 'as yet unclassified' }
SpriteElement >> stopAnimation [
       running := false.
]

{ #category : 'accessing' }
SpriteElement >> velocity: anInteger [
	velocity := anInteger 
]
