TestCreate[
  Needs["ChristopherWolfram`GEOSGeometry`"],
  Null
]

Needs["ChristopherWolfram`GEOSGeometry`"]

(* Centered at origin *)
poly1 = Uncompress["1:eJxTTMoPSmNiYGAoZgcSAfk5len5eakgAT4gBtEdfWdOfXS6ac9TMln0188r9lkZPRo\
tH57bM22dozz9ymP7WVZOUy6feWyvctAmoTnxtv2MNZ/f3RV+aq/Rs29+ne4te7EnEja3S\
x7bPzh9ee2rFZft1xx9acjo9tTe43pGOf/bQ/ZbOD5oOOu/tU8p6w0t2P7CPubFYuWO/2/t\
12S8WL7Y7I29RFfcqSqj9/Zyp5dt6vvxzr7s5tr6RVLP7fOmiNooHHxlv+aNHFd8/GX7nO\
mOJ5mY3tjrLf+0+cndx/Z6aZclt914bH/kZXtyhtJl+wcM7pcmWN6yjyg6cc9oy3H7Dd8X\
J0w+cdI+DeTRYhYg4ZNZXOLJCGQYgkkjMGkMJk3ApCmYNAOT5mDSAkxaeoICytAAQhlCKC\
MIZQyhTADqoYar"];

poly2 = Uncompress["1:eJxTTMoPSmNiYGAoZgcSAfk5len5eakgAT4gBtEM+3tKJ/TNsK+IE7m6dftVe4Y1GW8\
j8oLtI37eD86VumhfsMP1TLLTBXuFP6csJd+dsj8wsfBnf84N+wMpcU/kph6252hnvWDM+t\
T+wY/M3u7FG+2XvY6+Vnf3qf0OzvSA7EU37BOMF/f62r6xfyBsvsIs975918ynpf15j+wf\
bKz8JXb1hv2TODNvP77b9h6zD6y0iLtl/+Ek6645xnfszbqcvvateGRftorPLXviY/tnHB\
qdjWwv7LOa0noTEp7Zx/m7Cpy/+co+ZZWFQeqju/Z6/nG8uo0v7Fnmvlta6nbJPiH29quN\
Px7Yp4E8WswCJHwyi0s8GYEMQzBpBCaNwaQJmDQFk2Zg0hxMWoBJS09QQBkaQChDCGUEoY\
whlAkAMWZ/xA=="];

poly3 = Uncompress["1:eJxTTMoPSmNiYGAoZgcSAfk5len5eakgAX4gBtFvJuwz/8D12D4gl7uLce15+zcX4+R\
eCb6ylzjy+T7T+kP251hnPRC2fGs/5+W5vlfe1+w3xMY91xF5Y/+uqENKUu6VvYJq7tcMx\
9f2JfptDFm9r+wLBJ07AlYdt1+zOWSpS8FbexHRt00zdR/Z7/gT+NDN5479gSWCKx7PW29\
fdfbS8ee33tgrTI/IDHVcar/Kqqz2SuFLe4Ufmz4KTFtu33RYKqyo9bG9g9XchH9/Z9gzG\
FxZvj9mt73CRRcPF4Z19g4fslf/UNtlX/A1ruBO8G77B1rnrpe/2W7/pPTOP501V+03aG3\
4Ib9jo/0bjUfS0jU37Bv0srYE2N+zTwN5vJgFSPhkFpd4MgIZhmDSCEwag0kTMGkKJs3Ap\
DmYtACTlp6ggDM0gFCGEMoIQhlDKBMIZQoAgOqKFw=="];

