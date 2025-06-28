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

GEOSRaw[GEOSGeometry[geom_]] := geom
geom_GEOSGeometry["Raw"] := GEOSRaw[geom]

geom_GEOSGeometry["Geometry"] := GL`FromGEOS[GEOSRaw[geom]]
GEOSGeometry /: Normal[geom_GEOSGeometry] := geom["Geometry"]


MakeBoxes[geom_GEOSGeometry, form:StandardForm] :=
	ToBoxes[Panel[
		Graphics[{
			RGBColor[1/3, 1/3, 3/5],
			EdgeForm[Black],
			GL`FromGEOS[GEOSRaw[geom]]
		}, ImageSize->Small]
	], form]


(********************************* GEOSPreparedGeometry *********************************)

GEOSPrepare[geom_GEOSGeometry] := GEOSPreparedGeometry[geom, GL`GEOSPrepare[GEOSRaw[geom]]]
GEOSPrepare[g_] := GEOSPrepare[ToGEOS[g]]
GEOSPrepare[$Failed] := $Failed

GEOSPreparedGeometry[_, $Failed] := $Failed

GEOSPreparedRaw[GEOSPreparedGeometry[geom_, prep_]] := prep
HoldPattern[GEOSPreparedGeometry][geom_, prep_]["GEOSGeometry"] := geom
prep_GEOSPreparedGeometry["Raw"] := GEOSPreparedRaw[prep]

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

GEOSArea[geom_GEOSGeometry] := GL`GEOSArea[GEOSRaw[geom]]

GEOSLength[geom_GEOSGeometry] := GL`GEOSLength[GEOSRaw[geom]]

GEOSDistance[geom1_GEOSGeometry, geom2_GEOSGeometry] := GL`GEOSDistance[GEOSRaw[geom1], GEOSRaw[geom2]]
GEOSDistance[prep_GEOSPreparedGeometry, geom_GEOSGeometry] := GL`GEOSPreparedDistance[GEOSPreparedRaw[prep], GEOSRaw[geom]]
GEOSDistance[geom_GEOSGeometry, prep_GEOSPreparedGeometry] := GL`GEOSPreparedDistance[GEOSPreparedRaw[prep], GEOSRaw[geom]]

GEOSDistanceWithin[geom1_GEOSGeometry, geom2_GEOSGeometry, d_] := GL`GEOSDistanceWithin[GEOSRaw[geom1], GEOSRaw[geom2], d]
GEOSDistanceWithin[prep_GEOSPreparedGeometry, geom_GEOSGeometry, d_] := GL`GEOSPreparedDistanceWithin[GEOSPreparedRaw[prep], GEOSRaw[geom], d]
GEOSDistanceWithin[geom_GEOSGeometry, prep_GEOSPreparedGeometry, d_] := GL`GEOSPreparedDistanceWithin[GEOSPreparedRaw[prep], GEOSRaw[geom], d]

GEOSCentroid[geom_GEOSGeometry] := Replace[GEOSGeometry[GL`GEOSCentroid[GEOSRaw[geom]]]["Geometry"], Point[c_] :> c]

GEOSHausdorffDistance[geom1_GEOSGeometry, geom2_GEOSGeometry] := GL`GEOSHausdorffDistance[GEOSRaw[geom1], GEOSRaw[geom2]]


GEOSDisjoint[geom1_GEOSGeometry, geom2_GEOSGeometry] := GL`GEOSDisjoint[GEOSRaw[geom1], GEOSRaw[geom2]]
GEOSDisjoint[prep_GEOSPreparedGeometry, geom_GEOSGeometry] := GL`GEOSPreparedDisjoint[GEOSPreparedRaw[prep], GEOSRaw[geom]]
GEOSDisjoint[geom_GEOSGeometry, prep_GEOSPreparedGeometry] := GL`GEOSPreparedDisjoint[GEOSPreparedRaw[prep], GEOSRaw[geom]]

GEOSCovers[geom1_GEOSGeometry, geom2_GEOSGeometry] := GL`GEOSCovers[GEOSRaw[geom1], GEOSRaw[geom2]]
GEOSCovers[prep_GEOSPreparedGeometry, geom_GEOSGeometry] := GL`GEOSPreparedCovers[GEOSPreparedRaw[prep], GEOSRaw[geom]]
GEOSCovers[geom_GEOSGeometry, prep_GEOSPreparedGeometry] := GL`GEOSPreparedCovers[GEOSPreparedRaw[prep], GEOSRaw[geom]]

GEOSOverlaps[geom1_GEOSGeometry, geom2_GEOSGeometry] := GL`GEOSOverlaps[GEOSRaw[geom1], GEOSRaw[geom2]]

