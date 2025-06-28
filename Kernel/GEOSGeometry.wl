BeginPackage["ChristopherWolfram`GEOSGeometry`"];

Needs["ChristopherWolfram`GEOSGeometry`Utilities`"]
Needs["GEOSLink`" -> "GL`"]

ToGEOS
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

(* Prepared geometry *)
GEOSPrepare
GEOSPreparedGeometry

Begin["`Private`"];


(********************************* GEOSGeometry *********************************)

ToGEOS[g_] := GEOSGeometry[GL`ToGEOS[g]]

GEOSGeometry[$Failed] := $Failed

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


(********************************* GEOSPreparedGeometry *********************************)

GEOSPrepare[geom_GEOSGeometry] := GEOSPreparedGeometry[geom, GL`GEOSPrepare[geom["Raw"]]]
GEOSPrepare[g_] := GEOSPrepare[ToGEOS[g]]
GEOSPrepare[$Failed] := $Failed

GEOSPreparedGeometry[_, $Failed] := $Failed

HoldPattern[GEOSPreparedGeometry][geom_, prep_]["GEOSGeometry"] := geom
HoldPattern[GEOSPreparedGeometry][geom_, prep_]["Raw"] := prep

prep_GEOSPreparedGeometry["Geometry"] := prep["GEOSGeometry"]["Geometry"]
GEOSPreparedGeometry /: Normal[prep_GEOSPreparedGeometry] := prep["GEOSGeometry"]


MakeBoxes[prep_GEOSPreparedGeometry, form:StandardForm] :=
	ToBoxes[Panel[
		Graphics[{
			RGBColor[1, 1/3, 3/5],
			EdgeForm[Black],
			prep["Geometry"]
		}, ImageSize->Small]
	], form]


(********************************* Operations *********************************)

GEOSArea[geom_GEOSGeometry] := GL`GEOSArea[geom["Raw"]]

GEOSLength[geom_GEOSGeometry] := GL`GEOSLength[geom["Raw"]]

GEOSDistance[geom1_GEOSGeometry, geom2_GEOSGeometry] := GL`GEOSDistance[geom1["Raw"], geom2["Raw"]]
GEOSDistance[prep_GEOSPreparedGeometry, geom_GEOSGeometry] := GL`GEOSPreparedDistance[prep["Raw"], geom["Raw"]]
GEOSDistance[geom_GEOSGeometry, prep_GEOSPreparedGeometry] := GL`GEOSPreparedDistance[prep["Raw"], geom["Raw"]]

GEOSDistanceWithin[geom1_GEOSGeometry, geom2_GEOSGeometry, d_] := GL`GEOSDistanceWithin[geom1["Raw"], geom2["Raw"], d]
GEOSDistanceWithin[prep_GEOSPreparedGeometry, geom_GEOSGeometry, d_] := GL`GEOSPreparedDistanceWithin[prep["Raw"], geom["Raw"], d]
GEOSDistanceWithin[geom_GEOSGeometry, prep_GEOSPreparedGeometry, d_] := GL`GEOSPreparedDistanceWithin[prep["Raw"], geom["Raw"], d]