(* Translated to {3,3} *)
polyMoved = Uncompress["1:eJxTTMoPSmNiYGAoZgcSAfk5len5eakgAW4gBtFGn57l21/idNjnURTw7jG/w+XyRPb\
3TzgdvjA+Oyq+md/h00+v69Z3uRx2zj+695YVr4NDS9L0R1zcDm2GTyTmpHI5dPAL617k4\
XZ4/nQi0+or/A5dziY/4idyO8yoz7n2SpHP4e23UmXW2bwOMTOt5pe08jk8POr59MFOXoc\
N09XvrfjA6fCQ69+25cl8DkmP5jSt0uVy+F42rXSlEr/DnF8zvyxu53eYsuDtAu1WfoeaA\
7v2RLzndkgDObyYBUj4ZBaXeDICGYZg0gRMGoNJIzBpASYtPUHeNIQoMgOT5hAhAzDHFAD\
qHV/W"];

points = Uncompress["1:eJwBoQFe/iFib1JlAgAAABkAAAACAAAAUMTnuJCB1L9gvEtLeAbDP1gKAJ7X7+Q/0P3\
9nPD44b9w+iHc5nzTP4w6LLZ12+m/NCKNslxm6z/4hiVmAjfZP9DSDezTy8W/YA9DnATM2\
j9gs/r7JZ3OvzjEWPKO0NY/oCrQy+Wc0z9IKdvwPdXRv4CnJjneiLc/QOedCpaDvT8w88K\
yhRjAP5yxzbZJg+0/oMCgUuOQwD/gUzlDj0ffP9BQSMn3jMS/YKqTrdFU0D+IdUJpLu7VP\
8TSw5g4weA/xMAX8lOU478QMRNJnK7cP8xFh7RjoOO/qNNCiw5V5D9Q+dMnInbJvwAad7d\
b1sg/ONnKZDym7j8A0wHr1XS2v4jEZqZkHua/0EXKnTQwzD8k/4/pXyHlPxBQA/qXvMu/B\
D+Zlloz6L8gIh/3AcDWv5yub4/S7uy/oI+03X1Z0D9Yox4cdjTfv9DGmUqXdcs/UKFnCan\
67T+ApvBRdIiYv7Rg+DgM1OM/zBYy7scJ6D/QFqoVvNvIvyivYi4MPOk/COpME9JC2T9oS\
SWhNMLSP5Rx2fI="];


regionGEOSSameQ[geos_, reg_, epsilon_:0.0001] :=
  Area[RegionSymmetricDifference[reg, geos["Geometry"]]] < epsilon

TestCreate[
  geom1 = GEOSGeometry[poly1];
  MatchQ[geom1, _GEOSGeometry]
]

TestCreate[
  geom2 = GEOSGeometry[poly2];
  MatchQ[geom2, _GEOSGeometry]
]

TestCreate[
  geom3 = GEOSGeometry[poly3];
  MatchQ[geom3, _GEOSGeometry]
]

TestCreate[
  geomMoved = GEOSGeometry[polyMoved];
  MatchQ[geomMoved, _GEOSGeometry]
]

TestCreate[
  pointGeom1 = GEOSGeometry[Point[points]];
  MatchQ[pointGeom1, _GEOSGeometry]
]

TestCreate[
  GEOSArea[geom1] == Area[poly1]
]

TestCreate[
  GEOSLength[GEOSBoundary[geom1]] == RegionMeasure[RegionBoundary[poly1], 1]
]

TestCreate[
  GEOSDistance[geom1, geomMoved] == RegionDistance[poly1, polyMoved]
]

TestCreate[
  GEOSDistance[geom1, geom1] == 0
]

TestCreate[
  GEOSDistanceWithin[geom1, geomMoved, 10] === True
]

TestCreate[
  GEOSDistanceWithin[geom1, geomMoved, 1] === False
]

TestCreate[
  0 < GEOSHausdorffDistance[geom1, geomMoved] < 10
]

TestCreate[
  GEOSHausdorffDistance[geom1, geom1] == 0
]
Function[f,{
  TestCreate[!f[geom1, geomMoved]],
  TestCreate[f[geom1, geom1]]
}]/@{
	GEOSCovers,
	GEOSContains,
	GEOSIntersects,
	GEOSWithin,
	GEOSEquals
};

TestCreate[!GEOSDisjoint[geom1, geom1]]
TestCreate[GEOSDisjoint[geom1, geomMoved]]

