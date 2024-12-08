Class {
	#name : 'BaselineOfBoum',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfBoum',
	#package : 'BaselineOfBoum'
}

{ #category : 'baselines' }
BaselineOfBoum >> baseline: spec [
	<baseline>
	spec 
		for: #common
		do: [
			spec 
				package: 'Boum'
				with: [ 
					spec requires: #('Toplo' 'Bloc').
				].

			spec baseline: 'Toplo' 
				with: [ spec repository: 'github://pharo-graphics/Toplo:v0.3.0/src' ].

			spec baseline: 'Bloc' 
				with: [ spec repository: 'github://pharo-graphics/Bloc:main/src' ].
		].
]
