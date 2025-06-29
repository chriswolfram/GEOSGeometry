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
geosGeometryListRaw[l_] := l[[All,1]]

geom_GEOSGeometry["Geometry"] := GL`FromGEOS[geom["Raw"]]
GEOSGeometry /: Normal[geom_GEOSGeometry] := geom["Geometry"]


MakeBoxes[geom_GEOSGeometry, form:StandardForm] :=
	ToBoxes[Panel[
		Graphics[{
			RGBColor[1/3, 1/3, 3/5],
			EdgeForm[Black],
			geom["Geometry"]
		}, ImageSize->Small]
	], form]


(********************************* GEOSPreparedGeometry *********************************)

GEOSPrepare[GEOSGeometry[rawGeom_]] := GEOSPreparedGeometry[GL`GEOSPrepare[rawGeom], rawGeom]
GEOSPrepare[g_] := GEOSPrepare[ToGEOS[g]]
GEOSPrepare[$Failed] := $Failed

GEOSPreparedGeometry[$Failed, _] := $Failed

HoldPattern[GEOSPreparedGeometry][prep_, geom_]["GEOSGeometry"] := GEOSGeometry[geom]
HoldPattern[GEOSPreparedGeometry][prep_, geom_]["Raw"] := prep

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

GEOSArea[GEOSGeometry[rawGeom_]] := GL`GEOSArea[rawGeom]

GEOSLength[GEOSGeometry[rawGeom_]] := GL`GEOSLength[rawGeom]

GEOSDistance[GEOSGeometry[rawGeom1_], GEOSGeometry[rawGeom2_]] := GL`GEOSDistance[rawGeom1, rawGeom2]
GEOSDistance[GEOSPreparedGeometry[rawPrep_,_], GEOSGeometry[rawGeom_]] := GL`GEOSPreparedDistance[rawPrep, rawGeom]
GEOSDistance[GEOSGeometry[rawGeom_], GEOSPreparedGeometry[rawPrep_,_]] := GL`GEOSPreparedDistance[rawPrep, rawGeom]

GEOSDistanceWithin[GEOSGeometry[rawGeom1_], GEOSGeometry[rawGeom2_], d_] := GL`GEOSDistanceWithin[rawGeom1, rawGeom2, d]
GEOSDistanceWithin[GEOSPreparedGeometry[rawPrep_,_], GEOSGeometry[rawGeom_], d_] := GL`GEOSPreparedDistanceWithin[rawPrep, rawGeom, d]
GEOSDistanceWithin[GEOSGeometry[rawGeom_], GEOSPreparedGeometry[rawPrep_,_], d_] := GL`GEOSPreparedDistanceWithin[rawPrep, rawGeom, d]

