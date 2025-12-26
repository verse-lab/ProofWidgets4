
import ProofWidgets.Component.RefreshComponent
import ProofWidgets.Component.OfRpcMethod
import ProofWidgets.Component.Panel.SelectionPanel
import ProofWidgets.Component.VerificationResults
import ProofWidgets.Component.HtmlDisplay

section
open Lean.Widget ProofWidgets RefreshComponent Jsx Lean Server


def exampleResults : Json := json% {"vcs":
 [{"timing":
   {"totalTime": 26,
    "successfulDischargerTime": 26,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 26,
      "status": "proven",
      "result": {"time": 26, "status": "proven", "data": null},
      "name": "initializer_doesNotThrow_0",
      "id": 0}]},
   "status": "proven",
   "name": "initializer_doesNotThrow",
   "metadata": {"style": "wp", "property": "doesNotThrow", "kind": "primary", "action": "initializer"},
   "isDormant": false,
   "id": 0,
   "alternativeFor": null},
  {"timing":
   {"totalTime": 425,
    "successfulDischargerTime": 425,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 425,
      "status": "proven",
      "result": {"time": 425, "status": "proven", "data": {"unsatCores": [[]], "kind": "unsat"}},
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
   {"totalTime": 97,
    "successfulDischargerTime": 97,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 97,
      "status": "proven",
      "result": {"time": 97, "status": "proven", "data": null},
      "name": "initializer_leader_greatest_0",
      "id": 0}]},
   "status": "proven",
   "name": "initializer_leader_greatest",
   "metadata": {"style": "wp", "property": "leader_greatest", "kind": "primary", "action": "initializer"},
   "isDormant": false,
   "id": 3,
   "alternativeFor": null},
  {"timing":
   {"totalTime": null,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers":
    [{"time": null, "status": "notStarted", "result": null, "name": "initializer_leader_greatest_tr_0", "id": 0}]},
   "status": null,
   "name": "initializer_leader_greatest_tr",
   "metadata": {"style": "tr", "property": "leader_greatest", "kind": "alternative", "action": "initializer"},
   "isDormant": true,
   "id": 4,
   "alternativeFor": 3},
  {"timing":
   {"totalTime": 94,
    "successfulDischargerTime": 94,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 94,
      "status": "proven",
      "result": {"time": 94, "status": "proven", "data": null},
      "name": "initializer_inv_2_0",
      "id": 0}]},
   "status": "proven",
   "name": "initializer_inv_2",
   "metadata": {"style": "wp", "property": "inv_2", "kind": "primary", "action": "initializer"},
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
   "metadata": {"style": "tr", "property": "inv_2", "kind": "alternative", "action": "initializer"},
   "isDormant": true,
   "id": 6,
   "alternativeFor": 5},
  {"timing":
   {"totalTime": 437,
    "successfulDischargerTime": 437,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 437,
      "status": "proven",
      "result": {"time": 437, "status": "proven", "data": {"unsatCores": [[]], "kind": "unsat"}},
      "name": "send_doesNotThrow_0",
      "id": 0}]},
   "status": "proven",
   "name": "send_doesNotThrow",
   "metadata": {"style": "wp", "property": "doesNotThrow", "kind": "primary", "action": "send"},
   "isDormant": false,
   "id": 7,
   "alternativeFor": null},
  {"timing":
   {"totalTime": 500,
    "successfulDischargerTime": 500,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 500,
      "status": "proven",
      "result":
      {"time": 500, "status": "proven", "data": {"unsatCores": [["_uniq.104268", "_uniq.104429"]], "kind": "unsat"}},
      "name": "send_single_leader_0",
      "id": 0}]},
   "status": "proven",
   "name": "send_single_leader",
   "metadata": {"style": "wp", "property": "single_leader", "kind": "primary", "action": "send"},
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
   "metadata": {"style": "tr", "property": "single_leader", "kind": "alternative", "action": "send"},
   "isDormant": true,
   "id": 9,
   "alternativeFor": 8},
  {"timing":
   {"totalTime": 497,
    "successfulDischargerTime": 497,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 497,
      "status": "proven",
      "result":
      {"time": 497, "status": "proven", "data": {"unsatCores": [["_uniq.104209", "_uniq.104342"]], "kind": "unsat"}},
      "name": "send_leader_greatest_0",
      "id": 0}]},
   "status": "proven",
   "name": "send_leader_greatest",
   "metadata": {"style": "wp", "property": "leader_greatest", "kind": "primary", "action": "send"},
   "isDormant": false,
   "id": 10,
   "alternativeFor": null},
  {"timing":
   {"totalTime": null,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers":
    [{"time": null, "status": "notStarted", "result": null, "name": "send_leader_greatest_tr_0", "id": 0}]},
   "status": null,
   "name": "send_leader_greatest_tr",
   "metadata": {"style": "tr", "property": "leader_greatest", "kind": "alternative", "action": "send"},
   "isDormant": true,
   "id": 11,
   "alternativeFor": 10},
  {"timing":
   {"totalTime": 488,
    "successfulDischargerTime": 488,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 488,
      "status": "proven",
      "result":
      {"time": 488,
       "status": "proven",
       "data": {"unsatCores": [["_uniq.105007", "_uniq.105138", "_uniq.105141"]], "kind": "unsat"}},
      "name": "send_inv_2_0",
      "id": 0}]},
   "status": "proven",
   "name": "send_inv_2",
   "metadata": {"style": "wp", "property": "inv_2", "kind": "primary", "action": "send"},
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
   "metadata": {"style": "tr", "property": "inv_2", "kind": "alternative", "action": "send"},
   "isDormant": true,
   "id": 13,
   "alternativeFor": 12},
  {"timing":
   {"totalTime": 470,
    "successfulDischargerTime": 470,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 470,
      "status": "proven",
      "result": {"time": 470, "status": "proven", "data": {"unsatCores": [[]], "kind": "unsat"}},
      "name": "recv_doesNotThrow_0",
      "id": 0}]},
   "status": "proven",
   "name": "recv_doesNotThrow",
   "metadata": {"style": "wp", "property": "doesNotThrow", "kind": "primary", "action": "recv"},
   "isDormant": false,
   "id": 14,
   "alternativeFor": null},
  {"timing":
   {"totalTime": 471,
    "successfulDischargerTime": 471,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 471,
      "status": "proven",
      "result":
      {"time": 471,
       "status": "proven",
       "data":
       {"unsatCores": [["_uniq.106085", "_uniq.106209", "_uniq.106245", "_uniq.106246", "_uniq.106385"]],
        "kind": "unsat"}},
      "name": "recv_single_leader_0",
      "id": 0}]},
   "status": "proven",
   "name": "recv_single_leader",
   "metadata": {"style": "wp", "property": "single_leader", "kind": "primary", "action": "recv"},
   "isDormant": false,
   "id": 15,
   "alternativeFor": null},
  {"timing":
   {"totalTime": null,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers":
    [{"time": null, "status": "notStarted", "result": null, "name": "recv_single_leader_tr_0", "id": 0}]},
   "status": null,
   "name": "recv_single_leader_tr",
   "metadata": {"style": "tr", "property": "single_leader", "kind": "alternative", "action": "recv"},
   "isDormant": true,
   "id": 16,
   "alternativeFor": 15},
  {"timing":
   {"totalTime": 455,
    "successfulDischargerTime": 455,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 455,
      "status": "proven",
      "result":
      {"time": 455,
       "status": "proven",
       "data": {"unsatCores": [["_uniq.105775", "_uniq.105776", "_uniq.105914"]], "kind": "unsat"}},
      "name": "recv_leader_greatest_0",
      "id": 0}]},
   "status": "proven",
   "name": "recv_leader_greatest",
   "metadata": {"style": "wp", "property": "leader_greatest", "kind": "primary", "action": "recv"},
   "isDormant": false,
   "id": 17,
   "alternativeFor": null},
  {"timing":
   {"totalTime": null,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers":
    [{"time": null, "status": "notStarted", "result": null, "name": "recv_leader_greatest_tr_0", "id": 0}]},
   "status": null,
   "name": "recv_leader_greatest_tr",
   "metadata": {"style": "tr", "property": "leader_greatest", "kind": "alternative", "action": "recv"},
   "isDormant": true,
   "id": 18,
   "alternativeFor": 17},
  {"timing":
   {"totalTime": 287,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers":
    [{"time": 287,
      "status": "disproven",
      "result":
      {"time": 287,
       "status": "disproven",
       "data":
       {"kind": "sat",
        "counterexamples":
        [{"structuredJson":
          {"theory": {},
           "preState": {"pending": [[0, 2]], "leader": []},
           "postState": null,
           "label": {"recv": {"sender": 0, "next": 0, "n": 2}},
           "instantiation": {"node": "Fin 3"}},
          "raw": {"values": 8, "sorts": 1},
          "html": "<p>Counter-example HTML</p>"}]}},
      "name": "recv_inv_2_0",
      "id": 0}]},
   "status": "disproven",
   "name": "recv_inv_2",
   "metadata": {"style": "wp", "property": "inv_2", "kind": "primary", "action": "recv"},
   "isDormant": false,
   "id": 19,
   "alternativeFor": null},
  {"timing":
   {"totalTime": 802,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers":
    [{"time": 802,
      "status": "disproven",
      "result":
      {"time": 802,
       "status": "disproven",
       "data":
       {"kind": "sat",
        "counterexamples":
        [{"structuredJson":
          {"theory": {},
           "preState": {"pending": [[0, 0], [0, 1], [0, 2], [1, 0], [1, 2], [2, 0], [2, 1]], "leader": [0]},
           "postState": {"pending": [[0, 0], [0, 1], [0, 2], [1, 0], [1, 2], [2, 1], [2, 2]], "leader": [0]},
           "label": {"recv": {"sender": 2, "next": 2, "n": 1}},
           "instantiation": {"node": "Fin 3"}},
          "raw": {"values": 12, "sorts": 1},
          "html": "<p>Counter-example HTML</p>"}]}},
      "name": "recv_inv_2_tr_0",
      "id": 0}]},
   "status": "disproven",
   "name": "recv_inv_2_tr",
   "metadata": {"style": "tr", "property": "inv_2", "kind": "alternative", "action": "recv"},
   "isDormant": false,
   "id": 20,
   "alternativeFor": 19}],
 "totalVCs": 21,
 "totalTime": 5049,
 "totalSolved": 11,
 "totalDischarged": 13}


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
