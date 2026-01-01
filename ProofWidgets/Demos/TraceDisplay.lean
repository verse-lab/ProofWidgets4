import ProofWidgets.Component.TraceDisplay

section
open Lean ProofWidgets

def exampleNoViolation : Json := json% {"termination_reason": {"kind": "explored_all_reachable_states"},
 "result": "no_violation_found",
 "explored_states": 1024}


#displayTrace exampleNoViolation

def ringViolation : Json := json% {"violation":
 {"violates": ["single_leader", "leader_greatest"], "kind": "safety_failure"},
 "trace":
 {"theory":
  {"baaaa":
   [[0, 0, 0],
    [0, 1, 0],
    [0, 2, 0],
    [0, 3, 0],
    [0, 4, 0],
    [1, 0, 0],
    [1, 1, 0],
    [1, 2, 0],
    [1, 3, 0],
    [1, 4, 0],
    [2, 0, 0],
    [2, 1, 0],
    [2, 2, 0],
    [2, 3, 0],
    [2, 4, 0],
    [3, 0, 0],
    [3, 1, 0],
    [3, 2, 0],
    [3, 3, 0],
    [3, 4, 0],
    [4, 0, 0],
    [4, 1, 0],
    [4, 2, 0],
    [4, 3, 0],
    [4, 4, 0]]},
  "states":
  [{"transition": "after_init",
    "index": 0,
    "fields": {"pending": [], "leader": []}},
   {"transition": {"send": {"next": 1, "n": 0}},
    "index": 1,
    "fields": {"pending": [[0, 1]], "leader": []}},
   {"transition": {"send": {"next": 2, "n": 1}},
    "index": 2,
    "fields": {"pending": [[0, 1], [1, 2]], "leader": []}},
   {"transition": {"send": {"next": 3, "n": 2}},
    "index": 3,
    "fields": {"pending": [[0, 1], [1, 2], [2, 3]], "leader": []}},
   {"transition": {"send": {"next": 4, "n": 3}},
    "index": 4,
    "fields": {"pending": [[0, 1], [1, 2], [2, 3], [3, 4]], "leader": []}},
   {"transition": {"send": {"next": 0, "n": 4}},
    "index": 5,
    "fields":
    {"pending": [[0, 1], [1, 2], [2, 3], [3, 4], [4, 0]], "leader": []}},
   {"transition": {"recv": {"sender": 0, "next": 2, "n": 1}},
    "index": 6,
    "fields": {"pending": [[1, 2], [2, 3], [3, 4], [4, 0]], "leader": [1]}},
   {"transition": {"recv": {"sender": 1, "next": 3, "n": 2}},
    "index": 7,
    "fields": {"pending": [[2, 3], [3, 4], [4, 0]], "leader": [1, 2]}},
   {"transition": {"recv": {"sender": 2, "next": 4, "n": 3}},
    "index": 8,
    "fields": {"pending": [[3, 4], [4, 0]], "leader": [1, 2, 3]}},
   {"transition": {"recv": {"sender": 3, "next": 0, "n": 4}},
    "index": 9,
    "fields": {"pending": [[4, 0]], "leader": [1, 2, 3, 4]}},
   {"transition": {"recv": {"sender": 4, "next": 1, "n": 0}},
    "index": 10,
    "fields": {"pending": [], "leader": [0, 1, 2, 3, 4]}}]},
 "state_fingerprint": "16335755120522489119",
 "result": "found_violation"}

#displayTrace ringViolation

