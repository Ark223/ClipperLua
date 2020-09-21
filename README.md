# ClipperLua

**Clipper** - The Clipper library performs clipping, offsetting and triangulation for polygons.
All four boolean clipping operations are supported - intersection, union, difference and exclusive-or.

Polygons can be of any shape including self-intersecting polygons. The library is based on
Vatti's clipping algorithm and runs on beta version 10.0 which is a significant rewrite of
previous versions and it's improved in terms of performance.  

The repository contains the compiled dll library supporting both 32 and 64-bit Windows OS
and uses FFI binding solution to work with LuaJIT (Just-In-Time) programming language.  

You can find more details in the official page:
http://www.angusj.com/delphi/clipper/documentation/Docs/Overview/_Body.htm

## Demonstration

```lua
> White color - subject polygon
> Blue color - clip polygon
> Green color - solution (even-odd intersection operation)
> Yellow color - offset solution (round type, delta = 15)
> Red color - inner triangulation of solution
```
![Mode: Intersection, EvenOdd](https://i.imgur.com/meVOoqZ.png)

## Performance

```lua
Time (secs) to intersect 2 complex polygons - a subject and a clip
polygon - having random coordinates and varying numbers of vertices.
```
| No. vertices | Clipper v10.0 | Clipper v6.4.2 |
|    :---:     |     :---:     |     :---:      |
| 50           | 0.001s        | 0.001s         |
| 100          | 0.002s        | 0.003s         |
| 200          | 0.009s        | 0.019s         |
| 500          | 0.058s        | 0.084s         |
| 1000         | 0.255s        | 0.5s           |
| 1500         | 0.8s          | 1.87s          |
| 2000         | 2.05s         | 4.8s           |

## API

```lua
1. Point:
+ void. New(number x, number y)
+ number: InPolygon(Path path)

2. Path:
+ void. New()
+ Point: Get(number i)
+ void: Add(Point pt)
+ number: Size()
+ number: Area()
+ bool: Orientation()
+ void: Reverse()
+ Paths: Simplify(number fillRule = FillRule.EvenOdd)

3. Paths:
+ void. New()
+ Path: Get(number i)
+ void: Add(Path path)
+ number: Size()
+ void: Reverse()
+ Paths: Simplify(number fillRule = FillRule.EvenOdd)
+ Paths: Offset(number delta, number joinType = JoinType.Round, number endType =
	EndType.Polygon, number miterLimit = 2.0, number arcTolerance = 0.0)
+ Paths: Triangulate(number fillRule = FillRule.EvenOdd)

4. Clipper:
+ void. New()
+ void: AddPath(Path path, number pathType, bool open = false)
+ void: AddPaths(Paths paths, number pathType, bool open = false)
+ Paths: Execute(number clipType = ClipType.Intersection,
	number fillRule = FillRule.EvenOdd)

5. ClipperOffset:
+ void. New(number miterLimit = 2.0, number arcTolerance = 0.0)
+ void: AddPath(Path path, number joinType =
	JoinType.Round, number endType = EndType.Polygon)
+ void: AddPaths(Paths path, number joinType =
	JoinType.Round, number endType = EndType.Polygon)
+ Paths: Execute(number delta)

6. ClipperTri:
+ void. New()
+ void: AddPath(Path path)
+ void: AddPaths(Paths paths)
+ Paths: Execute(number fillRule = FillRule.EvenOdd)
```
