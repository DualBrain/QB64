[Home](https://qb64.com) • [Forums](https://qb64.boards.net/) • [News](news.md) • [GitHub](https://github.com/QB64Official/qb64) • [Wiki](https://github.com/QB64Official/qb64/wiki) • [Samples](samples.md) • [InForm](inform.md) • [GX](gx.md) • [QBjs](qbjs.md) • [Community](community.md) • [More...](more.md)

## GX

![ZeldaGX](https://qb64forum.alephc.xyz/index.php?action=dlattach;topic=4528.0;attach=18051;image)

GX is a basic game engine... literally. This is a Game(G) Engine(X) built with and for QB64, a QBasic/QuickBASIC IDE and compiler with modern extensions.

GX supports basic 2D gaming: platformer, top-down, etc... you know, classic NES/SNES type games. The engine also provides support for isometric tiled games as well.

The goal here is to create a flexible, event-based game engine. Based on your game requirements you can use as much or as little of it as you need, but the engine will take care of the main tasks of managing the game loop and screen buffering for the display.

The current alpha build has support for:

* Scene(viewport) management
* Entity(sprite) management
* Tiled map creation and management
  * Including a world/map editor
  * Support for layered tiles
  * Support for animated tiles
  * Support for orthogonal and isometric tilesets
* Bitmap font support
* Collision detection
* Basic physics/gravity
* Device input management
  * Keyboard, mouse, and game controller
* Interactive debugging
* Export to Web

- [GitHub Repo](https://github.com/boxgaming/gx)

### Sleighless

Oh no! Santa has fallen out of the sleigh!  Rudolph is gone and now Santa must save Christmas alone and... Sleighless!  This is a [demonstration](https://boxgm.itch.io/sleighless) of the GX game engine's ability to export games built in QB64 to the web.

- [run in browser](https://boxgm.itch.io/sleighless)
- [download](downloads/santa.zip) 
- [more...](https://qb64forum.alephc.xyz/index.php?topic=4454.msg139230#msg139230)

### Zelda - The Legend of GX

![ZeldaGX](https://qb64forum.alephc.xyz/index.php?action=dlattach;topic=4528.0;attach=18051;image)

Since there are a number of zelda projects currently in-progress, I thought I'd put together a little version as a shameless plug for GX.  One of my current game projects is actually a NES mashup that will have crossover from a number of titles.  So I already had the map built using the GX map editor.  This version will let you walk the entire overworld map.  As an example I've also implemented the lost woods maze.  There are triggers on the map for all of the cave and dungeon entrances.  At the moment this will take you to an empty cave map. (I haven't built any dungeon maps.)  If you exit the cave it reloads the overworld map and puts you back in the right spot. 

- [download](downloads/legend-of-gx.zip) 
- [more...](https://qb64forum.alephc.xyz/index.php?topic=4528.0)
