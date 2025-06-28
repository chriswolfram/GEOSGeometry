BeginPackage["ChristopherWolfram`GEOSGeometry`"];

Needs["ChristopherWolfram`GEOSGeometry`Utilities`"]
Needs["GEOSLink`" -> "GL`"]

GEOSGeometry

GEOSArea
GEOSLength
GEOSDistance
GEOSDistanceWithin
GEOSCentroid
GEOSHausdorffDistance

GEOSDisjoint
GEOSCovers
GEOSOverlaps
GEOSContains
GEOSTouches
GEOSIntersects
GEOSWithin
GEOSEquals

GEOSConvexHull
GEOSDelaunayMesh
GEOSVoronoiMesh

GEOSUnion
GEOSIntersection
GEOSDifference
GEOSSymmetricDifference

GEOSMerge

GEOSBoundary
GEOSBuffer

Begin["`Private`"];


(********************************* GEOSGeometry *********************************)

HoldPattern[GEOSGeometry][$Failed] := $Failed
HoldPattern[GEOSGeometry][_?(TrueQ@*GL`GEOSNullQ)] := $Failed
HoldPattern[GEOSGeometry][graphics:Except[_DataStructure]] := GEOSGeometry[GL`ToGEOS[graphics]]

HoldPattern[GEOSGeometry][geom_]["Raw"] := geom

geom_GEOSGeometry["Geometry"] := GL`FromGEOS[geom["Raw"]]
GEOSGeometry /: Normal[geom_GEOSGeometry] := geom["Geometry"]


MakeBoxes[geom_GEOSGeometry, form:StandardForm] :=
	ToBoxes[Panel[
		Graphics[{
			RGBColor[1/3, 1/3, 3/5],
			EdgeForm[Black],
			GL`FromGEOS[geom["Raw"]]
		}, ImageSize->Small]
	], form]


(********************************* Operations *********************************)

DeclareFunction[GEOSArea, iGEOSArea, 1];
iGEOSArea[geom_GEOSGeometry, opts_] := GL`GEOSArea[geom["Raw"]]

DeclareFunction[GEOSLength, iGEOSLength, 1];
iGEOSLength[geom_GEOSGeometry, opts_] := GL`GEOSLength[geom["Raw"]]

DeclareFunction[GEOSDistance, iGEOSDistance, 2];
iGEOSDistance[geom1_GEOSGeometry, geom2_GEOSGeometry, opts_] := GL`GEOSDistance[geom1["Raw"], geom2["Raw"]]

DeclareFunction[GEOSDistanceWithin, iGEOSDistanceWithin, 3];
iGEOSDistanceWithin[geom1_GEOSGeometry, geom2_GEOSGeometry, d_?NumberQ, opts_] := GL`GEOSDistanceWithin[geom1["Raw"], geom2["Raw"], d]

