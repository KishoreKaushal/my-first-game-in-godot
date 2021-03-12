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

## Chapter 4: Setting Physics Layer

`Menu bar > Project > Project Settings > Layer Names (in Left Panel) > 2d Physics > Name your physics layer`

Set the following:

* Layer 1 -- player
* Layer 2 -- enemies
* Layer 3 -- coins
* Layer 4 -- world

Now we need to set the `collision_layer` and collision `collision_mask` for the various scenes. Please follow this link for getting the detail description of them: 

https://godotengine.org/qa/4010/whats-difference-between-collision-layers-collision-masks


`TileMap > Inspector > Collision > Layer > select world`
`TileMap > Inspector > Collision > Mask > deselect all`

Basically this means that `TileMap` will reside in world layer and it won't scan for any collisions.

Similarly for player:

`Player.tscn > Inspector > PhysicsBody2D > Collision > Layer > select player`

`Player.tscn > Inspector > PhysicsBody2D > Collision > Mask > select world`

This means that any instance of `Player` by default will reside in player layer and it will scan for any collisions with any object in world layer.

## Chapter 5: Coding the input

To set up the movement keys to control the player:

`Project > Project Settings > Input Map`

Set the following keymaps:

* move_left -- A
* move_right -- D
* jump -- W

Add the movement code to `Player.gd` script.

This code will contain the following:

* handling move_left, move_right and jump
* jump only when on floor 
* implementing interrupt jump like mario

Here is a demo:

![coding the input](./img/chapter5demo.gif "coding the input")

![interrupting jump](./img/chapter5interruptingjump.gif "interrupting jump")

> A private variable in GDScript starts with underscore character.

## Chapter 6: Creating Enemies

Duplicate `res://src/Actors/Player.tscn` to create an `res://src/Actors/Enemy.tscn`.

Rename the scene and sprite name while selecting `Enemy.tscn` and then replace the sprite of the enemy node. 

`Select Enemy Scene > Right Click > Extend Script > Inherit from Actor.gd`

Change `collision_layer` to `enemies` layer and `collision_mask` to `player` and `world`.

Add code for changing the direction when hit wall. At this point you will have a demo like this:

![enemy collision](./img/chapter6enemycollisiondemo.gif "enemy collision")


## Chapter 7: Optimizing with VisibilityEnabler2D

First optimization is to stop processing physics when enemy is out of view. To do this add `VisibilityEnabler2D` child node to `Enemy` node and enable `process_parent` and `physics_process_parent` for this node. This will stop the `_physics_process()` when enemy go out of the view, but we also need to stop the `_physics_process()` when the enemy is out of the scene when the game starts. This can be done within the code by adding `set_physics_process(false)` in `_ready()` for enemy.

Also, you need to adjust the size of the `VisibilityEnabler2D` node.

![visibility enabler rect size](./img/chapter7visibilityenablernodesize.png "visibility enabler rect size")

> Ctrl + Shift + O : open a scene

Now we need to add `Camera2D` to test visibility enabler in action.

`Player > Add Camera2D child node > Check the current property for Camera2D node`

Here is the demo at this step.

![visibility camera](./img/chapter7visibilitycamerademo.gif "visibility camera")

## Chapter 8: Stomping the Enemy

Adding a new `Area2D` node above enemy to detect the stomp. Call it `StompDetector`. Select the enemies `collision_layer`. Now add a child node `CollisionShape2D` and select rectangle shape. Size the shape appropriately. Change the color of `StompDetector` or `CollisionShape2D` so it can be distinguished easily.

`StompDetector > Inspector > CanvasItem > Visibility > Modulate`

This color will be visible if `Debug > Visible Collision Shape` is checked.

![stomp collision area](./img/chapter8stompcollisionshape.png "stomp collision area")

Now we need to add signals so that when a player enter the stomp detector regeion we react to that. You can click on the `Node` panel on the right hand side of the godot UI to see the list of signals emitted for any particular node.

![signals emitted for stomp detector node](./img/chapter8signalsemittedforstompdetectornode.png "signals emitted for stomp detector node")

We will use `body_entered` signal which detects the entry of `PhysicalBody2D`. Double click on that signal and a window will appear which will allow us to connect that signal to a method for the `Enemy` node.

![connect signal to method](./img/chapter8connectingsignaltoamethod.png "connect signal to method")

Noow we need to complete the `func _on_StompDetector_body_entered(body: Node) -> void:` to make the enemy die. 

Here is the demo:

![killing enemy](./img/chapter8stompingandkillingenemy.gif "killing enemy")

Now we need to add the stomping related code for the player node. Similar to `StompDetector` node for the enemy add one `EnemyDetector` for player. Select enemies layer for `collision_mask`. And connect a method to signal `area_entered` and add logic for stomp pulse. 

Here is the demo:

![stomp impulse](./img/chapter8stompimpulse.gif "stomp impulse")

## Chapter 9: Player's Death

Defining `body_entered` signal for `EnemyDetector`. here is the demo:

![death](./img/chapter9death.gif "death")

![stomping enemy](./img/chapter9stompingenemy.gif "stomping enemy")

> Important: You have to adjust the size of EnemyDetector margin and StompDetector size to get correct working code. Shown below is a demo where a non-appropriate size of the StompDetector will screw up the stomp function. 

![buggy stomp](./img/chapter9buggystomp.gif "buggy stomp")

## Chapter 10: Improving the camera

First make the `LevelTemplate` bigger.

![big level](./img/chapter10lvltemplatebigger.png "big level")

Now we need to change `Camera2D` properties in the `Player` scene.

Set the `limit_left` and `limit_top` property to `0`. This will limit the camera's `x` and `y` coordinate. Hence, camera area can't go in an area where `x < 0` or `y < 0`. Also, turn on the `limit_smoothed` property. This will smoothen the camera movement. 

Now set the `drag_margin_left` and `drag_margin_right` to `0`. As `drag_margin` specifies the margin to drag the camera and we want our camera to be centered around the player along the horzontal axis. Also, enable `drag_margin_h_enabled` and `drag_margin_v_enabled` property, otherwise `drag_margin` properties wouldn't do anything.

To move camera smoothly enable the `smoothing_enabled` option.

## Chapter 11: Creating a mini level and adding background