GEOSCentroid[geom_GEOSGeometry] := Replace[GEOSGeometry[GL`GEOSCentroid[geom["Raw"]]]["Geometry"], Point[c_] :> c]

GEOSHausdorffDistance[geom1_GEOSGeometry, geom2_GEOSGeometry] := GL`GEOSHausdorffDistance[geom1["Raw"], geom2["Raw"]]


GEOSDisjoint[geom1_GEOSGeometry, geom2_GEOSGeometry] := GL`GEOSDisjoint[geom1["Raw"], geom2["Raw"]]
GEOSDisjoint[prep_GEOSPreparedGeometry, geom_GEOSGeometry] := GL`GEOSPreparedDisjoint[prep["Raw"], geom["Raw"]]
GEOSDisjoint[geom_GEOSGeometry, prep_GEOSPreparedGeometry] := GL`GEOSPreparedDisjoint[prep["Raw"], geom["Raw"]]

GEOSCovers[geom1_GEOSGeometry, geom2_GEOSGeometry] := GL`GEOSCovers[geom1["Raw"], geom2["Raw"]]
GEOSCovers[prep_GEOSPreparedGeometry, geom_GEOSGeometry] := GL`GEOSPreparedCovers[prep["Raw"], geom["Raw"]]
GEOSCovers[geom_GEOSGeometry, prep_GEOSPreparedGeometry] := GL`GEOSPreparedCovers[prep["Raw"], geom["Raw"]]

GEOSOverlaps[geom1_GEOSGeometry, geom2_GEOSGeometry] := GL`GEOSOverlaps[geom1["Raw"], geom2["Raw"]]

GEOSContains[geom1_GEOSGeometry, geom2_GEOSGeometry] := GL`GEOSContains[geom1["Raw"], geom2["Raw"]]
GEOSContains[prep_GEOSPreparedGeometry, geom_GEOSGeometry] := GL`GEOSPreparedContains[prep["Raw"], geom["Raw"]]
GEOSContains[geom_GEOSGeometry, prep_GEOSPreparedGeometry] := GL`GEOSPreparedContains[prep["Raw"], geom["Raw"]]

GEOSTouches[geom1_GEOSGeometry, geom2_GEOSGeometry] := GL`GEOSTouches[geom1["Raw"], geom2["Raw"]]
GEOSTouches[prep_GEOSPreparedGeometry, geom_GEOSGeometry] := GL`GEOSPreparedTouches[prep["Raw"], geom["Raw"]]
GEOSTouches[geom_GEOSGeometry, prep_GEOSPreparedGeometry] := GL`GEOSPreparedTouches[prep["Raw"], geom["Raw"]]

GEOSIntersects[geom1_GEOSGeometry, geom2_GEOSGeometry] := GL`GEOSIntersects[geom1["Raw"], geom2["Raw"]]
GEOSIntersects[prep_GEOSPreparedGeometry, geom_GEOSGeometry] := GL`GEOSPreparedIntersects[prep["Raw"], geom["Raw"]]
GEOSIntersects[geom_GEOSGeometry, prep_GEOSPreparedGeometry] := GL`GEOSPreparedIntersects[prep["Raw"], geom["Raw"]]

GEOSWithin[geom1_GEOSGeometry, geom2_GEOSGeometry] := GL`GEOSWithin[geom1["Raw"], geom2["Raw"]]

GEOSEquals[geom1_GEOSGeometry, geom2_GEOSGeometry] := GL`GEOSEquals[geom1["Raw"], geom2["Raw"]]


GEOSConvexHull[geom_GEOSGeometry] := GEOSGeometry[GL`GEOSConvexHull[geom["Raw"]]]


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


GEOSUnion[geom1_GEOSGeometry, geom2_GEOSGeometry] := GEOSGeometry[GL`GEOSUnion[geom1["Raw"], geom2["Raw"]]]
GEOSUnion[geom_GEOSGeometry] := GEOSGeometry[GL`GEOSUnaryUnion[geom["Raw"]]]
GEOSUnion[geoms:{___GEOSGeometry}] := GEOSGeometry[GL`GEOSUnaryUnion[GL`GEOSMerge[#["Raw"]&/@geoms]]]

GEOSIntersection[geom1_GEOSGeometry, geom2_GEOSGeometry] := GEOSGeometry[GL`GEOSIntersection[geom1["Raw"], geom2["Raw"]]]

GEOSDifference[geom1_GEOSGeometry, geom2_GEOSGeometry] := GEOSGeometry[GL`GEOSDifference[geom1["Raw"], geom2["Raw"]]]

GEOSSymmetricDifference[geom1_GEOSGeometry, geom2_GEOSGeometry] := GEOSGeometry[GL`GEOSSymmetricDifference[geom1["Raw"], geom2["Raw"]]]


GEOSMerge[geoms:{___GEOSGeometry}] := GEOSGeometry[GL`GEOSMerge[#["Raw"]&/@geoms]]


GEOSBoundary[geom_GEOSGeometry] := GEOSGeometry[GL`GEOSBoundary[geom["Raw"]]]

Options[GEOSBuffer] = {
	"Segments" -> 5
};
DeclareFunction[GEOSBuffer, iGEOSBuffer, 2];
iGEOSBuffer[geom_GEOSGeometry, rad_?NumberQ, opts_] := GEOSGeometry[GL`GEOSBuffer[geom["Raw"], rad, OptionValue[GEOSBuffer, opts, "Segments"]]]


End[];
EndPackage[];
