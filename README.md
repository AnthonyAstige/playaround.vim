# Playaround v0.0.0

VIM Playaround

## Use

```
:PlayaroundToggle
```

When saving a file it will execute with command and display in a new window split

## TODO

* Don't destroy window for refresh
	* This loses any positioning
	* Was having trouble remembering window/buffer/...? so went this route
		* Maybe can use one of those functions to destroy buffer but not window?
* Make :PlayaroundToggle apply to current buffer only and not globally
	* Will be useful to usine this in a vim tab seperate from others
* Document
* Promote / get reviews / ...

## Inspirations

XCode Playground