GEOSCentroid[GEOSGeometry[rawGeom_]] := Replace[GEOSGeometry[GL`GEOSCentroid[rawGeom]]["Geometry"], Point[c_] :> c]

GEOSHausdorffDistance[GEOSGeometry[rawGeom1_], GEOSGeometry[rawGeom2_]] := GL`GEOSHausdorffDistance[rawGeom1, rawGeom2]


GEOSDisjoint[GEOSGeometry[rawGeom1_], GEOSGeometry[rawGeom2_]] := GL`GEOSDisjoint[rawGeom1, rawGeom2]
GEOSDisjoint[GEOSPreparedGeometry[rawPrep_,_], GEOSGeometry[rawGeom_]] := GL`GEOSPreparedDisjoint[rawPrep, rawGeom]
GEOSDisjoint[GEOSGeometry[rawGeom_], GEOSPreparedGeometry[rawPrep_,_]] := GL`GEOSPreparedDisjoint[rawPrep, rawGeom]

GEOSCovers[GEOSGeometry[rawGeom1_], GEOSGeometry[rawGeom2_]] := GL`GEOSCovers[rawGeom1, rawGeom2]
GEOSCovers[GEOSPreparedGeometry[rawPrep_,_], GEOSGeometry[rawGeom_]] := GL`GEOSPreparedCovers[rawPrep, rawGeom]
GEOSCovers[GEOSGeometry[rawGeom_], GEOSPreparedGeometry[rawPrep_,_]] := GL`GEOSPreparedCovers[rawPrep, rawGeom]

GEOSOverlaps[GEOSGeometry[rawGeom1_], GEOSGeometry[rawGeom2_]] := GL`GEOSOverlaps[rawGeom1, rawGeom2]

GEOSContains[GEOSGeometry[rawGeom1_], GEOSGeometry[rawGeom2_]] := GL`GEOSContains[rawGeom1, rawGeom2]
GEOSContains[GEOSPreparedGeometry[rawPrep_,_], GEOSGeometry[rawGeom_]] := GL`GEOSPreparedContains[rawPrep, rawGeom]
GEOSContains[GEOSGeometry[rawGeom_], GEOSPreparedGeometry[rawPrep_,_]] := GL`GEOSPreparedContains[rawPrep, rawGeom]

GEOSTouches[GEOSGeometry[rawGeom1_], GEOSGeometry[rawGeom2_]] := GL`GEOSTouches[rawGeom1, rawGeom2]
GEOSTouches[GEOSPreparedGeometry[rawPrep_,_], GEOSGeometry[rawGeom_]] := GL`GEOSPreparedTouches[rawPrep, rawGeom]
GEOSTouches[GEOSGeometry[rawGeom_], GEOSPreparedGeometry[rawPrep_,_]] := GL`GEOSPreparedTouches[rawPrep, rawGeom]

GEOSIntersects[GEOSGeometry[rawGeom1_], GEOSGeometry[rawGeom2_]] := GL`GEOSIntersects[rawGeom1, rawGeom2]
GEOSIntersects[GEOSPreparedGeometry[rawPrep_,_], GEOSGeometry[rawGeom_]] := GL`GEOSPreparedIntersects[rawPrep, rawGeom]
GEOSIntersects[GEOSGeometry[rawGeom_], GEOSPreparedGeometry[rawPrep_,_]] := GL`GEOSPreparedIntersects[rawPrep, rawGeom]

GEOSWithin[GEOSGeometry[rawGeom1_], GEOSGeometry[rawGeom2_]] := GL`GEOSWithin[rawGeom1, rawGeom2]

GEOSEquals[GEOSGeometry[rawGeom1_], GEOSGeometry[rawGeom2_]] := GL`GEOSEquals[rawGeom1, rawGeom2]


GEOSConvexHull[GEOSGeometry[rawGeom_]] := GEOSGeometry[GL`GEOSConvexHull[rawGeom]]


Options[GEOSDelaunayMesh] = {
	"OnlyEdges" -> False,
	Tolerance -> 0
};
GEOSDelaunayMesh[GEOSGeometry[rawGeom_], opts:OptionsPattern[]] :=
	GEOSGeometry@GL`GEOSDelaunayTriangulation[
		rawGeom,
		OptionValue[Tolerance],
		OptionValue["OnlyEdges"]
	]


Options[GEOSVoronoiMesh] = {
	"OnlyEdges" -> False,
	Tolerance -> 0
};

GEOSVoronoiMesh[GEOSGeometry[rawGeom_], GEOSGeometry[rawEnv_], opts:OptionsPattern[]] :=
	GEOSGeometry@GL`GEOSVoronoiMesh[
		rawGeom,
		rawEnv,
		OptionValue[Tolerance],
		OptionValue["OnlyEdges"]
	]

GEOSVoronoiMesh[GEOSGeometry[rawGeom_], Automatic, opts:OptionsPattern[]] :=
	GEOSGeometry@GL`GEOSVoronoiMeshAutomaticEnvelope[
		rawGeom,
		OptionValue[Tolerance],
		OptionValue["OnlyEdges"]
	]

GEOSVoronoiMesh[geom_GEOSGeometry, opts:OptionsPattern[]] := GEOSVoronoiMesh[geom, Automatic, {opts}]


GEOSUnion[GEOSGeometry[rawGeom1_], GEOSGeometry[rawGeom2_]] := GEOSGeometry[GL`GEOSUnion[rawGeom1, rawGeom2]]
GEOSUnion[GEOSGeometry[rawGeom_]] := GEOSGeometry[GL`GEOSUnaryUnion[rawGeom]]
GEOSUnion[geoms:{___GEOSGeometry}] := GEOSGeometry[GL`GEOSUnaryUnion[GL`GEOSMerge[geosGeometryListRaw[geoms]]]]

GEOSIntersection[GEOSGeometry[rawGeom1_], GEOSGeometry[rawGeom2_]] := GEOSGeometry[GL`GEOSIntersection[rawGeom1, rawGeom2]]

GEOSDifference[GEOSGeometry[rawGeom1_], GEOSGeometry[rawGeom2_]] := GEOSGeometry[GL`GEOSDifference[rawGeom1, rawGeom2]]

GEOSSymmetricDifference[GEOSGeometry[rawGeom1_], GEOSGeometry[rawGeom2_]] := GEOSGeometry[GL`GEOSSymmetricDifference[rawGeom1, rawGeom2]]


GEOSMerge[geoms:{___GEOSGeometry}] := GEOSGeometry[GL`GEOSMerge[geosGeometryListRaw[geoms]]]


GEOSBoundary[GEOSGeometry[rawGeom_]] := GEOSGeometry[GL`GEOSBoundary[rawGeom]]

Options[GEOSBuffer] = {
	"Segments" -> 5
};
GEOSBuffer[GEOSGeometry[rawGeom_], rad_?NumberQ, opts:OptionsPattern[]] := GEOSGeometry[GL`GEOSBuffer[rawGeom, rad, OptionValue["Segments"]]]


End[];
EndPackage[];
