# My first game in Godot

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

## Chapter 3: Adding floor

Let's create our template level.

`Scene > New Scene > 2D Scene`

Add a TileMap.

> Ctrl + A : Add child node.

`Ctrl + A > TileMap`

Create a new tile map. A tile map needs a tile map resource (Tile Set). 

`Select TileMap > Inspector > Tile Set > New Tile Set`

Load an image asset in tile editor and chop it to create tiles.

1. `New Single Tile > Select Snap options`
2. `Inspector > Snap Options > Set Step to (80 x 80)`
3. Select a region in tile editor.
4. Add collision property: `Collision > Select rect icon`
5. Now click and drag tiles in `LevelTemplate` scene to create walls.
6. Make sure that cell size match tile set. `Select TileMap > Inspector > Cell > Set Size to (80 x 80)`
7. Drag player as child of `LevelTemplate` and play.

At this point your godot should look like this:

![chapter3end](./img/chapter3end.png "Added Floor")

## Chapter 4: 