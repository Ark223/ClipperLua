local C = require "ClipperLib"
local Point, Path, Paths, Clipper =
	C.Point, C.Path, C.Paths, C.Clipper

local subj = Paths()

local s1 = Path()
s1:Add(Point(180, 200))
s1:Add(Point(260, 200))
s1:Add(Point(260, 150))
s1:Add(Point(180, 150))
subj:Add(s1)

local s2 = Path()
s2:Add(Point(215, 160))
s2:Add(Point(230, 190))
s2:Add(Point(200, 190))
subj:Add(s2)

local clip = Paths()

local c1 = Path()
c1:Add(Point(190, 210))
c1:Add(Point(240, 210))
c1:Add(Point(240, 130))
c1:Add(Point(190, 130))
clip:Add(c1)

local c = Clipper()
c:AddPaths(subj, PathType.Subject, false)
c:AddPaths(clip, PathType.Clip, false)
local solution = c:Execute(ClipType.Intersection, FillRule.EvenOdd)

for i = 1, solution:Size() do
	local path = solution:Get(i)
	print(i .. ". ")
	for j = 1, path:Size() do
		local point = path:Get(j)
		print(point.x, point.y)
	end
end
