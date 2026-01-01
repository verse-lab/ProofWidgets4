
import ProofWidgets.Component.RefreshComponent
import ProofWidgets.Component.OfRpcMethod
import ProofWidgets.Component.Panel.SelectionPanel
import ProofWidgets.Component.VerificationResults
import ProofWidgets.Component.HtmlDisplay

section
open Lean.Widget ProofWidgets RefreshComponent Jsx Lean Server


def exampleResults : Json := json% {"vcs":
 [{"timing":
   {"totalTime": 35,
    "successfulDischargerTime": 35,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 35,
      "status": "proven",
      "result": {"time": 35, "status": "proven", "data": null},
      "name": "initializer_doesNotThrow_0",
      "id": 0}]},
   "status": "proven",
   "name": "initializer_doesNotThrow",
   "metadata":
   {"type": "induction",
    "data": {"style": "wp", "property": "doesNotThrow", "kind": "primary", "action": "initializer"}},
   "isDormant": false,
   "id": 0,
   "alternativeFor": null},
  {"timing":
   {"totalTime": 314,
    "successfulDischargerTime": 314,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 314,
      "status": "proven",
      "result": {"time": 314, "status": "proven", "data": {"unsatCores": [[]], "kind": "unsat"}},
      "name": "initializer_single_leader_0",
      "id": 0}]},
   "status": "proven",
   "name": "initializer_single_leader",
   "metadata":
   {"type": "induction",
    "data": {"style": "wp", "property": "single_leader", "kind": "primary", "action": "initializer"}},
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
   "metadata":
   {"type": "induction",
    "data": {"style": "tr", "property": "single_leader", "kind": "alternative", "action": "initializer"}},
   "isDormant": true,
   "id": 2,
   "alternativeFor": 1},
  {"timing":
   {"totalTime": 356,
    "successfulDischargerTime": 356,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 356,
      "status": "proven",
      "result": {"time": 356, "status": "proven", "data": {"unsatCores": [["_uniq.122846"]], "kind": "unsat"}},
      "name": "initializer_inv_1_0",
      "id": 0}]},
   "status": "proven",
   "name": "initializer_inv_1",
   "metadata":
   {"type": "induction", "data": {"style": "wp", "property": "inv_1", "kind": "primary", "action": "initializer"}},
   "isDormant": false,
   "id": 3,
   "alternativeFor": null},
  {"timing":
   {"totalTime": null,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers": [{"time": null, "status": "notStarted", "result": null, "name": "initializer_inv_1_tr_0", "id": 0}]},
   "status": null,
   "name": "initializer_inv_1_tr",
   "metadata":
   {"type": "induction", "data": {"style": "tr", "property": "inv_1", "kind": "alternative", "action": "initializer"}},
   "isDormant": true,
   "id": 4,
   "alternativeFor": 3},
  {"timing":
   {"totalTime": 76,
    "successfulDischargerTime": 76,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 76,
      "status": "proven",
      "result": {"time": 76, "status": "proven", "data": null},
      "name": "initializer_inv_2_0",
      "id": 0}]},
   "status": "proven",
   "name": "initializer_inv_2",
   "metadata":
   {"type": "induction", "data": {"style": "wp", "property": "inv_2", "kind": "primary", "action": "initializer"}},
   "isDormant": false,
   "id": 5,
   "alternativeFor": null},
  {"timing":
   {"totalTime": null,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers": [{"time": null, "status": "notStarted", "result": null, "name": "initializer_inv_2_tr_0", "id": 0}]},
   "status": null,
   "name": "initializer_inv_2_tr",
   "metadata":
   {"type": "induction", "data": {"style": "tr", "property": "inv_2", "kind": "alternative", "action": "initializer"}},
   "isDormant": true,
   "id": 6,
   "alternativeFor": 5},
  {"timing":
   {"totalTime": 348,
    "successfulDischargerTime": 348,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 348,
      "status": "proven",
      "result": {"time": 348, "status": "proven", "data": {"unsatCores": [[]], "kind": "unsat"}},
      "name": "send_doesNotThrow_0",
      "id": 0}]},
   "status": "proven",
   "name": "send_doesNotThrow",
   "metadata":
   {"type": "induction", "data": {"style": "wp", "property": "doesNotThrow", "kind": "primary", "action": "send"}},
   "isDormant": false,
   "id": 7,
   "alternativeFor": null},
  {"timing":
   {"totalTime": 373,
    "successfulDischargerTime": 373,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 373,
      "status": "proven",
      "result":
      {"time": 373, "status": "proven", "data": {"unsatCores": [["_uniq.123367", "_uniq.123534"]], "kind": "unsat"}},
      "name": "send_single_leader_0",
      "id": 0}]},
   "status": "proven",
   "name": "send_single_leader",
   "metadata":
   {"type": "induction", "data": {"style": "wp", "property": "single_leader", "kind": "primary", "action": "send"}},
   "isDormant": false,
   "id": 8,
   "alternativeFor": null},
  {"timing":
   {"totalTime": null,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers":
    [{"time": null, "status": "notStarted", "result": null, "name": "send_single_leader_tr_0", "id": 0}]},
   "status": null,
   "name": "send_single_leader_tr",
   "metadata":
   {"type": "induction", "data": {"style": "tr", "property": "single_leader", "kind": "alternative", "action": "send"}},
   "isDormant": true,
   "id": 9,
   "alternativeFor": 8},
  {"timing":
   {"totalTime": 397,
    "successfulDischargerTime": 397,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 397,
      "status": "proven",
      "result":
      {"time": 397,
       "status": "proven",
       "data":
       {"unsatCores": [["_uniq.124102", "_uniq.124153", "_uniq.124259", "_uniq.124396", "_uniq.124400"]],
        "kind": "unsat"}},
      "name": "send_inv_1_0",
      "id": 0}]},
   "status": "proven",
   "name": "send_inv_1",
   "metadata": {"type": "induction", "data": {"style": "wp", "property": "inv_1", "kind": "primary", "action": "send"}},
   "isDormant": false,
   "id": 10,
   "alternativeFor": null},
  {"timing":
   {"totalTime": null,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers": [{"time": null, "status": "notStarted", "result": null, "name": "send_inv_1_tr_0", "id": 0}]},
   "status": null,
   "name": "send_inv_1_tr",
   "metadata":
   {"type": "induction", "data": {"style": "tr", "property": "inv_1", "kind": "alternative", "action": "send"}},
   "isDormant": true,
   "id": 11,
   "alternativeFor": 10},
  {"timing":
   {"totalTime": 397,
    "successfulDischargerTime": 397,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 397,
      "status": "proven",
      "result":
      {"time": 397,
       "status": "proven",
       "data": {"unsatCores": [["_uniq.124153", "_uniq.124288", "_uniq.124291"]], "kind": "unsat"}},
      "name": "send_inv_2_0",
      "id": 0}]},
   "status": "proven",
   "name": "send_inv_2",
   "metadata": {"type": "induction", "data": {"style": "wp", "property": "inv_2", "kind": "primary", "action": "send"}},
   "isDormant": false,
   "id": 12,
   "alternativeFor": null},
  {"timing":
   {"totalTime": null,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers": [{"time": null, "status": "notStarted", "result": null, "name": "send_inv_2_tr_0", "id": 0}]},
   "status": null,
   "name": "send_inv_2_tr",
   "metadata":
   {"type": "induction", "data": {"style": "tr", "property": "inv_2", "kind": "alternative", "action": "send"}},
   "isDormant": true,
   "id": 13,
   "alternativeFor": 12},
  {"timing":
   {"totalTime": 384,
    "successfulDischargerTime": 384,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 384,
      "status": "proven",
      "result": {"time": 384, "status": "proven", "data": {"unsatCores": [[]], "kind": "unsat"}},
      "name": "recv_doesNotThrow_0",
      "id": 0}]},
   "status": "proven",
   "name": "recv_doesNotThrow",
   "metadata":
   {"type": "induction", "data": {"style": "wp", "property": "doesNotThrow", "kind": "primary", "action": "recv"}},
   "isDormant": false,
   "id": 14,
   "alternativeFor": null},
  {"timing":
   {"totalTime": 365,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers":
    [{"time": 365,
      "status": "disproven",
      "result":
      {"time": 365,
       "status": "disproven",
       "data":
       {"kind": "sat",
        "counterexamples":
        [{"structuredJson":
          {"theory": {},
           "preState": {"pending": [[1, 1]], "leader": [0]},
           "postState": null,
           "label": {"recv": {"sender": 1, "next": 0, "n": 1}},
           "instantiation": {"node": "Fin 2"},
           "extraVals": {"tot.le": [[0, 0], [0, 1], [1, 1]], "btwn.btw": []},
           "extraSorts": {}},
          "raw": {"values": 7, "sorts": 1},
          "html": "<p>Counter-example HTML</p>"}]}},
      "name": "recv_single_leader_0",
      "id": 0}]},
   "status": "disproven",
   "name": "recv_single_leader",
   "metadata":
   {"type": "induction", "data": {"style": "wp", "property": "single_leader", "kind": "primary", "action": "recv"}},
   "isDormant": false,
   "id": 15,
   "alternativeFor": null},
  {"timing":
   {"totalTime": 423,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers":
    [{"time": 423,
      "status": "disproven",
      "result":
      {"time": 423,
       "status": "disproven",
       "data":
       {"kind": "sat",
        "counterexamples":
        [{"structuredJson":
          {"theory": {},
           "preState": {"pending": [[0, 1], [1, 1]], "leader": [0]},
           "postState": {"pending": [[0, 1]], "leader": [0, 1]},
           "label": {"recv": {"sender": 1, "next": 0, "n": 1}},
           "instantiation": {"node": "Fin 2"},
           "extraVals": {"tot.le": [[0, 0], [0, 1], [1, 1]], "btwn.btw": [], "N": 1, "M": 0},
           "extraSorts": {}},
          "raw": {"values": 11, "sorts": 1},
          "html": "<p>Counter-example HTML</p>"}]}},
      "name": "recv_single_leader_tr_0",
      "id": 0}]},
   "status": "disproven",
   "name": "recv_single_leader_tr",
   "metadata":
   {"type": "induction", "data": {"style": "tr", "property": "single_leader", "kind": "alternative", "action": "recv"}},
   "isDormant": false,
   "id": 16,
   "alternativeFor": 15},
  {"timing":
   {"totalTime": 419,
    "successfulDischargerTime": 419,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 419,
      "status": "proven",
      "result":
      {"time": 419,
       "status": "proven",
       "data":
       {"unsatCores":
        [["_uniq.126683", "_uniq.126684", "_uniq.126685", "_uniq.126811", "_uniq.126955", "_uniq.126956"]],
        "kind": "unsat"}},
      "name": "recv_inv_1_0",
      "id": 0}]},
   "status": "proven",
   "name": "recv_inv_1",
   "metadata": {"type": "induction", "data": {"style": "wp", "property": "inv_1", "kind": "primary", "action": "recv"}},
   "isDormant": false,
   "id": 17,
   "alternativeFor": null},
  {"timing":
   {"totalTime": null,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers": [{"time": null, "status": "notStarted", "result": null, "name": "recv_inv_1_tr_0", "id": 0}]},
   "status": null,
   "name": "recv_inv_1_tr",
   "metadata":
   {"type": "induction", "data": {"style": "tr", "property": "inv_1", "kind": "alternative", "action": "recv"}},
   "isDormant": true,
   "id": 18,
   "alternativeFor": 17},
  {"timing":
   {"totalTime": 261,
    "successfulDischargerTime": 261,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 261,
      "status": "proven",
      "result":
      {"time": 261,
       "status": "proven",
       "data":
       {"unsatCores":
        [["_uniq.126044", "_uniq.126102", "_uniq.126219", "_uniq.126220", "_uniq.126361", "_uniq.126362"]],
        "kind": "unsat"}},
      "name": "recv_inv_2_0",
      "id": 0}]},
   "status": "proven",
   "name": "recv_inv_2",
   "metadata": {"type": "induction", "data": {"style": "wp", "property": "inv_2", "kind": "primary", "action": "recv"}},
   "isDormant": false,
   "id": 19,
   "alternativeFor": null},
  {"timing":
   {"totalTime": null,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers": [{"time": null, "status": "notStarted", "result": null, "name": "recv_inv_2_tr_0", "id": 0}]},
   "status": null,
   "name": "recv_inv_2_tr",
   "metadata":
   {"type": "induction", "data": {"style": "tr", "property": "inv_2", "kind": "alternative", "action": "recv"}},
   "isDormant": true,
   "id": 20,
   "alternativeFor": 19},
  {"timing":
   {"totalTime": 720,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers":
    [{"time": 720,
      "status": "disproven",
      "result":
      {"time": 720,
       "status": "disproven",
       "data":
       {"kind": "sat",
        "counterexamples":
        [{"structuredJson":
          {"violation": {"violates": [], "kind": "safety_failure"},
           "trace":
           {"theory": {},
            "states":
            [{"transition": "after_init", "index": 0, "fields": {"pending": [], "leader": []}},
             {"transition": {"send": {"next": 0, "n": 0}}, "index": 1, "fields": {"pending": [[0, 1]], "leader": []}},
             {"transition": {"send": {"next": 0, "n": 0}}, "index": 2, "fields": {"pending": [[0, 0]], "leader": []}},
             {"transition": {"send": {"next": 0, "n": 0}}, "index": 3, "fields": {"pending": [], "leader": [0]}}]},
           "state_fingerprint": 0,
           "result": "found_violation"},
          "raw": {"values": 25, "sorts": 2},
          "html": "<p>Counter-example HTML</p>"}]}},
      "name": "can_elect_leader_explicit_0",
      "id": 0}]},
   "status": "disproven",
   "name": "can_elect_leader_explicit",
   "metadata":
   {"type": "trace", "data": {"traceName": "can_elect_leader_explicit", "numTransitions": 3, "isExpectedSat": false}},
   "isDormant": false,
   "id": 21,
   "alternativeFor": null}],
 "totalVCs": 22,
 "totalTime": 4868,
 "totalSolved": 11,
 "totalDischarged": 14}


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