GEOSContains[geom1_GEOSGeometry, geom2_GEOSGeometry] := GL`GEOSContains[GEOSRaw[geom1], GEOSRaw[geom2]]
GEOSContains[prep_GEOSPreparedGeometry, geom_GEOSGeometry] := GL`GEOSPreparedContains[GEOSPreparedRaw[prep], GEOSRaw[geom]]
GEOSContains[geom_GEOSGeometry, prep_GEOSPreparedGeometry] := GL`GEOSPreparedContains[GEOSPreparedRaw[prep], GEOSRaw[geom]]

GEOSTouches[geom1_GEOSGeometry, geom2_GEOSGeometry] := GL`GEOSTouches[GEOSRaw[geom1], GEOSRaw[geom2]]
GEOSTouches[prep_GEOSPreparedGeometry, geom_GEOSGeometry] := GL`GEOSPreparedTouches[GEOSPreparedRaw[prep], GEOSRaw[geom]]
GEOSTouches[geom_GEOSGeometry, prep_GEOSPreparedGeometry] := GL`GEOSPreparedTouches[GEOSPreparedRaw[prep], GEOSRaw[geom]]

GEOSIntersects[geom1_GEOSGeometry, geom2_GEOSGeometry] := GL`GEOSIntersects[GEOSRaw[geom1], GEOSRaw[geom2]]
GEOSIntersects[prep_GEOSPreparedGeometry, geom_GEOSGeometry] := GL`GEOSPreparedIntersects[GEOSPreparedRaw[prep], GEOSRaw[geom]]
GEOSIntersects[geom_GEOSGeometry, prep_GEOSPreparedGeometry] := GL`GEOSPreparedIntersects[GEOSPreparedRaw[prep], GEOSRaw[geom]]

GEOSWithin[geom1_GEOSGeometry, geom2_GEOSGeometry] := GL`GEOSWithin[GEOSRaw[geom1], GEOSRaw[geom2]]

GEOSEquals[geom1_GEOSGeometry, geom2_GEOSGeometry] := GL`GEOSEquals[GEOSRaw[geom1], GEOSRaw[geom2]]


GEOSConvexHull[geom_GEOSGeometry] := GEOSGeometry[GL`GEOSConvexHull[GEOSRaw[geom]]]


Options[GEOSDelaunayMesh] = {
	"OnlyEdges" -> False,
	Tolerance -> 0
};
DeclareFunction[GEOSDelaunayMesh, iGEOSDelaunayMesh, 1];
iGEOSDelaunayMesh[geom_GEOSGeometry, opts_] :=
	GEOSGeometry@GL`GEOSDelaunayTriangulation[
		GEOSRaw[geom],
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
		GEOSRaw[geom],
		GEOSRaw[env],
		OptionValue[GEOSVoronoiMesh,opts,Tolerance],
		OptionValue[GEOSVoronoiMesh,opts,"OnlyEdges"]
	]

iGEOSVoronoiMesh[geom_GEOSGeometry, Automatic, opts_] :=
	GEOSGeometry@GL`GEOSVoronoiMeshAutomaticEnvelope[
		GEOSRaw[geom],
		OptionValue[GEOSVoronoiMesh,opts,Tolerance],
		OptionValue[GEOSVoronoiMesh,opts,"OnlyEdges"]
	]

iGEOSVoronoiMesh[geom_GEOSGeometry, opts_] := iGEOSVoronoiMesh[geom, Automatic, opts]


GEOSUnion[geom1_GEOSGeometry, geom2_GEOSGeometry] := GEOSGeometry[GL`GEOSUnion[GEOSRaw[geom1], GEOSRaw[geom2]]]
GEOSUnion[geom_GEOSGeometry] := GEOSGeometry[GL`GEOSUnaryUnion[GEOSRaw[geom]]]
GEOSUnion[geoms:{___GEOSGeometry}] := GEOSGeometry[GL`GEOSUnaryUnion[GL`GEOSMerge[GEOSRaw/@geoms]]]

GEOSIntersection[geom1_GEOSGeometry, geom2_GEOSGeometry] := GEOSGeometry[GL`GEOSIntersection[GEOSRaw[geom1], GEOSRaw[geom2]]]

GEOSDifference[geom1_GEOSGeometry, geom2_GEOSGeometry] := GEOSGeometry[GL`GEOSDifference[GEOSRaw[geom1], GEOSRaw[geom2]]]

GEOSSymmetricDifference[geom1_GEOSGeometry, geom2_GEOSGeometry] := GEOSGeometry[GL`GEOSSymmetricDifference[GEOSRaw[geom1], GEOSRaw[geom2]]]


GEOSMerge[geoms:{___GEOSGeometry}] := GEOSGeometry[GL`GEOSMerge[GEOSRaw/@geoms]]


GEOSBoundary[geom_GEOSGeometry] := GEOSGeometry[GL`GEOSBoundary[GEOSRaw[geom]]]

Options[GEOSBuffer] = {
	"Segments" -> 5
};
DeclareFunction[GEOSBuffer, iGEOSBuffer, 2];
iGEOSBuffer[geom_GEOSGeometry, rad_?NumberQ, opts_] := GEOSGeometry[GL`GEOSBuffer[GEOSRaw[geom], rad, OptionValue[GEOSBuffer, opts, "Segments"]]]


End[];
EndPackage[];