def exampleViolation : Json := json% {"violation":
 {"violates": ["single_leader", "leader_greatest"], "kind": "safety_failure"},
 "trace":
 {"theory":
  {"baaaa":
   [[0, 0, 0],
    [0, 1, 0],
    [0, 2, 0],
    [0, 3, 0],
    [0, 4, 0],
    [1, 0, 0],
    [1, 1, 0],
    [1, 2, 0],
    [1, 3, 0],
    [1, 4, 0],
    [2, 0, 0],
    [2, 1, 0],
    [2, 2, 0],
    [2, 3, 0],
    [2, 4, 0],
    [3, 0, 0],
    [3, 1, 0],
    [3, 2, 0],
    [3, 3, 0],
    [3, 4, 0],
    [4, 0, 0],
    [4, 1, 0],
    [4, 2, 0],
    [4, 3, 0],
    [4, 4, 0]]},
  "states":
  [{"transition": "after_init",
    "index": 0,
    "fields": {"pending": [], "leader": []}},
   {"transition": {"send": {"next": 1, "n": 0}},
    "index": 1,
    "fields": {"pending": [[0, 1]], "leader": []}},
   {"transition": {"send": {"next": 2, "n": 1}},
    "index": 2,
    "fields": {"pending": [[0, 1], [1, 2]], "leader": []}},
   {"transition": {"send": {"next": 3, "n": 2}},
    "index": 3,
    "fields": {"pending": [[0, 1], [1, 2], [2, 3]], "leader": []}},
   {"transition": {"send": {"next": 4, "n": 3}},
    "index": 4,
    "fields": {"pending": [[0, 1], [1, 2], [2, 3], [3, 4]], "leader": []}},
   {"transition": {"send": {"next": 0, "n": 4}},
    "index": 5,
    "fields":
    {"pending": [[0, 1], [1, 2], [2, 3], [3, 4], [4, 0]], "leader": []}},
   {"transition": {"recv": {"sender": 0, "next": 2, "n": 1}},
    "index": 6,
    "fields": {"pending": [[1, 2], [2, 3], [3, 4], [4, 0]], "leader": [1]}},
   {"transition": {"recv": {"sender": 1, "next": 3, "n": 2}},
    "index": 7,
    "fields": {"pending": [[2, 3], [3, 4], [4, 0]], "leader": [1, 2]}},
   {"transition": {"recv": {"sender": 2, "next": 4, "n": 3}},
    "index": 8,
    "fields": {"pending": [[3, 4], [4, 0]], "leader": [1, 2, 3]}},
   {"transition": {"recv": {"sender": 3, "next": 0, "n": 4}},
    "index": 9,
    "fields": {"pending": [[4, 0]], "leader": [1, 2, 3, 4]}},
   {"transition": {"recv": {"sender": 4, "next": 1, "n": 0}},
    "index": 10,
    "fields": {"pending": [], "leader": [0, 1, 2, 3, 4]}}]},
 "state_fingerprint": "16335755120522489119",
 "result": "found_violation"}

#displayTrace exampleViolation