TestCreate[!GEOSOverlaps[geom1, geomMoved]]
TestCreate[!GEOSTouches[geom1, geomMoved]]

TestCreate[
  regionGEOSSameQ[GEOSConvexHull[geom1], ConvexHullMesh[poly1]]
]

TestCreate[
  MatchQ[GEOSDelaunayTriangulation[geom1], _GEOSGeometry]
]

TestCreate[
  MatchQ[GEOSDelaunayTriangulation[geom1, "OnlyEdges"->False], _GEOSGeometry]
]

TestCreate[
  MatchQ[GEOSDelaunayTriangulation[geom1, "OnlyEdges"->True], _GEOSGeometry]
]

TestCreate[
  MatchQ[GEOSDelaunayTriangulation[geom1, "OnlyEdges"->False, Tolerance->0.0001], _GEOSGeometry]
]

TestCreate[
  MatchQ[GEOSDelaunayTriangulation[geom1, "OnlyEdges"->True, Tolerance->0.0001], _GEOSGeometry]
]

TestCreate[
  MatchQ[GEOSVoronoiMesh[pointGeom1], _GEOSGeometry]
]

TestCreate[
  MatchQ[GEOSVoronoiMesh[pointGeom1, geom1], _GEOSGeometry]
]

TestCreate[
  MatchQ[GEOSVoronoiMesh[pointGeom1, geom1, "OnlyEdges"->True], _GEOSGeometry]
]

TestCreate[
  MatchQ[GEOSVoronoiMesh[pointGeom1, geom1, "OnlyEdges"->False], _GEOSGeometry]
]

TestCreate[
  MatchQ[GEOSVoronoiMesh[pointGeom1, geom1, "OnlyEdges"->True, Tolerance->0.0001], _GEOSGeometry]
]

TestCreate[
  MatchQ[GEOSVoronoiMesh[pointGeom1, geom1, "OnlyEdges"->False, Tolerance->0.0001], _GEOSGeometry]
]

TestCreate[
  MatchQ[GEOSVoronoiMesh[pointGeom1, Automatic], _GEOSGeometry]
]

TestCreate[
  MatchQ[GEOSVoronoiMesh[pointGeom1, Automatic, "OnlyEdges"->True], _GEOSGeometry]
]

TestCreate[
  MatchQ[GEOSVoronoiMesh[pointGeom1, Automatic, "OnlyEdges"->False], _GEOSGeometry]
]

TestCreate[
  MatchQ[GEOSVoronoiMesh[pointGeom1, Automatic, "OnlyEdges"->True, Tolerance->0.0001], _GEOSGeometry]
]

TestCreate[
  MatchQ[GEOSVoronoiMesh[pointGeom1, Automatic, "OnlyEdges"->False, Tolerance->0.0001], _GEOSGeometry]
]

TestCreate[
  regionGEOSSameQ[GEOSUnion[geom1, geom2], RegionUnion[poly1, poly2]]
]

TestCreate[
  regionGEOSSameQ[GEOSUnion[{geom1, geom2, geom3}], RegionUnion[poly1, poly2, poly3]]
]

TestCreate[
  regionGEOSSameQ[GEOSIntersection[geom1, geom2], RegionIntersection[poly1, poly2]]
]

TestCreate[
  regionGEOSSameQ[GEOSDifference[geom1, geom2], RegionDifference[poly1, poly2]]
]

TestCreate[
  regionGEOSSameQ[GEOSSymmetricDifference[geom1, geom2], RegionSymmetricDifference[poly1, poly2]]
]

TestCreate[
  regionGEOSSameQ[GEOSBoundary[geom1], RegionBoundary[poly1]]
]

TestCreate[
  MatchQ[GEOSBuffer[geom1, 1], _GEOSGeometry]
]

TestCreate[
  MatchQ[GEOSBuffer[geom1, 1.5], _GEOSGeometry]
]

TestCreate[
  MatchQ[GEOSBuffer[geom1, 1, 3], _GEOSGeometry]
]

TestCreate[
  GEOSCentroid[geom1] == RegionCentroid[poly1]
]