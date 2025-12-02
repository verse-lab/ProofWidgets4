
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
      "name": "initializer_doesNotThrow_0",
      "id": 0}]},
   "status": "proven",
   "name": "initializer_doesNotThrow",
   "metadata":
   {"stmtDerivedFrom": ["Invariants", "initializer", "Assumptions"],
    "property": "doesNotThrow",
    "kind": "primary",
    "action": "initializer"},
   "id": 0},
  {"timing":
   {"totalTime": 506,
    "successfulDischargerTime": 506,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 506,
      "status": "proven",
      "name": "initializer_single_leader_0",
      "id": 0}]},
   "status": "proven",
   "name": "initializer_single_leader",
   "metadata":
   {"stmtDerivedFrom":
    ["Invariants", "initializer", "Assumptions", "single_leader"],
    "property": "single_leader",
    "kind": "primary",
    "action": "initializer"},
   "id": 1},
  {"timing":
   {"totalTime": 100,
    "successfulDischargerTime": 100,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 100,
      "status": "proven",
      "name": "initializer_leader_greatest_0",
      "id": 0}]},
   "status": "proven",
   "name": "initializer_leader_greatest",
   "metadata":
   {"stmtDerivedFrom":
    ["leader_greatest", "Invariants", "initializer", "Assumptions"],
    "property": "leader_greatest",
    "kind": "primary",
    "action": "initializer"},
   "id": 2},
  {"timing":
   {"totalTime": 568,
    "successfulDischargerTime": 568,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 568,
      "status": "proven",
      "name": "initializer_inv_1_0",
      "id": 0}]},
   "status": "proven",
   "name": "initializer_inv_1",
   "metadata":
   {"stmtDerivedFrom": ["Invariants", "initializer", "Assumptions", "inv_1"],
    "property": "inv_1",
    "kind": "primary",
    "action": "initializer"},
   "id": 3},
  {"timing":
   {"totalTime": 92,
    "successfulDischargerTime": 92,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 92, "status": "proven", "name": "initializer_inv_2_0", "id": 0}]},
   "status": "proven",
   "name": "initializer_inv_2",
   "metadata":
   {"stmtDerivedFrom": ["Invariants", "initializer", "Assumptions", "inv_2"],
    "property": "inv_2",
    "kind": "primary",
    "action": "initializer"},
   "id": 4},
  {"timing":
   {"totalTime": 544,
    "successfulDischargerTime": 544,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 544,
      "status": "proven",
      "name": "send_doesNotThrow_0",
      "id": 0}]},
   "status": "proven",
   "name": "send_doesNotThrow",
   "metadata":
   {"stmtDerivedFrom": ["send", "Invariants", "Assumptions"],
    "property": "doesNotThrow",
    "kind": "primary",
    "action": "send"},
   "id": 5},
  {"timing":
   {"totalTime": 644,
    "successfulDischargerTime": 644,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 644,
      "status": "proven",
      "name": "send_single_leader_0",
      "id": 0}]},
   "status": "proven",
   "name": "send_single_leader",
   "metadata":
   {"stmtDerivedFrom": ["send", "Invariants", "Assumptions", "single_leader"],
    "property": "single_leader",
    "kind": "primary",
    "action": "send"},
   "id": 6},
  {"timing":
   {"totalTime": 605,
    "successfulDischargerTime": 605,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 605,
      "status": "proven",
      "name": "send_leader_greatest_0",
      "id": 0}]},
   "status": "proven",
   "name": "send_leader_greatest",
   "metadata":
   {"stmtDerivedFrom": ["send", "leader_greatest", "Invariants", "Assumptions"],
    "property": "leader_greatest",
    "kind": "primary",
    "action": "send"},
   "id": 7},
  {"timing":
   {"totalTime": 675,
    "successfulDischargerTime": 675,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 675, "status": "proven", "name": "send_inv_1_0", "id": 0}]},
   "status": "proven",
   "name": "send_inv_1",
   "metadata":
   {"stmtDerivedFrom": ["send", "Invariants", "Assumptions", "inv_1"],
    "property": "inv_1",
    "kind": "primary",
    "action": "send"},
   "id": 8},
  {"timing":
   {"totalTime": 641,
    "successfulDischargerTime": 641,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 641, "status": "proven", "name": "send_inv_2_0", "id": 0}]},
   "status": "proven",
   "name": "send_inv_2",
   "metadata":
   {"stmtDerivedFrom": ["send", "Invariants", "Assumptions", "inv_2"],
    "property": "inv_2",
    "kind": "primary",
    "action": "send"},
   "id": 9},
  {"timing":
   {"totalTime": 603,
    "successfulDischargerTime": 603,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 603,
      "status": "proven",
      "name": "recv_doesNotThrow_0",
      "id": 0}]},
   "status": "proven",
   "name": "recv_doesNotThrow",
   "metadata":
   {"stmtDerivedFrom": ["recv", "Invariants", "Assumptions"],
    "property": "doesNotThrow",
    "kind": "primary",
    "action": "recv"},
   "id": 10},
  {"timing":
   {"totalTime": 514,
    "successfulDischargerTime": 514,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 514,
      "status": "proven",
      "name": "recv_single_leader_0",
      "id": 0}]},
   "status": "proven",
   "name": "recv_single_leader",
   "metadata":
   {"stmtDerivedFrom": ["recv", "Invariants", "Assumptions", "single_leader"],
    "property": "single_leader",
    "kind": "primary",
    "action": "recv"},
   "id": 11},
  {"timing":
   {"totalTime": 477,
    "successfulDischargerTime": 477,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 477,
      "status": "proven",
      "name": "recv_leader_greatest_0",
      "id": 0}]},
   "status": "proven",
   "name": "recv_leader_greatest",
   "metadata":
   {"stmtDerivedFrom": ["recv", "leader_greatest", "Invariants", "Assumptions"],
    "property": "leader_greatest",
    "kind": "primary",
    "action": "recv"},
   "id": 12},
  {"timing":
   {"totalTime": 559,
    "successfulDischargerTime": 559,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 559, "status": "proven", "name": "recv_inv_1_0", "id": 0}]},
   "status": "proven",
   "name": "recv_inv_1",
   "metadata":
   {"stmtDerivedFrom": ["recv", "Invariants", "Assumptions", "inv_1"],
    "property": "inv_1",
    "kind": "primary",
    "action": "recv"},
   "id": 13},
  {"timing":
   {"totalTime": 518,
    "successfulDischargerTime": 518,
    "successfulDischargerId": 0,
    "dischargers":
    [{"time": 518, "status": "proven", "name": "recv_inv_2_0", "id": 0}]},
   "status": "proven",
   "name": "recv_inv_2",
   "metadata":
   {"stmtDerivedFrom": ["recv", "Invariants", "Assumptions", "inv_2"],
    "property": "inv_2",
    "kind": "primary",
    "action": "recv"},
   "id": 14}],
 "totalVCs": 15,
 "totalTime": 7074,
 "totalSolved": 15,
 "totalDischarged": 15}


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