def exampleDeadlock : Json := json% {"violation": {"kind": "deadlock"},
 "trace":
 {"theory": {"none": 0},
  "states":
  [{"transition": "after_init",
    "index": 0,
    "fields":
    {"waker": [[0, 0], [1, 0], [2, 0]],
     "wait_queue_wakers": [],
     "stack_waker": [[0, []], [1, []], [2, []]],
     "stack_pc": [[0, []], [1, []], [2, []]],
     "pc":
     [[0, "Mutex.states_IndT.start"],
      [1, "Mutex.states_IndT.start"],
      [2, "Mutex.states_IndT.start"]],
     "locked": false,
     "has_woken": []}},
   {"transition": {"_start": {"self": 0}},
    "index": 1,
    "fields":
    {"waker": [[0, 0], [1, 0], [2, 0]],
     "wait_queue_wakers": [],
     "stack_waker": [[0, [0]], [1, []], [2, []]],
     "stack_pc": [[0, ["Mutex.states_IndT.cs"]], [1, []], [2, []]],
     "pc":
     [[0, "Mutex.states_IndT.pre_check_lock"],
      [1, "Mutex.states_IndT.start"],
      [2, "Mutex.states_IndT.start"]],
     "locked": false,
     "has_woken": []}},
   {"transition": {"_start": {"self": 1}},
    "index": 2,
    "fields":
    {"waker": [[0, 0], [1, 0], [2, 0]],
     "wait_queue_wakers": [],
     "stack_waker": [[0, [0]], [1, [0]], [2, []]],
     "stack_pc":
     [[0, ["Mutex.states_IndT.cs"]], [1, ["Mutex.states_IndT.cs"]], [2, []]],
     "pc":
     [[0, "Mutex.states_IndT.pre_check_lock"],
      [1, "Mutex.states_IndT.pre_check_lock"],
      [2, "Mutex.states_IndT.start"]],
     "locked": false,
     "has_woken": []}},
   {"transition": {"_start": {"self": 2}},
    "index": 3,
    "fields":
    {"waker": [[0, 0], [1, 0], [2, 0]],
     "wait_queue_wakers": [],
     "stack_waker": [[0, [0]], [1, [0]], [2, [0]]],
     "stack_pc":
     [[0, ["Mutex.states_IndT.cs"]],
      [1, ["Mutex.states_IndT.cs"]],
      [2, ["Mutex.states_IndT.cs"]]],
     "pc":
     [[0, "Mutex.states_IndT.pre_check_lock"],
      [1, "Mutex.states_IndT.pre_check_lock"],
      [2, "Mutex.states_IndT.pre_check_lock"]],
     "locked": false,
     "has_woken": []}},
   {"transition": {"_pre_check_lock": {"self": 0}},
    "index": 4,
    "fields":
    {"waker": [[0, 0], [1, 0], [2, 0]],
     "wait_queue_wakers": [],
     "stack_waker": [[0, []], [1, [0]], [2, [0]]],
     "stack_pc":
     [[0, []], [1, ["Mutex.states_IndT.cs"]], [2, ["Mutex.states_IndT.cs"]]],
     "pc":
     [[0, "Mutex.states_IndT.cs"],
      [1, "Mutex.states_IndT.pre_check_lock"],
      [2, "Mutex.states_IndT.pre_check_lock"]],
     "locked": true,
     "has_woken": []}},
   {"transition": {"_pre_check_lock": {"self": 1}},
    "index": 5,
    "fields":
    {"waker": [[0, 0], [1, 0], [2, 0]],
     "wait_queue_wakers": [],
     "stack_waker": [[0, []], [1, [0]], [2, [0]]],
     "stack_pc":
     [[0, []], [1, ["Mutex.states_IndT.cs"]], [2, ["Mutex.states_IndT.cs"]]],
     "pc":
     [[0, "Mutex.states_IndT.cs"],
      [1, "Mutex.states_IndT.wait_until"],
      [2, "Mutex.states_IndT.pre_check_lock"]],
     "locked": true,
     "has_woken": []}},
   {"transition": {"_pre_check_lock": {"self": 2}},
    "index": 6,
    "fields":
    {"waker": [[0, 0], [1, 0], [2, 0]],
     "wait_queue_wakers": [],
     "stack_waker": [[0, []], [1, [0]], [2, [0]]],
     "stack_pc":
     [[0, []], [1, ["Mutex.states_IndT.cs"]], [2, ["Mutex.states_IndT.cs"]]],
     "pc":
     [[0, "Mutex.states_IndT.cs"],
      [1, "Mutex.states_IndT.wait_until"],
      [2, "Mutex.states_IndT.wait_until"]],
     "locked": true,
     "has_woken": []}},
   {"transition": {"_wait_until": {"self": 1}},
    "index": 7,
    "fields":
    {"waker": [[0, 0], [1, 0], [2, 0]],
     "wait_queue_wakers": [],
     "stack_waker": [[0, []], [1, [0]], [2, [0]]],
     "stack_pc":
     [[0, []], [1, ["Mutex.states_IndT.cs"]], [2, ["Mutex.states_IndT.cs"]]],
     "pc":
     [[0, "Mutex.states_IndT.cs"],
      [1, "Mutex.states_IndT.enqueue_waker"],
      [2, "Mutex.states_IndT.wait_until"]],
     "locked": true,
     "has_woken": []}},
   {"transition": {"_wait_until": {"self": 2}},
    "index": 8,
    "fields":
    {"waker": [[0, 0], [1, 0], [2, 0]],
     "wait_queue_wakers": [],
     "stack_waker": [[0, []], [1, [0]], [2, [0]]],
     "stack_pc":
     [[0, []], [1, ["Mutex.states_IndT.cs"]], [2, ["Mutex.states_IndT.cs"]]],
     "pc":
     [[0, "Mutex.states_IndT.cs"],
      [1, "Mutex.states_IndT.enqueue_waker"],
      [2, "Mutex.states_IndT.enqueue_waker"]],
     "locked": true,
     "has_woken": []}},
   {"transition": {"_cs": {"self": 0}},
    "index": 9,
    "fields":
    {"waker": [[0, 0], [1, 0], [2, 0]],
     "wait_queue_wakers": [],
     "stack_waker": [[0, [0]], [1, [0]], [2, [0]]],
     "stack_pc":
     [[0, ["Mutex.states_IndT.Done"]],
      [1, ["Mutex.states_IndT.cs"]],
      [2, ["Mutex.states_IndT.cs"]]],
     "pc":
     [[0, "Mutex.states_IndT.release_lock"],
      [1, "Mutex.states_IndT.enqueue_waker"],
      [2, "Mutex.states_IndT.enqueue_waker"]],
     "locked": true,
     "has_woken": []}},
   {"transition": {"_release_lock": {"self": 0}},
    "index": 10,
    "fields":
    {"waker": [[0, 0], [1, 0], [2, 0]],
     "wait_queue_wakers": [],
     "stack_waker": [[0, [0]], [1, [0]], [2, [0]]],
     "stack_pc":
     [[0, ["Mutex.states_IndT.Done"]],
      [1, ["Mutex.states_IndT.cs"]],
      [2, ["Mutex.states_IndT.cs"]]],
     "pc":
     [[0, "Mutex.states_IndT.wake_one"],
      [1, "Mutex.states_IndT.enqueue_waker"],
      [2, "Mutex.states_IndT.enqueue_waker"]],
     "locked": false,
     "has_woken": []}},
   {"transition": {"_wake_one": {"self": 0}},
    "index": 11,
    "fields":
    {"waker": [[0, 0], [1, 0], [2, 0]],
     "wait_queue_wakers": [],
     "stack_waker": [[0, []], [1, [0]], [2, [0]]],
     "stack_pc":
     [[0, []], [1, ["Mutex.states_IndT.cs"]], [2, ["Mutex.states_IndT.cs"]]],
     "pc":
     [[0, "Mutex.states_IndT.Done"],
      [1, "Mutex.states_IndT.enqueue_waker"],
      [2, "Mutex.states_IndT.enqueue_waker"]],
     "locked": false,
     "has_woken": []}},
   {"transition": {"_enqueue_waker": {"self": 1}},
    "index": 12,
    "fields":
    {"waker": [[0, 0], [1, 0], [2, 0]],
     "wait_queue_wakers": [1],
     "stack_waker": [[0, []], [1, [0]], [2, [0]]],
     "stack_pc":
     [[0, []], [1, ["Mutex.states_IndT.cs"]], [2, ["Mutex.states_IndT.cs"]]],
     "pc":
     [[0, "Mutex.states_IndT.Done"],
      [1, "Mutex.states_IndT.check_lock"],
      [2, "Mutex.states_IndT.enqueue_waker"]],
     "locked": false,
     "has_woken": []}},
   {"transition": {"_enqueue_waker": {"self": 2}},
    "index": 13,
    "fields":
    {"waker": [[0, 0], [1, 0], [2, 0]],
     "wait_queue_wakers": [1, 2],
     "stack_waker": [[0, []], [1, [0]], [2, [0]]],
     "stack_pc":
     [[0, []], [1, ["Mutex.states_IndT.cs"]], [2, ["Mutex.states_IndT.cs"]]],
     "pc":
     [[0, "Mutex.states_IndT.Done"],
      [1, "Mutex.states_IndT.check_lock"],
      [2, "Mutex.states_IndT.check_lock"]],
     "locked": false,
     "has_woken": []}},
   {"transition": {"_check_lock": {"self": 1}},
    "index": 14,
    "fields":
    {"waker": [[0, 0], [1, 0], [2, 0]],
     "wait_queue_wakers": [1, 2],
     "stack_waker": [[0, []], [1, []], [2, [0]]],
     "stack_pc": [[0, []], [1, []], [2, ["Mutex.states_IndT.cs"]]],
     "pc":
     [[0, "Mutex.states_IndT.Done"],
      [1, "Mutex.states_IndT.cs"],
      [2, "Mutex.states_IndT.check_lock"]],
     "locked": true,
     "has_woken": []}},
   {"transition": {"_check_lock": {"self": 2}},
    "index": 15,
    "fields":
    {"waker": [[0, 0], [1, 0], [2, 0]],
     "wait_queue_wakers": [1, 2],
     "stack_waker": [[0, []], [1, []], [2, [0]]],
     "stack_pc": [[0, []], [1, []], [2, ["Mutex.states_IndT.cs"]]],
     "pc":
     [[0, "Mutex.states_IndT.Done"],
      [1, "Mutex.states_IndT.cs"],
      [2, "Mutex.states_IndT.check_has_woken"]],
     "locked": true,
     "has_woken": []}},
   {"transition": {"_cs": {"self": 1}},
    "index": 16,
    "fields":
    {"waker": [[0, 0], [1, 0], [2, 0]],
     "wait_queue_wakers": [1, 2],
     "stack_waker": [[0, []], [1, [0]], [2, [0]]],
     "stack_pc":
     [[0, []], [1, ["Mutex.states_IndT.Done"]], [2, ["Mutex.states_IndT.cs"]]],
     "pc":
     [[0, "Mutex.states_IndT.Done"],
      [1, "Mutex.states_IndT.release_lock"],
      [2, "Mutex.states_IndT.check_has_woken"]],
     "locked": true,
     "has_woken": []}},
   {"transition": {"_release_lock": {"self": 1}},
    "index": 17,
    "fields":
    {"waker": [[0, 0], [1, 0], [2, 0]],
     "wait_queue_wakers": [1, 2],
     "stack_waker": [[0, []], [1, [0]], [2, [0]]],
     "stack_pc":
     [[0, []], [1, ["Mutex.states_IndT.Done"]], [2, ["Mutex.states_IndT.cs"]]],
     "pc":
     [[0, "Mutex.states_IndT.Done"],
      [1, "Mutex.states_IndT.wake_one"],
      [2, "Mutex.states_IndT.check_has_woken"]],
     "locked": false,
     "has_woken": []}},
   {"transition": {"_wake_one": {"self": 1}},
    "index": 18,
    "fields":
    {"waker": [[0, 0], [1, 0], [2, 0]],
     "wait_queue_wakers": [1, 2],
     "stack_waker": [[0, []], [1, [0]], [2, [0]]],
     "stack_pc":
     [[0, []], [1, ["Mutex.states_IndT.Done"]], [2, ["Mutex.states_IndT.cs"]]],
     "pc":
     [[0, "Mutex.states_IndT.Done"],
      [1, "Mutex.states_IndT.wake_one_loop"],
      [2, "Mutex.states_IndT.check_has_woken"]],
     "locked": false,
     "has_woken": []}},
   {"transition": {"_wake_one_loop": {"self": 1}},
    "index": 19,
    "fields":
    {"waker": [[0, 0], [1, 1], [2, 0]],
     "wait_queue_wakers": [2],
     "stack_waker": [[0, []], [1, [0]], [2, [0]]],
     "stack_pc":
     [[0, []], [1, ["Mutex.states_IndT.Done"]], [2, ["Mutex.states_IndT.cs"]]],
     "pc":
     [[0, "Mutex.states_IndT.Done"],
      [1, "Mutex.states_IndT.wake_up"],
      [2, "Mutex.states_IndT.check_has_woken"]],
     "locked": false,
     "has_woken": []}},
   {"transition": {"_wake_up": {"self": 1}},
    "index": 20,
    "fields":
    {"waker": [[0, 0], [1, 0], [2, 0]],
     "wait_queue_wakers": [2],
     "stack_waker": [[0, []], [1, []], [2, [0]]],
     "stack_pc": [[0, []], [1, []], [2, ["Mutex.states_IndT.cs"]]],
     "pc":
     [[0, "Mutex.states_IndT.Done"],
      [1, "Mutex.states_IndT.Done"],
      [2, "Mutex.states_IndT.check_has_woken"]],
     "locked": false,
     "has_woken": [1]}}]},
 "state_fingerprint": "4263100916297288679",
 "result": "found_violation"}

 #displayTrace exampleDeadlock


