
import ProofWidgets.Component.RefreshComponent
import ProofWidgets.Component.OfRpcMethod
import ProofWidgets.Component.Panel.SelectionPanel
import ProofWidgets.Component.VerificationResults
import ProofWidgets.Component.HtmlDisplay

section
open Lean.Widget ProofWidgets RefreshComponent Jsx Lean Server


def exampleResults : Json := json% {"vcs":
 [{"timing":
   {"totalTime": 28,
    "successfulDischargerTime": 28,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 28,
      "status": "proven",
      "result": {"time": 28, "status": "proven", "data": null},
      "name": "initializer_doesNotThrow_0",
      "id": 0}]},
   "status": "proven",
   "name": "initializer_doesNotThrow",
   "metadata": {"property": "doesNotThrow", "kind": "primary", "action": "initializer"},
   "id": 0},
  {"timing":
   {"totalTime": 330,
    "successfulDischargerTime": 330,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 330,
      "status": "proven",
      "result": {"time": 330, "status": "proven", "data": {"unsatCores": [[]], "kind": "unsat"}},
      "name": "initializer_single_leader_0",
      "id": 0}]},
   "status": "proven",
   "name": "initializer_single_leader",
   "metadata": {"property": "single_leader", "kind": "primary", "action": "initializer"},
   "id": 1},
  {"timing":
   {"totalTime": 82,
    "successfulDischargerTime": 82,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 82,
      "status": "proven",
      "result": {"time": 82, "status": "proven", "data": null},
      "name": "initializer_leader_greatest_0",
      "id": 0}]},
   "status": "proven",
   "name": "initializer_leader_greatest",
   "metadata": {"property": "leader_greatest", "kind": "primary", "action": "initializer"},
   "id": 2},
  {"timing":
   {"totalTime": 90,
    "successfulDischargerTime": 90,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 90,
      "status": "proven",
      "result": {"time": 90, "status": "proven", "data": null},
      "name": "initializer_inv_1_0",
      "id": 0}]},
   "status": "proven",
   "name": "initializer_inv_1",
   "metadata": {"property": "inv_1", "kind": "primary", "action": "initializer"},
   "id": 3},
  {"timing":
   {"totalTime": 368,
    "successfulDischargerTime": 368,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 368,
      "status": "proven",
      "result": {"time": 368, "status": "proven", "data": {"unsatCores": [[]], "kind": "unsat"}},
      "name": "send_doesNotThrow_0",
      "id": 0}]},
   "status": "proven",
   "name": "send_doesNotThrow",
   "metadata": {"property": "doesNotThrow", "kind": "primary", "action": "send"},
   "id": 4},
  {"timing":
   {"totalTime": 413,
    "successfulDischargerTime": 413,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 413,
      "status": "proven",
      "result":
      {"time": 413, "status": "proven", "data": {"unsatCores": [["_uniq.60168", "_uniq.60329"]], "kind": "unsat"}},
      "name": "send_single_leader_0",
      "id": 0}]},
   "status": "proven",
   "name": "send_single_leader",
   "metadata": {"property": "single_leader", "kind": "primary", "action": "send"},
   "id": 5},
  {"timing":
   {"totalTime": 391,
    "successfulDischargerTime": 391,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 391,
      "status": "proven",
      "result":
      {"time": 391, "status": "proven", "data": {"unsatCores": [["_uniq.60109", "_uniq.60242"]], "kind": "unsat"}},
      "name": "send_leader_greatest_0",
      "id": 0}]},
   "status": "proven",
   "name": "send_leader_greatest",
   "metadata": {"property": "leader_greatest", "kind": "primary", "action": "send"},
   "id": 6},
  {"timing":
   {"totalTime": 423,
    "successfulDischargerTime": 423,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 423,
      "status": "proven",
      "result":
      {"time": 423,
       "status": "proven",
       "data": {"unsatCores": [["_uniq.61147", "_uniq.61278", "_uniq.61281"]], "kind": "unsat"}},
      "name": "send_inv_1_0",
      "id": 0}]},
   "status": "proven",
   "name": "send_inv_1",
   "metadata": {"property": "inv_1", "kind": "primary", "action": "send"},
   "id": 7},
  {"timing":
   {"totalTime": 412,
    "successfulDischargerTime": 412,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 412,
      "status": "proven",
      "result": {"time": 412, "status": "proven", "data": {"unsatCores": [[]], "kind": "unsat"}},
      "name": "recv_doesNotThrow_0",
      "id": 0}]},
   "status": "proven",
   "name": "recv_doesNotThrow",
   "metadata": {"property": "doesNotThrow", "kind": "primary", "action": "recv"},
   "id": 8},
  {"timing":
   {"totalTime": 432,
    "successfulDischargerTime": 432,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 432,
      "status": "proven",
      "result":
      {"time": 432,
       "status": "proven",
       "data":
       {"unsatCores": [["_uniq.62433", "_uniq.62592", "_uniq.62628", "_uniq.62629", "_uniq.62768"]], "kind": "unsat"}},
      "name": "recv_single_leader_0",
      "id": 0}]},
   "status": "proven",
   "name": "recv_single_leader",
   "metadata": {"property": "single_leader", "kind": "primary", "action": "recv"},
   "id": 9},
  {"timing":
   {"totalTime": 408,
    "successfulDischargerTime": 408,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 408,
      "status": "proven",
      "result":
      {"time": 408,
       "status": "proven",
       "data": {"unsatCores": [["_uniq.61954", "_uniq.61955", "_uniq.62093"]], "kind": "unsat"}},
      "name": "recv_leader_greatest_0",
      "id": 0}]},
   "status": "proven",
   "name": "recv_leader_greatest",
   "metadata": {"property": "leader_greatest", "kind": "primary", "action": "recv"},
   "id": 10},
  {"timing":
   {"totalTime": 311,
    "successfulDischargerTime": null,
    "successfulDischargerId": null,
    "dischargers":
    [{"time": 311,
      "status": "disproven",
      "result":
      {"time": 311,
       "status": "disproven",
       "data":
       {"kind": "sat",
        "counterexamples": [{"model": {"values": 8, "sorts": 1}, "html": {"text": "no model"}}]}},
      "name": "recv_inv_1_0",
      "id": 0}]},
   "status": "disproven",
   "name": "recv_inv_1",
   "metadata": {"property": "inv_1", "kind": "primary", "action": "recv"},
   "id": 11}],
 "totalVCs": 12,
 "totalTime": 3688,
 "totalSolved": 11,
 "totalDischarged": 12}


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