DeclareFunction[GEOSCentroid, iGEOSCentroid, 1];
iGEOSCentroid[geom_GEOSGeometry, opts_] := Replace[GEOSGeometry[GL`GEOSCentroid[geom["Raw"]]]["Geometry"], Point[c_] :> c]

DeclareFunction[GEOSHausdorffDistance, iGEOSHausdorffDistance, 2];
iGEOSHausdorffDistance[geom1_GEOSGeometry, geom2_GEOSGeometry, opts_] := GL`GEOSHausdorffDistance[geom1["Raw"], geom2["Raw"]]


DeclareFunction[GEOSDisjoint, iGEOSDisjoint, 2];
iGEOSDisjoint[geom1_GEOSGeometry, geom2_GEOSGeometry, opts_] := GL`GEOSDisjoint[geom1["Raw"], geom2["Raw"]]

DeclareFunction[GEOSCovers, iGEOSCovers, 2];
iGEOSCovers[geom1_GEOSGeometry, geom2_GEOSGeometry, opts_] := GL`GEOSCovers[geom1["Raw"], geom2["Raw"]]

DeclareFunction[GEOSOverlaps, iGEOSOverlaps, 2];
iGEOSOverlaps[geom1_GEOSGeometry, geom2_GEOSGeometry, opts_] := GL`GEOSOverlaps[geom1["Raw"], geom2["Raw"]]

DeclareFunction[GEOSContains, iGEOSContains, 2];
iGEOSContains[geom1_GEOSGeometry, geom2_GEOSGeometry, opts_] := GL`GEOSContains[geom1["Raw"], geom2["Raw"]]

DeclareFunction[GEOSTouches, iGEOSTouches, 2];
iGEOSTouches[geom1_GEOSGeometry, geom2_GEOSGeometry, opts_] := GL`GEOSTouches[geom1["Raw"], geom2["Raw"]]

DeclareFunction[GEOSIntersects, iGEOSIntersects, 2];
iGEOSIntersects[geom1_GEOSGeometry, geom2_GEOSGeometry, opts_] := GL`GEOSIntersects[geom1["Raw"], geom2["Raw"]]

DeclareFunction[GEOSWithin, iGEOSWithin, 2];
iGEOSWithin[geom1_GEOSGeometry, geom2_GEOSGeometry, opts_] := GL`GEOSWithin[geom1["Raw"], geom2["Raw"]]

DeclareFunction[GEOSEquals, iGEOSEquals, 2];
iGEOSEquals[geom1_GEOSGeometry, geom2_GEOSGeometry, opts_] := GL`GEOSEquals[geom1["Raw"], geom2["Raw"]]


DeclareFunction[GEOSConvexHull, iGEOSConvexHull, 1];
iGEOSConvexHull[geom_GEOSGeometry, opts_] := GEOSGeometry[GL`GEOSConvexHull[geom["Raw"]]]


Options[GEOSDelaunayMesh] = {
	"OnlyEdges" -> False,
	Tolerance -> 0
};
DeclareFunction[GEOSDelaunayMesh, iGEOSDelaunayMesh, 1];
iGEOSDelaunayMesh[geom_GEOSGeometry, opts_] :=
	GEOSGeometry@GL`GEOSDelaunayTriangulation[
		geom["Raw"],
		OptionValue[GEOSDelaunayMesh,opts,Tolerance],
		OptionValue[GEOSDelaunayMesh,opts,"OnlyEdges"]
	]


Options[GEOSVoronoiMesh] = {
	"OnlyEdges" -> False,
	Tolerance -> 0
};
DeclareFunction[GEOSVoronoiMesh, iGEOSVoronoiMesh, {1,2}];

iGEOSVoronoiMesh[geom_GEOSGeometry, env_GEOSGeometry, opts_] :=
	GEOSGeometry@GL`GEOSVoronoiMesh[
		geom["Raw"],
		env["Raw"],
		OptionValue[GEOSVoronoiMesh,opts,Tolerance],
		OptionValue[GEOSVoronoiMesh,opts,"OnlyEdges"]
	]

iGEOSVoronoiMesh[geom_GEOSGeometry, Automatic, opts_] :=
	GEOSGeometry@GL`GEOSVoronoiMeshAutomaticEnvelope[
		geom["Raw"],
		OptionValue[GEOSVoronoiMesh,opts,Tolerance],
		OptionValue[GEOSVoronoiMesh,opts,"OnlyEdges"]
	]

iGEOSVoronoiMesh[geom_GEOSGeometry, opts_] := iGEOSVoronoiMesh[geom, Automatic, opts]


DeclareFunction[GEOSUnion, iGEOSUnion, {1,2}];
iGEOSUnion[geom1_GEOSGeometry, geom2_GEOSGeometry, opts_] := GEOSGeometry[GL`GEOSUnion[geom1["Raw"], geom2["Raw"]]]
iGEOSUnion[geom_GEOSGeometry, opts_] := GEOSGeometry[GL`GEOSUnaryUnion[geom["Raw"]]]
iGEOSUnion[geoms:{___GEOSGeometry}, opts_] := GEOSGeometry[GL`GEOSUnaryUnion[GL`GEOSMerge[#["Raw"]&/@geoms]]]

DeclareFunction[GEOSIntersection, iGEOSIntersection, 2];
iGEOSIntersection[geom1_GEOSGeometry, geom2_GEOSGeometry, opts_] := GEOSGeometry[GL`GEOSIntersection[geom1["Raw"], geom2["Raw"]]]

DeclareFunction[GEOSDifference, iGEOSDifference, 2];
iGEOSDifference[geom1_GEOSGeometry, geom2_GEOSGeometry, opts_] := GEOSGeometry[GL`GEOSDifference[geom1["Raw"], geom2["Raw"]]]

DeclareFunction[GEOSSymmetricDifference, iGEOSSymmetricDifference, 2];
iGEOSSymmetricDifference[geom1_GEOSGeometry, geom2_GEOSGeometry, opts_] := GEOSGeometry[GL`GEOSSymmetricDifference[geom1["Raw"], geom2["Raw"]]]


DeclareFunction[GEOSMerge, iGEOSMerge, 1];
iGEOSMerge[geoms:{___GEOSGeometry}, opts_] := GEOSGeometry[GL`GEOSMerge[#["Raw"]&/@geoms]]


DeclareFunction[GEOSBoundary, iGEOSBoundary, 1];
iGEOSBoundary[geom_GEOSGeometry, opts_] := GEOSGeometry[GL`GEOSBoundary[geom["Raw"]]]

Options[GEOSBuffer] = {
	"Segments" -> 5
};
DeclareFunction[GEOSBuffer, iGEOSBuffer, 2];
iGEOSBuffer[geom_GEOSGeometry, rad_?NumberQ, opts_] := GEOSGeometry[GL`GEOSBuffer[geom["Raw"], rad, OptionValue[GEOSBuffer, opts, "Segments"]]]


End[];
EndPackage[];