def exampleNoViolationTrace : Json := json% {
 "trace":
 {"theory":
  {"baaaa":
   [[0, 0, 0],
    [0, 1, 0],
    [0, 2, 0],
    [0, 3, 0],
    [0, 4, 0],
    [1, 0, 0],
    [1, 1, 0],
    [1, 2, 0],
    [1, 3, 0],
    [1, 4, 0],
    [2, 0, 0],
    [2, 1, 0],
    [2, 2, 0],
    [2, 3, 0],
    [2, 4, 0],
    [3, 0, 0],
    [3, 1, 0],
    [3, 2, 0],
    [3, 3, 0],
    [3, 4, 0],
    [4, 0, 0],
    [4, 1, 0],
    [4, 2, 0],
    [4, 3, 0],
    [4, 4, 0]]},
  "states":
  [{"transition": "after_init",
    "index": 0,
    "fields": {"pending": [], "leader": []}},
   {"transition": {"send": {"next": 1, "n": 0}},
    "index": 1,
    "fields": {"pending": [[0, 1]], "leader": []}},
   {"transition": {"send": {"next": 2, "n": 1}},
    "index": 2,
    "fields": {"pending": [[0, 1], [1, 2]], "leader": []}},
   {"transition": {"send": {"next": 3, "n": 2}},
    "index": 3,
    "fields": {"pending": [[0, 1], [1, 2], [2, 3]], "leader": []}},
   {"transition": {"send": {"next": 4, "n": 3}},
    "index": 4,
    "fields": {"pending": [[0, 1], [1, 2], [2, 3], [3, 4]], "leader": []}},
   {"transition": {"send": {"next": 0, "n": 4}},
    "index": 5,
    "fields":
    {"pending": [[0, 1], [1, 2], [2, 3], [3, 4], [4, 0]], "leader": []}},
   {"transition": {"recv": {"sender": 0, "next": 2, "n": 1}},
    "index": 6,
    "fields": {"pending": [[1, 2], [2, 3], [3, 4], [4, 0]], "leader": [1]}},
   {"transition": {"recv": {"sender": 1, "next": 3, "n": 2}},
    "index": 7,
    "fields": {"pending": [[1, 2], [3, 4], [4, 0]], "leader": [1, 2]}},
   {"transition": {"recv": {"sender": 2, "next": 4, "n": 3}},
    "index": 8,
    "fields": {"pending": [[3, 4], [4, 0]], "leader": [1, 2, 3]}},
   {"transition": {"recv": {"sender": 3, "next": 0, "n": 4}},
    "index": 9,
    "fields": {"pending": [[4, 0]], "leader": [1, 2, 3, 4]}},
   {"transition": {"recv": {"sender": 4, "next": 1, "n": 0}},
    "index": 10,
    "fields": {"pending": [], "leader": [0, 1, 2, 3, 4]}}]}}

