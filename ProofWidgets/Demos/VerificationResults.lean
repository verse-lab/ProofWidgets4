
import ProofWidgets.Component.RefreshComponent
import ProofWidgets.Component.OfRpcMethod
import ProofWidgets.Component.Panel.SelectionPanel
import ProofWidgets.Component.VerificationResults
import ProofWidgets.Component.HtmlDisplay

section
open Lean.Widget ProofWidgets RefreshComponent Jsx Lean Server


def exampleResults : Json := json% {
  "totalDischarged": 11,
  "totalSolved": 11,
  "totalTime": 3450,
  "totalVCs": 21,
  "vcs": [
    {
      "alternativeFor": null,
      "id": 0,
      "isDormant": false,
      "metadata": {
        "action": "initializer",
        "kind": "primary",
        "property": "doesNotThrow",
        "style": "wp"
      },
      "name": "initializer_doesNotThrow",
      "status": "proven",
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "initializer_doesNotThrow_0",
            "result": {
              "data": null,
              "status": "proven",
              "time": 27
            },
            "status": {
              "finished": {
                "res": {
                  "data": null,
                  "status": "proven",
                  "time": 27
                }
              }
            },
            "time": 27
          }
        ],
        "successfulDischargerId": 0,
        "successfulDischargerTime": 27,
        "totalTime": 27
      }
    },
    {
      "alternativeFor": null,
      "id": 1,
      "isDormant": false,
      "metadata": {
        "action": "initializer",
        "kind": "primary",
        "property": "single_leader",
        "style": "wp"
      },
      "name": "initializer_single_leader",
      "status": "proven",
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "initializer_single_leader_0",
            "result": {
              "data": {
                "kind": "unsat",
                "unsatCores": [
                  []
                ]
              },
              "status": "proven",
              "time": 364
            },
            "status": {
              "finished": {
                "res": {
                  "data": {
                    "kind": "unsat",
                    "unsatCores": [
                      []
                    ]
                  },
                  "status": "proven",
                  "time": 364
                }
              }
            },
            "time": 364
          }
        ],
        "successfulDischargerId": 0,
        "successfulDischargerTime": 364,
        "totalTime": 364
      }
    },
    {
      "alternativeFor": 1,
      "id": 2,
      "isDormant": true,
      "metadata": {
        "action": "initializer",
        "kind": "alternative",
        "property": "single_leader",
        "style": "tr"
      },
      "name": "initializer_single_leader_tr",
      "status": null,
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "initializer_single_leader_tr_0",
            "result": null,
            "status": "notStarted",
            "time": null
          }
        ],
        "successfulDischargerId": null,
        "successfulDischargerTime": null,
        "totalTime": null
      }
    },
    {
      "alternativeFor": null,
      "id": 3,
      "isDormant": false,
      "metadata": {
        "action": "initializer",
        "kind": "primary",
        "property": "leader_greatest",
        "style": "wp"
      },
      "name": "initializer_leader_greatest",
      "status": "proven",
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "initializer_leader_greatest_0",
            "result": {
              "data": null,
              "status": "proven",
              "time": 108
            },
            "status": {
              "finished": {
                "res": {
                  "data": null,
                  "status": "proven",
                  "time": 108
                }
              }
            },
            "time": 108
          }
        ],
        "successfulDischargerId": 0,
        "successfulDischargerTime": 108,
        "totalTime": 108
      }
    },
    {
      "alternativeFor": 3,
      "id": 4,
      "isDormant": true,
      "metadata": {
        "action": "initializer",
        "kind": "alternative",
        "property": "leader_greatest",
        "style": "tr"
      },
      "name": "initializer_leader_greatest_tr",
      "status": null,
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "initializer_leader_greatest_tr_0",
            "result": null,
            "status": "notStarted",
            "time": null
          }
        ],
        "successfulDischargerId": null,
        "successfulDischargerTime": null,
        "totalTime": null
      }
    },
    {
      "alternativeFor": null,
      "id": 5,
      "isDormant": false,
      "metadata": {
        "action": "initializer",
        "kind": "primary",
        "property": "inv_2",
        "style": "wp"
      },
      "name": "initializer_inv_2",
      "status": "proven",
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "initializer_inv_2_0",
            "result": {
              "data": null,
              "status": "proven",
              "time": 107
            },
            "status": {
              "finished": {
                "res": {
                  "data": null,
                  "status": "proven",
                  "time": 107
                }
              }
            },
            "time": 107
          }
        ],
        "successfulDischargerId": 0,
        "successfulDischargerTime": 107,
        "totalTime": 107
      }
    },
    {
      "alternativeFor": 5,
      "id": 6,
      "isDormant": true,
      "metadata": {
        "action": "initializer",
        "kind": "alternative",
        "property": "inv_2",
        "style": "tr"
      },
      "name": "initializer_inv_2_tr",
      "status": null,
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "initializer_inv_2_tr_0",
            "result": null,
            "status": "notStarted",
            "time": null
          }
        ],
        "successfulDischargerId": null,
        "successfulDischargerTime": null,
        "totalTime": null
      }
    },
    {
      "alternativeFor": null,
      "id": 7,
      "isDormant": false,
      "metadata": {
        "action": "send",
        "kind": "primary",
        "property": "doesNotThrow",
        "style": "wp"
      },
      "name": "send_doesNotThrow",
      "status": "proven",
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "send_doesNotThrow_0",
            "result": {
              "data": {
                "kind": "unsat",
                "unsatCores": [
                  []
                ]
              },
              "status": "proven",
              "time": 385
            },
            "status": {
              "finished": {
                "res": {
                  "data": {
                    "kind": "unsat",
                    "unsatCores": [
                      []
                    ]
                  },
                  "status": "proven",
                  "time": 385
                }
              }
            },
            "time": 385
          }
        ],
        "successfulDischargerId": 0,
        "successfulDischargerTime": 385,
        "totalTime": 385
      }
    },
    {
      "alternativeFor": null,
      "id": 8,
      "isDormant": false,
      "metadata": {
        "action": "send",
        "kind": "primary",
        "property": "single_leader",
        "style": "wp"
      },
      "name": "send_single_leader",
      "status": "proven",
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "send_single_leader_0",
            "result": {
              "data": {
                "kind": "unsat",
                "unsatCores": [
                  [
                    "_uniq.101914",
                    "_uniq.102075"
                  ]
                ]
              },
              "status": "proven",
              "time": 414
            },
            "status": {
              "finished": {
                "res": {
                  "data": {
                    "kind": "unsat",
                    "unsatCores": [
                      [
                        "_uniq.101914",
                        "_uniq.102075"
                      ]
                    ]
                  },
                  "status": "proven",
                  "time": 414
                }
              }
            },
            "time": 414
          }
        ],
        "successfulDischargerId": 0,
        "successfulDischargerTime": 414,
        "totalTime": 414
      }
    },
    {
      "alternativeFor": 8,
      "id": 9,
      "isDormant": true,
      "metadata": {
        "action": "send",
        "kind": "alternative",
        "property": "single_leader",
        "style": "tr"
      },
      "name": "send_single_leader_tr",
      "status": null,
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "send_single_leader_tr_0",
            "result": null,
            "status": "notStarted",
            "time": null
          }
        ],
        "successfulDischargerId": null,
        "successfulDischargerTime": null,
        "totalTime": null
      }
    },
    {
      "alternativeFor": null,
      "id": 10,
      "isDormant": false,
      "metadata": {
        "action": "send",
        "kind": "primary",
        "property": "leader_greatest",
        "style": "wp"
      },
      "name": "send_leader_greatest",
      "status": "proven",
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "send_leader_greatest_0",
            "result": {
              "data": {
                "kind": "unsat",
                "unsatCores": [
                  [
                    "_uniq.101855",
                    "_uniq.101988"
                  ]
                ]
              },
              "status": "proven",
              "time": 435
            },
            "status": {
              "finished": {
                "res": {
                  "data": {
                    "kind": "unsat",
                    "unsatCores": [
                      [
                        "_uniq.101855",
                        "_uniq.101988"
                      ]
                    ]
                  },
                  "status": "proven",
                  "time": 435
                }
              }
            },
            "time": 435
          }
        ],
        "successfulDischargerId": 0,
        "successfulDischargerTime": 435,
        "totalTime": 435
      }
    },
    {
      "alternativeFor": 10,
      "id": 11,
      "isDormant": true,
      "metadata": {
        "action": "send",
        "kind": "alternative",
        "property": "leader_greatest",
        "style": "tr"
      },
      "name": "send_leader_greatest_tr",
      "status": null,
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "send_leader_greatest_tr_0",
            "result": null,
            "status": "notStarted",
            "time": null
          }
        ],
        "successfulDischargerId": null,
        "successfulDischargerTime": null,
        "totalTime": null
      }
    },
    {
      "alternativeFor": null,
      "id": 12,
      "isDormant": false,
      "metadata": {
        "action": "send",
        "kind": "primary",
        "property": "inv_2",
        "style": "wp"
      },
      "name": "send_inv_2",
      "status": "proven",
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "send_inv_2_0",
            "result": {
              "data": {
                "kind": "unsat",
                "unsatCores": [
                  [
                    "_uniq.102653",
                    "_uniq.102784",
                    "_uniq.102787"
                  ]
                ]
              },
              "status": "proven",
              "time": 442
            },
            "status": {
              "finished": {
                "res": {
                  "data": {
                    "kind": "unsat",
                    "unsatCores": [
                      [
                        "_uniq.102653",
                        "_uniq.102784",
                        "_uniq.102787"
                      ]
                    ]
                  },
                  "status": "proven",
                  "time": 442
                }
              }
            },
            "time": 442
          }
        ],
        "successfulDischargerId": 0,
        "successfulDischargerTime": 442,
        "totalTime": 442
      }
    },
    {
      "alternativeFor": 12,
      "id": 13,
      "isDormant": true,
      "metadata": {
        "action": "send",
        "kind": "alternative",
        "property": "inv_2",
        "style": "tr"
      },
      "name": "send_inv_2_tr",
      "status": null,
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "send_inv_2_tr_0",
            "result": null,
            "status": "notStarted",
            "time": null
          }
        ],
        "successfulDischargerId": null,
        "successfulDischargerTime": null,
        "totalTime": null
      }
    },
    {
      "alternativeFor": null,
      "id": 14,
      "isDormant": false,
      "metadata": {
        "action": "recv",
        "kind": "primary",
        "property": "doesNotThrow",
        "style": "wp"
      },
      "name": "recv_doesNotThrow",
      "status": "proven",
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "recv_doesNotThrow_0",
            "result": {
              "data": {
                "kind": "unsat",
                "unsatCores": [
                  []
                ]
              },
              "status": "proven",
              "time": 406
            },
            "status": {
              "finished": {
                "res": {
                  "data": {
                    "kind": "unsat",
                    "unsatCores": [
                      []
                    ]
                  },
                  "status": "proven",
                  "time": 406
                }
              }
            },
            "time": 406
          }
        ],
        "successfulDischargerId": 0,
        "successfulDischargerTime": 406,
        "totalTime": 406
      }
    },
    {
      "alternativeFor": null,
      "id": 15,
      "isDormant": false,
      "metadata": {
        "action": "recv",
        "kind": "primary",
        "property": "single_leader",
        "style": "wp"
      },
      "name": "recv_single_leader",
      "status": "proven",
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "recv_single_leader_0",
            "result": {
              "data": {
                "kind": "unsat",
                "unsatCores": [
                  [
                    "_uniq.103731",
                    "_uniq.103855",
                    "_uniq.103891",
                    "_uniq.103892",
                    "_uniq.104031"
                  ]
                ]
              },
              "status": "proven",
              "time": 391
            },
            "status": {
              "finished": {
                "res": {
                  "data": {
                    "kind": "unsat",
                    "unsatCores": [
                      [
                        "_uniq.103731",
                        "_uniq.103855",
                        "_uniq.103891",
                        "_uniq.103892",
                        "_uniq.104031"
                      ]
                    ]
                  },
                  "status": "proven",
                  "time": 391
                }
              }
            },
            "time": 391
          }
        ],
        "successfulDischargerId": 0,
        "successfulDischargerTime": 391,
        "totalTime": 391
      }
    },
    {
      "alternativeFor": 15,
      "id": 16,
      "isDormant": true,
      "metadata": {
        "action": "recv",
        "kind": "alternative",
        "property": "single_leader",
        "style": "tr"
      },
      "name": "recv_single_leader_tr",
      "status": null,
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "recv_single_leader_tr_0",
            "result": null,
            "status": "notStarted",
            "time": null
          }
        ],
        "successfulDischargerId": null,
        "successfulDischargerTime": null,
        "totalTime": null
      }
    },
    {
      "alternativeFor": null,
      "id": 17,
      "isDormant": false,
      "metadata": {
        "action": "recv",
        "kind": "primary",
        "property": "leader_greatest",
        "style": "wp"
      },
      "name": "recv_leader_greatest",
      "status": "proven",
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "recv_leader_greatest_0",
            "result": {
              "data": {
                "kind": "unsat",
                "unsatCores": [
                  [
                    "_uniq.103421",
                    "_uniq.103422",
                    "_uniq.103560"
                  ]
                ]
              },
              "status": "proven",
              "time": 371
            },
            "status": {
              "finished": {
                "res": {
                  "data": {
                    "kind": "unsat",
                    "unsatCores": [
                      [
                        "_uniq.103421",
                        "_uniq.103422",
                        "_uniq.103560"
                      ]
                    ]
                  },
                  "status": "proven",
                  "time": 371
                }
              }
            },
            "time": 371
          }
        ],
        "successfulDischargerId": 0,
        "successfulDischargerTime": 371,
        "totalTime": 371
      }
    },
    {
      "alternativeFor": 17,
      "id": 18,
      "isDormant": true,
      "metadata": {
        "action": "recv",
        "kind": "alternative",
        "property": "leader_greatest",
        "style": "tr"
      },
      "name": "recv_leader_greatest_tr",
      "status": null,
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "recv_leader_greatest_tr_0",
            "result": null,
            "status": "notStarted",
            "time": null
          }
        ],
        "successfulDischargerId": null,
        "successfulDischargerTime": null,
        "totalTime": null
      }
    },
    {
      "alternativeFor": null,
      "id": 19,
      "isDormant": false,
      "metadata": {
        "action": "recv",
        "kind": "primary",
        "property": "inv_2",
        "style": "wp"
      },
      "name": "recv_inv_2",
      "status": null,
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "recv_inv_2_0",
            "result": null,
            "status": {
              "finished": {
                "res": {
                  "exceptions": [
                    "AppBuilder for `mkAppM`, too many explicit arguments provided to\n  @Ring.Theory.mk\narguments\n  #[Fin 3]"
                  ],
                  "status": "error",
                  "time": 0
                }
              }
            },
            "time": null
          }
        ],
        "successfulDischargerId": null,
        "successfulDischargerTime": null,
        "totalTime": null
      }
    },
    {
      "alternativeFor": 19,
      "id": 20,
      "isDormant": true,
      "metadata": {
        "action": "recv",
        "kind": "alternative",
        "property": "inv_2",
        "style": "tr"
      },
      "name": "recv_inv_2_tr",
      "status": null,
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "recv_inv_2_tr_0",
            "result": null,
            "status": "notStarted",
            "time": null
          }
        ],
        "successfulDischargerId": null,
        "successfulDischargerTime": null,
        "totalTime": null
      }
    }
  ]
}


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
