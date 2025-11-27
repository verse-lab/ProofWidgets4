module

public meta import ProofWidgets.Component.VerificationResults

public meta section
open Lean ProofWidgets

def exampleResults : Json := json% {"vcs":
 [{"status": "proven",
   "name": "initializer_doesNotThrow",
   "metadata":
   {"stmtDerivedFrom": ["Invariants", "initializer", "Assumptions"],
    "property": "doesNotThrow",
    "kind": "primary",
    "action": "initializer"},
   "id": 0},
  {"status": "proven",
   "name": "initializer_single_leader",
   "metadata":
   {"stmtDerivedFrom": ["Invariants", "initializer", "Assumptions", "single_leader"],
    "property": "single_leader",
    "kind": "primary",
    "action": "initializer"},
   "id": 1},
  {"status": "proven",
   "name": "initializer_leader_greatest",
   "metadata":
   {"stmtDerivedFrom": ["leader_greatest", "Invariants", "initializer", "Assumptions"],
    "property": "leader_greatest",
    "kind": "primary",
    "action": "initializer"},
   "id": 2},
  {"status": "proven",
   "name": "initializer_inv_1",
   "metadata":
   {"stmtDerivedFrom": ["Invariants", "initializer", "Assumptions", "inv_1"],
    "property": "inv_1",
    "kind": "primary",
    "action": "initializer"},
   "id": 3},
  {"status": "proven",
   "name": "initializer_inv_2",
   "metadata":
   {"stmtDerivedFrom": ["Invariants", "initializer", "Assumptions", "inv_2"],
    "property": "inv_2",
    "kind": "primary",
    "action": "initializer"},
   "id": 4},
  {"status": "proven",
   "name": "send_doesNotThrow",
   "metadata":
   {"stmtDerivedFrom": ["send", "Invariants", "Assumptions"],
    "property": "doesNotThrow",
    "kind": "primary",
    "action": "send"},
   "id": 5},
  {"status": "proven",
   "name": "send_single_leader",
   "metadata":
   {"stmtDerivedFrom": ["send", "Invariants", "Assumptions", "single_leader"],
    "property": "single_leader",
    "kind": "primary",
    "action": "send"},
   "id": 6},
  {"status": "disproven",
   "name": "send_leader_greatest",
   "metadata":
   {"stmtDerivedFrom": ["send", "leader_greatest", "Invariants", "Assumptions"],
    "property": "leader_greatest",
    "kind": "primary",
    "action": "send"},
   "id": 7},
  {"status": "proven",
   "name": "send_inv_1",
   "metadata":
   {"stmtDerivedFrom": ["send", "Invariants", "Assumptions", "inv_1"],
    "property": "inv_1",
    "kind": "primary",
    "action": "send"},
   "id": 8},
  {"status": "proven",
   "name": "send_inv_2",
   "metadata":
   {"stmtDerivedFrom": ["send", "Invariants", "Assumptions", "inv_2"],
    "property": "inv_2",
    "kind": "primary",
    "action": "send"},
   "id": 9},
  {"status": "proven",
   "name": "recv_doesNotThrow",
   "metadata":
   {"stmtDerivedFrom": ["recv", "Invariants", "Assumptions"],
    "property": "doesNotThrow",
    "kind": "primary",
    "action": "recv"},
   "id": 10},
  {"status": "proven",
   "name": "recv_single_leader",
   "metadata":
   {"stmtDerivedFrom": ["recv", "Invariants", "Assumptions", "single_leader"],
    "property": "single_leader",
    "kind": "primary",
    "action": "recv"},
   "id": 11},
  {"status": "proven",
   "name": "recv_leader_greatest",
   "metadata":
   {"stmtDerivedFrom": ["recv", "leader_greatest", "Invariants", "Assumptions"],
    "property": "leader_greatest",
    "kind": "primary",
    "action": "recv"},
   "id": 12},
  {"status": "proven",
   "name": "recv_inv_1",
   "metadata":
   {"stmtDerivedFrom": ["recv", "Invariants", "Assumptions", "inv_1"],
    "property": "inv_1",
    "kind": "primary",
    "action": "recv"},
   "id": 13},
  {"status": "proven",
   "name": "recv_inv_2",
   "metadata":
   {"stmtDerivedFrom": ["recv", "Invariants", "Assumptions", "inv_2"],
    "property": "inv_2",
    "kind": "primary",
    "action": "recv"},
   "id": 14}],
 "totalVCs": 15,
 "totalSolved": 15,
 "totalDischarged": 15}

#displayVerificationResults exampleResults