#displayTrace exampleNoViolationTrace

def exampleBMCUnsatFound : Json := json% {"violation": {"violates": ["foo"], "kind": "safety_failure"},
 "trace":
 {"theory": {},
  "states":
  [{"transition": "after_init",
    "index": 0,
    "fields": {"pending": [], "leader": []}},
   {"transition": {"send": {"next": 1, "n": 0}},
    "index": 1,
    "fields": {"pending": [[0, 1]], "leader": []}},
   {"transition": {"recv": {"sender": 0, "next": 0, "n": 1}},
    "index": 2,
    "fields": {"pending": [], "leader": [1]}},
   {"transition": {"send": {"next": 0, "n": 0}},
    "index": 3,
    "fields": {"pending": [[1, 0]], "leader": [1]}}],
  "instantiation": {"node": "Fin 2"},
  "extraVals": {"tot.le": [[0, 0], [0, 1], [1, 1]], "btwn.btw": []}},
 "result": "found_violation"}

#displayTrace exampleBMCUnsatFound

def exampleBMCSatFound : Json := json% {"trace":
 {"theory": {},
  "states":
  [{"transition": "after_init",
    "index": 0,
    "fields": {"pending": [], "leader": []}},
   {"transition": {"send": {"next": 1, "n": 0}},
    "index": 1,
    "fields": {"pending": [[0, 1]], "leader": []}},
   {"transition": {"recv": {"sender": 0, "next": 0, "n": 1}},
    "index": 2,
    "fields": {"pending": [], "leader": [1]}},
   {"transition": {"send": {"next": 0, "n": 0}},
    "index": 3,
    "fields": {"pending": [[1, 0]], "leader": [1]}}],
  "instantiation": {"node": "Fin 2"},
  "extraVals": {"tot.le": [[0, 0], [0, 1], [1, 1]], "btwn.btw": []}},
 "result": "no_violation_found"}

#displayTrace exampleBMCSatFound
