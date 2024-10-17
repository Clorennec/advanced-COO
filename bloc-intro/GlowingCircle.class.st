Class {
	#name : 'GlowingCircle',
	#superclass : 'BlElement',
	#instVars : [
		'on'
	],
	#category : 'bloc-intro',
	#package : 'bloc-intro'
}

{ #category : 'instance creation' }
GlowingCircle class >> newWithSize: size [
    ^ self new initializeWithSize: size
]

{ #category : 'initialization' }
GlowingCircle >> initializeWithSize: size [
	self geometry: BlCircleGeometry new.
	self extent: size @ size.
	self background: Color white.
	self lightOn.
	self on: true.
	self
		addEventHandlerOn: BlMouseDownEvent
		do: [ :event | self toggleGlowEffect ].
	^ self
]

{ #category : 'testing' }
GlowingCircle >> isOn [ 
	^on
]

{ #category : 'as yet unclassified' }
GlowingCircle >> lightOff [
	self on: false.
	self background: Color black.
	self effect: nil
]

{ #category : 'as yet unclassified' }
GlowingCircle >> lightOn [

	| glowEffect|
	glowEffect := BlGaussianShadowEffect color: Color white offset: 0 @ 0 width: 30.
	glowEffect extraShadowSpace.
	self background: Color white.
	self on: true.
	self effect: glowEffect
]

{ #category : 'testing' }
GlowingCircle >> on: aBool [
	on := aBool 
]

{ #category : 'as yet unclassified' }
GlowingCircle >> toggleGlowEffect [
    self on: (self isOn) not.  "Inverser l'état"
    self isOn ifTrue: [ self lightOn ] ifFalse: [ self lightOff ].
]
