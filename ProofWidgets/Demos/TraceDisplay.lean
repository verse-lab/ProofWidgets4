module

public meta import ProofWidgets.Component.TraceDisplay

public meta section
open Lean ProofWidgets

def exampleTrace : Json := json% [{"index": 0,
  "fields":
  {"waker": [["0", "0"], ["1", "0"], ["2", "0"]],
   "wait_queue_wakers": [],
   "stack": [["0", []], ["1", []], ["2", []]],
   "pc":
   [["0", "Mutex.states.start"],
    ["1", "Mutex.states.start"],
    ["2", "Mutex.states.start"]],
   "locked": false,
   "has_woken": []},
  "tag": "after_init"},
 {"index": 1,
  "fields":
  {"waker": [["0", "0"], ["1", "0"], ["2", "0"]],
   "wait_queue_wakers": [],
   "stack":
   [["0", [{"waker": "0", "pc": "Mutex.states.cs"}]], ["1", []], ["2", []]],
   "pc":
   [["0", "Mutex.states.pre_check_lock"],
    ["1", "Mutex.states.start"],
    ["2", "Mutex.states.start"]],
   "locked": false,
   "has_woken": []},
  "tag": "Mutex.Label._start 0"},
 {"index": 2,
  "fields":
  {"waker": [["0", "0"], ["1", "0"], ["2", "0"]],
   "wait_queue_wakers": [],
   "stack": [["0", []], ["1", []], ["2", []]],
   "pc":
   [["0", "Mutex.states.cs"],
    ["1", "Mutex.states.start"],
    ["2", "Mutex.states.start"]],
   "locked": true,
   "has_woken": []},
  "tag": "Mutex.Label._pre_check_lock 0"},
 {"index": 3,
  "fields":
  {"waker": [["0", "0"], ["1", "0"], ["2", "0"]],
   "wait_queue_wakers": [],
   "stack":
   [["0", []], ["1", [{"waker": "0", "pc": "Mutex.states.cs"}]], ["2", []]],
   "pc":
   [["0", "Mutex.states.cs"],
    ["1", "Mutex.states.pre_check_lock"],
    ["2", "Mutex.states.start"]],
   "locked": true,
   "has_woken": []},
  "tag": "Mutex.Label._start 1"},
 {"index": 4,
  "fields":
  {"waker": [["0", "0"], ["1", "0"], ["2", "0"]],
   "wait_queue_wakers": [],
   "stack":
   [["0", []], ["1", [{"waker": "0", "pc": "Mutex.states.cs"}]], ["2", []]],
   "pc":
   [["0", "Mutex.states.cs"],
    ["1", "Mutex.states.prepare_wait_util"],
    ["2", "Mutex.states.start"]],
   "locked": true,
   "has_woken": []},
  "tag": "Mutex.Label._pre_check_lock 1"}]


#displayTrace exampleTrace
