
import ProofWidgets.Component.RefreshComponent
import ProofWidgets.Component.OfRpcMethod
import ProofWidgets.Component.Panel.SelectionPanel
import ProofWidgets.Component.VerificationResults
import ProofWidgets.Component.HtmlDisplay

section
open Lean.Widget ProofWidgets RefreshComponent Jsx Lean Server


def exampleResults : Json := json% {"vcs":
 [{"timing":
   {"totalTime": 23,
    "successfulDischargerTime": 23,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 23,
      "status": "proven",
      "result": {"time": 23, "status": "proven", "data": null},
      "name": "initializer_doesNotThrow_0",
      "id": 0}]},
   "status": "proven",
   "name": "initializer_doesNotThrow",
   "metadata": {"style": "wp", "property": "doesNotThrow", "kind": "primary", "action": "initializer"},
   "isDormant": false,
   "id": 0,
   "alternativeFor": null},
  {"timing":
   {"totalTime": 313,
    "successfulDischargerTime": 313,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 313,
      "status": "proven",
      "result": {"time": 313, "status": "proven", "data": {"unsatCores": [[]], "kind": "unsat"}},
      "name": "initializer_single_leader_0",
      "id": 0}]},
   "status": "proven",
   "name": "initializer_single_leader",
   "metadata": {"style": "wp", "property": "single_leader", "kind": "primary", "action": "initializer"},
   "isDormant": false,
   "id": 1,
   "alternativeFor": null},
  {"timing":
   {"totalTime": null,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers":
    [{"time": null, "status": "notStarted", "result": null, "name": "initializer_single_leader_tr_0", "id": 0}]},
   "status": null,
   "name": "initializer_single_leader_tr",
   "metadata": {"style": "tr", "property": "single_leader", "kind": "alternative", "action": "initializer"},
   "isDormant": true,
   "id": 2,
   "alternativeFor": 1},
  {"timing":
   {"totalTime": 78,
    "successfulDischargerTime": 78,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 78,
      "status": "proven",
      "result": {"time": 78, "status": "proven", "data": null},
      "name": "initializer_inv_2_0",
      "id": 0}]},
   "status": "proven",
   "name": "initializer_inv_2",
   "metadata": {"style": "wp", "property": "inv_2", "kind": "primary", "action": "initializer"},
   "isDormant": false,
   "id": 3,
   "alternativeFor": null},
  {"timing":
   {"totalTime": null,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers": [{"time": null, "status": "notStarted", "result": null, "name": "initializer_inv_2_tr_0", "id": 0}]},
   "status": null,
   "name": "initializer_inv_2_tr",
   "metadata": {"style": "tr", "property": "inv_2", "kind": "alternative", "action": "initializer"},
   "isDormant": true,
   "id": 4,
   "alternativeFor": 3},
  {"timing":
   {"totalTime": 315,
    "successfulDischargerTime": 315,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 315,
      "status": "proven",
      "result": {"time": 315, "status": "proven", "data": {"unsatCores": [[]], "kind": "unsat"}},
      "name": "send_doesNotThrow_0",
      "id": 0}]},
   "status": "proven",
   "name": "send_doesNotThrow",
   "metadata": {"style": "wp", "property": "doesNotThrow", "kind": "primary", "action": "send"},
   "isDormant": false,
   "id": 5,
   "alternativeFor": null},
  {"timing":
   {"totalTime": 354,
    "successfulDischargerTime": 354,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 354,
      "status": "proven",
      "result":
      {"time": 354, "status": "proven", "data": {"unsatCores": [["_uniq.100272", "_uniq.100398"]], "kind": "unsat"}},
      "name": "send_single_leader_0",
      "id": 0}]},
   "status": "proven",
   "name": "send_single_leader",
   "metadata": {"style": "wp", "property": "single_leader", "kind": "primary", "action": "send"},
   "isDormant": false,
   "id": 6,
   "alternativeFor": null},
  {"timing":
   {"totalTime": null,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers":
    [{"time": null, "status": "notStarted", "result": null, "name": "send_single_leader_tr_0", "id": 0}]},
   "status": null,
   "name": "send_single_leader_tr",
   "metadata": {"style": "tr", "property": "single_leader", "kind": "alternative", "action": "send"},
   "isDormant": true,
   "id": 7,
   "alternativeFor": 6},
  {"timing":
   {"totalTime": 355,
    "successfulDischargerTime": 355,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 355,
      "status": "proven",
      "result":
      {"time": 355,
       "status": "proven",
       "data": {"unsatCores": [["_uniq.101001", "_uniq.101125", "_uniq.101128"]], "kind": "unsat"}},
      "name": "send_inv_2_0",
      "id": 0}]},
   "status": "proven",
   "name": "send_inv_2",
   "metadata": {"style": "wp", "property": "inv_2", "kind": "primary", "action": "send"},
   "isDormant": false,
   "id": 8,
   "alternativeFor": null},
  {"timing":
   {"totalTime": null,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers": [{"time": null, "status": "notStarted", "result": null, "name": "send_inv_2_tr_0", "id": 0}]},
   "status": null,
   "name": "send_inv_2_tr",
   "metadata": {"style": "tr", "property": "inv_2", "kind": "alternative", "action": "send"},
   "isDormant": true,
   "id": 9,
   "alternativeFor": 8},
  {"timing":
   {"totalTime": 343,
    "successfulDischargerTime": 343,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 343,
      "status": "proven",
      "result": {"time": 343, "status": "proven", "data": {"unsatCores": [[]], "kind": "unsat"}},
      "name": "recv_doesNotThrow_0",
      "id": 0}]},
   "status": "proven",
   "name": "recv_doesNotThrow",
   "metadata": {"style": "wp", "property": "doesNotThrow", "kind": "primary", "action": "recv"},
   "isDormant": false,
   "id": 10,
   "alternativeFor": null},
  {"timing":
   {"totalTime": 364,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers":
    [{"time": 364,
      "status": "disproven",
      "result":
      {"time": 364,
       "status": "disproven",
       "data":
       {"kind": "sat",
        "counterexamples":
        [{"structuredJson":
          {"theory": {"xxx": false, "meganode": []},
           "preState": {"pending": [[0, 0]], "leader": [1]},
           "postState": null,
           "label": {"recv": {"sender": 0, "next": 1, "n": 0}},
           "instantiation": {"node": "Fin 2"},
           "extraVals": {"tot.le": [[0, 0], [1, 0], [1, 1]], "btwn.btw": [], "N": 0, "M": 1},
           "extraSorts": {}},
          "raw": {"values": 9, "sorts": 1},
          "html": "<p>Counter-example HTML</p>",
          "extrasHtml": "<p>Extras HTML</p>"}]}},
      "name": "recv_single_leader_0",
      "id": 0}]},
   "status": "disproven",
   "name": "recv_single_leader",
   "metadata": {"style": "wp", "property": "single_leader", "kind": "primary", "action": "recv"},
   "isDormant": false,
   "id": 11,
   "alternativeFor": null},
  {"timing":
   {"totalTime": 404,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers":
    [{"time": 404,
      "status": "disproven",
      "result":
      {"time": 404,
       "status": "disproven",
       "data":
       {"kind": "sat",
        "counterexamples":
        [{"structuredJson":
          {"theory": {"xxx": false, "meganode": []},
           "preState": {"pending": [[0, 1], [1, 0]], "leader": [1]},
           "postState": {"pending": [[0, 1]], "leader": [0, 1]},
           "label": {"recv": {"sender": 1, "next": 1, "n": 0}},
           "instantiation": {"node": "Fin 2"},
           "extraVals": {"tot.le": [[0, 0], [1, 0], [1, 1]], "btwn.btw": [], "N": 0, "M": 1},
           "extraSorts": {}},
          "raw": {"values": 11, "sorts": 1},
          "html": "<p>Counter-example HTML</p>",
          "extrasHtml": "<p>Extras HTML</p>"}]}},
      "name": "recv_single_leader_tr_0",
      "id": 0}]},
   "status": "disproven",
   "name": "recv_single_leader_tr",
   "metadata": {"style": "tr", "property": "single_leader", "kind": "alternative", "action": "recv"},
   "isDormant": false,
   "id": 12,
   "alternativeFor": 11},
  {"timing":
   {"totalTime": 350,
    "successfulDischargerTime": 350,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 350,
      "status": "proven",
      "result": {"time": 350, "status": "proven", "data": {"unsatCores": [["_uniq.101145"]], "kind": "unsat"}},
      "name": "recv_inv_2_0",
      "id": 0}]},
   "status": "proven",
   "name": "recv_inv_2",
   "metadata": {"style": "wp", "property": "inv_2", "kind": "primary", "action": "recv"},
   "isDormant": false,
   "id": 13,
   "alternativeFor": null},
  {"timing":
   {"totalTime": null,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers": [{"time": null, "status": "notStarted", "result": null, "name": "recv_inv_2_tr_0", "id": 0}]},
   "status": null,
   "name": "recv_inv_2_tr",
   "metadata": {"style": "tr", "property": "inv_2", "kind": "alternative", "action": "recv"},
   "isDormant": true,
   "id": 14,
   "alternativeFor": 13}],
 "totalVCs": 15,
 "totalTime": 2899,
 "totalSolved": 8,
 "totalDischarged": 10}


instance : Lean.Server.RpcEncodable Unit where
  rpcEncode _ := pure .null
  rpcDecode _ := pure ()


partial def getVerificationResults : CoreM Html := do
    mkRefreshComponentM (.text "Loading...") randomResults
where
  randomiseResult (initial : Json) : CoreM (Option Json) := do
    let randInt ← IO.rand 0 100
    let randName := s!"haha_{randInt}"
    let str := initial.pretty.replace "doesNotThrow" randName
    match Json.parse str with
    | .ok json => return some json
    | .error _ => return none

  randomResults : CoreM (RefreshStep CoreM) := do
    IO.sleep 1000
    Core.checkSystem "getVerificationResults"
    let .some randomResult ← randomiseResult exampleResults | return .last <| .text "Error"
    let html := Html.ofComponent VerificationResultsViewer {results := randomResult} #[]
    return .cont html randomResults

#html getVerificationResults
