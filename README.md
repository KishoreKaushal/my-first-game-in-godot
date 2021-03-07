My first game in Godot.

Referring to GDQuest Tutorials.

## Chapter 1 : Creating the player scene

We need to create a `Player` node which will be a `KinematicBody2D` so that it can be controlled (moved around the world) and can detect collisions.

`Other Node > KinematicBody2D`

This node requires a collision shape and geometric shape to detect collisions. Hence, add a child node (right-click on `Player` node to get menu) `CollisionShape2D` node to the `Player`.

`Other Node > CollisionShape2D`

(*Hit Box*) Add geometric shape resource to collision node.

`Inspector > Shape > (select hit box shape)`

Then, we need to add sprite (gamedev terminology for bitmap image) to `Player` node. Drag and drop your image from `res://` to scene and select sprite from pop up option (latest godot version automatically add this as sprite).

> G : toggle grid

Turn on pixel snap and center the sprite on the origin and resize the hitbox shape appropriately.

At this point we need to save our player scene. 

> Ctrl + S : save

`Ctrl + S > Add New Folder 'Actors' > save your player`


## Chapter 2: Setting up the Player scripts

Now, we will write some script for the player.


Create a script `res://src/Actors/Player.gd`

1. Select Player node from Scene panel.
2. Click attach node script icon.
3. Configure your settings.

Create another script `res://src/Actors/Actor.gd` which will define base class `Actor` for both the player and enemies. `Actor` inherits `KinematicBody2D`. Then define `_physics_process()` function to modify velocity.
