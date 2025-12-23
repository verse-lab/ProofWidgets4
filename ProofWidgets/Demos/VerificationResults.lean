
import ProofWidgets.Component.RefreshComponent
import ProofWidgets.Component.OfRpcMethod
import ProofWidgets.Component.Panel.SelectionPanel
import ProofWidgets.Component.VerificationResults
import ProofWidgets.Component.HtmlDisplay

section
open Lean.Widget ProofWidgets RefreshComponent Jsx Lean Server


def exampleResults : Json := json% {
  "totalDischarged": 12,
  "totalSolved": 11,
  "totalTime": 4304,
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
              "time": 70
            },
            "status": {
              "finished": {
                "res": {
                  "data": null,
                  "status": "proven",
                  "time": 70
                }
              }
            },
            "time": 70
          }
        ],
        "successfulDischargerId": 0,
        "successfulDischargerTime": 70,
        "totalTime": 70
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
              "time": 467
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
                  "time": 467
                }
              }
            },
            "time": 467
          }
        ],
        "successfulDischargerId": 0,
        "successfulDischargerTime": 467,
        "totalTime": 467
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
      "status": "unknown",
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "initializer_leader_greatest_0",
            "result": {
              "data": null,
              "status": "unknown",
              "time": 218
            },
            "status": {
              "finished": {
                "res": {
                  "data": null,
                  "status": "unknown",
                  "time": 218
                }
              }
            },
            "time": 218
          }
        ],
        "successfulDischargerId": null,
        "successfulDischargerTime": null,
        "totalTime": 218
      }
    },
    {
      "alternativeFor": 3,
      "id": 4,
      "isDormant": false,
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
            "status": "running",
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
              "time": 220
            },
            "status": {
              "finished": {
                "res": {
                  "data": null,
                  "status": "proven",
                  "time": 220
                }
              }
            },
            "time": 220
          }
        ],
        "successfulDischargerId": 0,
        "successfulDischargerTime": 220,
        "totalTime": 220
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
              "time": 481
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
                  "time": 481
                }
              }
            },
            "time": 481
          }
        ],
        "successfulDischargerId": 0,
        "successfulDischargerTime": 481,
        "totalTime": 481
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
              "time": 526
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
                  "time": 526
                }
              }
            },
            "time": 526
          }
        ],
        "successfulDischargerId": 0,
        "successfulDischargerTime": 526,
        "totalTime": 526
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
              "time": 492
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
                  "time": 492
                }
              }
            },
            "time": 492
          }
        ],
        "successfulDischargerId": 0,
        "successfulDischargerTime": 492,
        "totalTime": 492
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
              "time": 464
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
                  "time": 464
                }
              }
            },
            "time": 464
          }
        ],
        "successfulDischargerId": 0,
        "successfulDischargerTime": 464,
        "totalTime": 464
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
              "time": 363
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
                  "time": 363
                }
              }
            },
            "time": 363
          }
        ],
        "successfulDischargerId": 0,
        "successfulDischargerTime": 363,
        "totalTime": 363
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
              "time": 369
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
                  "time": 369
                }
              }
            },
            "time": 369
          }
        ],
        "successfulDischargerId": 0,
        "successfulDischargerTime": 369,
        "totalTime": 369
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
              "time": 367
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
                  "time": 367
                }
              }
            },
            "time": 367
          }
        ],
        "successfulDischargerId": 0,
        "successfulDischargerTime": 367,
        "totalTime": 367
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
      "status": "disproven",
      "timing": {
        "dischargers": [
          {
            "id": 0,
            "name": "recv_inv_2_0",
            "result": {
              "data": {
                "counterexamples": [
                  {
                    "html": {
                      "element": [
                        "div",
                        [
                          [
                            "className",
                            "font-code"
                          ]
                        ],
                        [
                          {
                            "element": [
                              "table",
                              [],
                              [
                                {
                                  "element": [
                                    "thead",
                                    [],
                                    [
                                      {
                                        "element": [
                                          "tr",
                                          [],
                                          [
                                            {
                                              "element": [
                                                "th",
                                                [
                                                  [
                                                    "className",
                                                    "counterexample-column-header"
                                                  ]
                                                ],
                                                [
                                                  {
                                                    "text": "Sort"
                                                  }
                                                ]
                                              ]
                                            },
                                            {
                                              "element": [
                                                "th",
                                                [
                                                  [
                                                    "className",
                                                    "counterexample-column-header"
                                                  ]
                                                ],
                                                [
                                                  {
                                                    "text": "Cardinality"
                                                  }
                                                ]
                                              ]
                                            }
                                          ]
                                        ]
                                      }
                                    ]
                                  ]
                                },
                                {
                                  "element": [
                                    "tbody",
                                    [],
                                    [
                                      {
                                        "element": [
                                          "tr",
                                          [],
                                          [
                                            {
                                              "element": [
                                                "td",
                                                [],
                                                [
                                                  {
                                                    "component": [
                                                      "11582378131819853457",
                                                      "default",
                                                      {
                                                        "expr": {
                                                          "p": "1"
                                                        }
                                                      },
                                                      []
                                                    ]
                                                  }
                                                ]
                                              ]
                                            },
                                            {
                                              "element": [
                                                "td",
                                                [],
                                                [
                                                  {
                                                    "component": [
                                                      "1305683135076217222",
                                                      "default",
                                                      {
                                                        "fmt": {
                                                          "tag": [
                                                            {
                                                              "info": {
                                                                "p": "2"
                                                              },
                                                              "subexprPos": "/"
                                                            },
                                                            {
                                                              "append": [
                                                                {
                                                                  "text": "Fin "
                                                                },
                                                                {
                                                                  "tag": [
                                                                    {
                                                                      "info": {
                                                                        "p": "3"
                                                                      },
                                                                      "subexprPos": "/1"
                                                                    },
                                                                    {
                                                                      "text": "3"
                                                                    }
                                                                  ]
                                                                }
                                                              ]
                                                            }
                                                          ]
                                                        }
                                                      },
                                                      []
                                                    ]
                                                  }
                                                ]
                                              ]
                                            }
                                          ]
                                        ]
                                      }
                                    ]
                                  ]
                                },
                                {
                                  "element": [
                                    "thead",
                                    [],
                                    [
                                      {
                                        "element": [
                                          "tr",
                                          [],
                                          [
                                            {
                                              "element": [
                                                "th",
                                                [
                                                  [
                                                    "className",
                                                    "counterexample-column-header"
                                                  ]
                                                ],
                                                [
                                                  {
                                                    "text": "Constant"
                                                  }
                                                ]
                                              ]
                                            },
                                            {
                                              "element": [
                                                "th",
                                                [
                                                  [
                                                    "className",
                                                    "counterexample-column-header"
                                                  ]
                                                ],
                                                [
                                                  {
                                                    "text": "Value"
                                                  }
                                                ]
                                              ]
                                            }
                                          ]
                                        ]
                                      }
                                    ]
                                  ]
                                },
                                {
                                  "element": [
                                    "tbody",
                                    [],
                                    [
                                      {
                                        "element": [
                                          "tr",
                                          [],
                                          [
                                            {
                                              "element": [
                                                "td",
                                                [],
                                                [
                                                  {
                                                    "component": [
                                                      "11582378131819853457",
                                                      "default",
                                                      {
                                                        "expr": {
                                                          "p": "4"
                                                        }
                                                      },
                                                      []
                                                    ]
                                                  }
                                                ]
                                              ]
                                            },
                                            {
                                              "element": [
                                                "td",
                                                [],
                                                [
                                                  {
                                                    "component": [
                                                      "1305683135076217222",
                                                      "default",
                                                      {
                                                        "fmt": {
                                                          "tag": [
                                                            {
                                                              "info": {
                                                                "p": "5"
                                                              },
                                                              "subexprPos": "/"
                                                            },
                                                            {
                                                              "text": "0"
                                                            }
                                                          ]
                                                        }
                                                      },
                                                      []
                                                    ]
                                                  }
                                                ]
                                              ]
                                            }
                                          ]
                                        ]
                                      },
                                      {
                                        "element": [
                                          "tr",
                                          [],
                                          [
                                            {
                                              "element": [
                                                "td",
                                                [],
                                                [
                                                  {
                                                    "component": [
                                                      "11582378131819853457",
                                                      "default",
                                                      {
                                                        "expr": {
                                                          "p": "6"
                                                        }
                                                      },
                                                      []
                                                    ]
                                                  }
                                                ]
                                              ]
                                            },
                                            {
                                              "element": [
                                                "td",
                                                [],
                                                [
                                                  {
                                                    "component": [
                                                      "1305683135076217222",
                                                      "default",
                                                      {
                                                        "fmt": {
                                                          "tag": [
                                                            {
                                                              "info": {
                                                                "p": "7"
                                                              },
                                                              "subexprPos": "/"
                                                            },
                                                            {
                                                              "text": "2"
                                                            }
                                                          ]
                                                        }
                                                      },
                                                      []
                                                    ]
                                                  }
                                                ]
                                              ]
                                            }
                                          ]
                                        ]
                                      },
                                      {
                                        "element": [
                                          "tr",
                                          [],
                                          [
                                            {
                                              "element": [
                                                "td",
                                                [],
                                                [
                                                  {
                                                    "component": [
                                                      "11582378131819853457",
                                                      "default",
                                                      {
                                                        "expr": {
                                                          "p": "8"
                                                        }
                                                      },
                                                      []
                                                    ]
                                                  }
                                                ]
                                              ]
                                            },
                                            {
                                              "element": [
                                                "td",
                                                [],
                                                [
                                                  {
                                                    "component": [
                                                      "1305683135076217222",
                                                      "default",
                                                      {
                                                        "fmt": {
                                                          "tag": [
                                                            {
                                                              "info": {
                                                                "p": "9"
                                                              },
                                                              "subexprPos": "/"
                                                            },
                                                            {
                                                              "append": [
                                                                {
                                                                  "text": "fun "
                                                                },
                                                                {
                                                                  "tag": [
                                                                    {
                                                                      "info": {
                                                                        "p": "10"
                                                                      },
                                                                      "subexprPos": "/"
                                                                    },
                                                                    {
                                                                      "text": "«$x1»"
                                                                    }
                                                                  ]
                                                                },
                                                                {
                                                                  "text": " "
                                                                },
                                                                {
                                                                  "tag": [
                                                                    {
                                                                      "info": {
                                                                        "p": "11"
                                                                      },
                                                                      "subexprPos": "/"
                                                                    },
                                                                    {
                                                                      "text": "«$x2»"
                                                                    }
                                                                  ]
                                                                },
                                                                {
                                                                  "text": " => "
                                                                },
                                                                {
                                                                  "tag": [
                                                                    {
                                                                      "info": {
                                                                        "p": "12"
                                                                      },
                                                                      "subexprPos": "/1/1"
                                                                    },
                                                                    {
                                                                      "append": [
                                                                        {
                                                                          "tag": [
                                                                            {
                                                                              "info": {
                                                                                "p": "13"
                                                                              },
                                                                              "subexprPos": "/1/1/0/1"
                                                                            },
                                                                            {
                                                                              "append": [
                                                                                {
                                                                                  "tag": [
                                                                                    {
                                                                                      "info": {
                                                                                        "p": "14"
                                                                                      },
                                                                                      "subexprPos": "/1/1/0/1/0/1"
                                                                                    },
                                                                                    {
                                                                                      "text": "2"
                                                                                    }
                                                                                  ]
                                                                                },
                                                                                {
                                                                                  "text": " = "
                                                                                },
                                                                                {
                                                                                  "tag": [
                                                                                    {
                                                                                      "info": {
                                                                                        "p": "15"
                                                                                      },
                                                                                      "subexprPos": "/1/1/0/1/1"
                                                                                    },
                                                                                    {
                                                                                      "text": "«$x1»"
                                                                                    }
                                                                                  ]
                                                                                }
                                                                              ]
                                                                            }
                                                                          ]
                                                                        },
                                                                        {
                                                                          "text": " ∧ "
                                                                        },
                                                                        {
                                                                          "tag": [
                                                                            {
                                                                              "info": {
                                                                                "p": "16"
                                                                              },
                                                                              "subexprPos": "/1/1/1"
                                                                            },
                                                                            {
                                                                              "append": [
                                                                                {
                                                                                  "tag": [
                                                                                    {
                                                                                      "info": {
                                                                                        "p": "17"
                                                                                      },
                                                                                      "subexprPos": "/1/1/1/0/1"
                                                                                    },
                                                                                    {
                                                                                      "text": "0"
                                                                                    }
                                                                                  ]
                                                                                },
                                                                                {
                                                                                  "text": " = "
                                                                                },
                                                                                {
                                                                                  "tag": [
                                                                                    {
                                                                                      "info": {
                                                                                        "p": "18"
                                                                                      },
                                                                                      "subexprPos": "/1/1/1/1"
                                                                                    },
                                                                                    {
                                                                                      "text": "«$x2»"
                                                                                    }
                                                                                  ]
                                                                                }
                                                                              ]
                                                                            }
                                                                          ]
                                                                        }
                                                                      ]
                                                                    }
                                                                  ]
                                                                }
                                                              ]
                                                            }
                                                          ]
                                                        }
                                                      },
                                                      []
                                                    ]
                                                  }
                                                ]
                                              ]
                                            }
                                          ]
                                        ]
                                      },
                                      {
                                        "element": [
                                          "tr",
                                          [],
                                          [
                                            {
                                              "element": [
                                                "td",
                                                [],
                                                [
                                                  {
                                                    "component": [
                                                      "11582378131819853457",
                                                      "default",
                                                      {
                                                        "expr": {
                                                          "p": "19"
                                                        }
                                                      },
                                                      []
                                                    ]
                                                  }
                                                ]
                                              ]
                                            },
                                            {
                                              "element": [
                                                "td",
                                                [],
                                                [
                                                  {
                                                    "component": [
                                                      "1305683135076217222",
                                                      "default",
                                                      {
                                                        "fmt": {
                                                          "tag": [
                                                            {
                                                              "info": {
                                                                "p": "20"
                                                              },
                                                              "subexprPos": "/"
                                                            },
                                                            {
                                                              "append": [
                                                                {
                                                                  "text": "fun "
                                                                },
                                                                {
                                                                  "tag": [
                                                                    {
                                                                      "info": {
                                                                        "p": "21"
                                                                      },
                                                                      "subexprPos": "/"
                                                                    },
                                                                    {
                                                                      "text": "«$x1»"
                                                                    }
                                                                  ]
                                                                },
                                                                {
                                                                  "text": " "
                                                                },
                                                                {
                                                                  "tag": [
                                                                    {
                                                                      "info": {
                                                                        "p": "22"
                                                                      },
                                                                      "subexprPos": "/"
                                                                    },
                                                                    {
                                                                      "text": "«$x2»"
                                                                    }
                                                                  ]
                                                                },
                                                                {
                                                                  "text": " "
                                                                },
                                                                {
                                                                  "tag": [
                                                                    {
                                                                      "info": {
                                                                        "p": "23"
                                                                      },
                                                                      "subexprPos": "/0"
                                                                    },
                                                                    {
                                                                      "text": "«$x3»"
                                                                    }
                                                                  ]
                                                                },
                                                                {
                                                                  "text": " =>\n  "
                                                                },
                                                                {
                                                                  "tag": [
                                                                    {
                                                                      "info": {
                                                                        "p": "24"
                                                                      },
                                                                      "subexprPos": "/1/1/1"
                                                                    },
                                                                    {
                                                                      "append": [
                                                                        {
                                                                          "tag": [
                                                                            {
                                                                              "info": {
                                                                                "p": "25"
                                                                              },
                                                                              "subexprPos": "/1/1/1/0/1"
                                                                            },
                                                                            {
                                                                              "append": [
                                                                                {
                                                                                  "tag": [
                                                                                    {
                                                                                      "info": {
                                                                                        "p": "26"
                                                                                      },
                                                                                      "subexprPos": "/1/1/1/0/1/0/1"
                                                                                    },
                                                                                    {
                                                                                      "append": [
                                                                                        {
                                                                                          "tag": [
                                                                                            {
                                                                                              "info": {
                                                                                                "p": "27"
                                                                                              },
                                                                                              "subexprPos": "/1/1/1/0/1/0/1/0/1"
                                                                                            },
                                                                                            {
                                                                                              "text": "0"
                                                                                            }
                                                                                          ]
                                                                                        },
                                                                                        {
                                                                                          "text": " = "
                                                                                        },
                                                                                        {
                                                                                          "tag": [
                                                                                            {
                                                                                              "info": {
                                                                                                "p": "28"
                                                                                              },
                                                                                              "subexprPos": "/1/1/1/0/1/0/1/1"
                                                                                            },
                                                                                            {
                                                                                              "text": "«$x1»"
                                                                                            }
                                                                                          ]
                                                                                        }
                                                                                      ]
                                                                                    }
                                                                                  ]
                                                                                },
                                                                                {
                                                                                  "text": " ∧ "
                                                                                },
                                                                                {
                                                                                  "tag": [
                                                                                    {
                                                                                      "info": {
                                                                                        "p": "29"
                                                                                      },
                                                                                      "subexprPos": "/1/1/1/0/1/1"
                                                                                    },
                                                                                    {
                                                                                      "append": [
                                                                                        {
                                                                                          "tag": [
                                                                                            {
                                                                                              "info": {
                                                                                                "p": "30"
                                                                                              },
                                                                                              "subexprPos": "/1/1/1/0/1/1/0/1"
                                                                                            },
                                                                                            {
                                                                                              "append": [
                                                                                                {
                                                                                                  "tag": [
                                                                                                    {
                                                                                                      "info": {
                                                                                                        "p": "31"
                                                                                                      },
                                                                                                      "subexprPos": "/1/1/1/0/1/1/0/1/0/1"
                                                                                                    },
                                                                                                    {
                                                                                                      "text": "2"
                                                                                                    }
                                                                                                  ]
                                                                                                },
                                                                                                {
                                                                                                  "text": " = "
                                                                                                },
                                                                                                {
                                                                                                  "tag": [
                                                                                                    {
                                                                                                      "info": {
                                                                                                        "p": "32"
                                                                                                      },
                                                                                                      "subexprPos": "/1/1/1/0/1/1/0/1/1"
                                                                                                    },
                                                                                                    {
                                                                                                      "text": "«$x2»"
                                                                                                    }
                                                                                                  ]
                                                                                                }
                                                                                              ]
                                                                                            }
                                                                                          ]
                                                                                        },
                                                                                        {
                                                                                          "text": " ∧ "
                                                                                        },
                                                                                        {
                                                                                          "tag": [
                                                                                            {
                                                                                              "info": {
                                                                                                "p": "33"
                                                                                              },
                                                                                              "subexprPos": "/1/1/1/0/1/1/1"
                                                                                            },
                                                                                            {
                                                                                              "append": [
                                                                                                {
                                                                                                  "tag": [
                                                                                                    {
                                                                                                      "info": {
                                                                                                        "p": "34"
                                                                                                      },
                                                                                                      "subexprPos": "/1/1/1/0/1/1/1/0/1"
                                                                                                    },
                                                                                                    {
                                                                                                      "text": "1"
                                                                                                    }
                                                                                                  ]
                                                                                                },
                                                                                                {
                                                                                                  "text": " = "
                                                                                                },
                                                                                                {
                                                                                                  "tag": [
                                                                                                    {
                                                                                                      "info": {
                                                                                                        "p": "35"
                                                                                                      },
                                                                                                      "subexprPos": "/1/1/1/0/1/1/1/1"
                                                                                                    },
                                                                                                    {
                                                                                                      "text": "«$x3»"
                                                                                                    }
                                                                                                  ]
                                                                                                }
                                                                                              ]
                                                                                            }
                                                                                          ]
                                                                                        }
                                                                                      ]
                                                                                    }
                                                                                  ]
                                                                                }
                                                                              ]
                                                                            }
                                                                          ]
                                                                        },
                                                                        {
                                                                          "text": " ∨ "
                                                                        },
                                                                        {
                                                                          "tag": [
                                                                            {
                                                                              "info": {
                                                                                "p": "36"
                                                                              },
                                                                              "subexprPos": "/1/1/1/1"
                                                                            },
                                                                            {
                                                                              "append": [
                                                                                {
                                                                                  "tag": [
                                                                                    {
                                                                                      "info": {
                                                                                        "p": "37"
                                                                                      },
                                                                                      "subexprPos": "/1/1/1/1/0/1"
                                                                                    },
                                                                                    {
                                                                                      "append": [
                                                                                        {
                                                                                          "tag": [
                                                                                            {
                                                                                              "info": {
                                                                                                "p": "38"
                                                                                              },
                                                                                              "subexprPos": "/1/1/1/1/0/1/0/1"
                                                                                            },
                                                                                            {
                                                                                              "append": [
                                                                                                {
                                                                                                  "tag": [
                                                                                                    {
                                                                                                      "info": {
                                                                                                        "p": "39"
                                                                                                      },
                                                                                                      "subexprPos": "/1/1/1/1/0/1/0/1/0/1"
                                                                                                    },
                                                                                                    {
                                                                                                      "text": "2"
                                                                                                    }
                                                                                                  ]
                                                                                                },
                                                                                                {
                                                                                                  "text": " = "
                                                                                                },
                                                                                                {
                                                                                                  "tag": [
                                                                                                    {
                                                                                                      "info": {
                                                                                                        "p": "40"
                                                                                                      },
                                                                                                      "subexprPos": "/1/1/1/1/0/1/0/1/1"
                                                                                                    },
                                                                                                    {
                                                                                                      "text": "«$x1»"
                                                                                                    }
                                                                                                  ]
                                                                                                }
                                                                                              ]
                                                                                            }
                                                                                          ]
                                                                                        },
                                                                                        {
                                                                                          "text": " ∧ "
                                                                                        },
                                                                                        {
                                                                                          "tag": [
                                                                                            {
                                                                                              "info": {
                                                                                                "p": "41"
                                                                                              },
                                                                                              "subexprPos": "/1/1/1/1/0/1/1"
                                                                                            },
                                                                                            {
                                                                                              "append": [
                                                                                                {
                                                                                                  "tag": [
                                                                                                    {
                                                                                                      "info": {
                                                                                                        "p": "42"
                                                                                                      },
                                                                                                      "subexprPos": "/1/1/1/1/0/1/1/0/1"
                                                                                                    },
                                                                                                    {
                                                                                                      "append": [
                                                                                                        {
                                                                                                          "tag": [
                                                                                                            {
                                                                                                              "info": {
                                                                                                                "p": "43"
                                                                                                              },
                                                                                                              "subexprPos": "/1/1/1/1/0/1/1/0/1/0/1"
                                                                                                            },
                                                                                                            {
                                                                                                              "text": "1"
                                                                                                            }
                                                                                                          ]
                                                                                                        },
                                                                                                        {
                                                                                                          "text": " = "
                                                                                                        },
                                                                                                        {
                                                                                                          "tag": [
                                                                                                            {
                                                                                                              "info": {
                                                                                                                "p": "44"
                                                                                                              },
                                                                                                              "subexprPos": "/1/1/1/1/0/1/1/0/1/1"
                                                                                                            },
                                                                                                            {
                                                                                                              "text": "«$x2»"
                                                                                                            }
                                                                                                          ]
                                                                                                        }
                                                                                                      ]
                                                                                                    }
                                                                                                  ]
                                                                                                },
                                                                                                {
                                                                                                  "text": " ∧ "
                                                                                                },
                                                                                                {
                                                                                                  "tag": [
                                                                                                    {
                                                                                                      "info": {
                                                                                                        "p": "45"
                                                                                                      },
                                                                                                      "subexprPos": "/1/1/1/1/0/1/1/1"
                                                                                                    },
                                                                                                    {
                                                                                                      "append": [
                                                                                                        {
                                                                                                          "tag": [
                                                                                                            {
                                                                                                              "info": {
                                                                                                                "p": "46"
                                                                                                              },
                                                                                                              "subexprPos": "/1/1/1/1/0/1/1/1/0/1"
                                                                                                            },
                                                                                                            {
                                                                                                              "text": "0"
                                                                                                            }
                                                                                                          ]
                                                                                                        },
                                                                                                        {
                                                                                                          "text": " = "
                                                                                                        },
                                                                                                        {
                                                                                                          "tag": [
                                                                                                            {
                                                                                                              "info": {
                                                                                                                "p": "47"
                                                                                                              },
                                                                                                              "subexprPos": "/1/1/1/1/0/1/1/1/1"
                                                                                                            },
                                                                                                            {
                                                                                                              "text": "«$x3»"
                                                                                                            }
                                                                                                          ]
                                                                                                        }
                                                                                                      ]
                                                                                                    }
                                                                                                  ]
                                                                                                }
                                                                                              ]
                                                                                            }
                                                                                          ]
                                                                                        }
                                                                                      ]
                                                                                    }
                                                                                  ]
                                                                                },
                                                                                {
                                                                                  "text": " ∨ "
                                                                                },
                                                                                {
                                                                                  "tag": [
                                                                                    {
                                                                                      "info": {
                                                                                        "p": "48"
                                                                                      },
                                                                                      "subexprPos": "/1/1/1/1/1"
                                                                                    },
                                                                                    {
                                                                                      "append": [
                                                                                        {
                                                                                          "tag": [
                                                                                            {
                                                                                              "info": {
                                                                                                "p": "49"
                                                                                              },
                                                                                              "subexprPos": "/1/1/1/1/1/0/1"
                                                                                            },
                                                                                            {
                                                                                              "append": [
                                                                                                {
                                                                                                  "tag": [
                                                                                                    {
                                                                                                      "info": {
                                                                                                        "p": "50"
                                                                                                      },
                                                                                                      "subexprPos": "/1/1/1/1/1/0/1/0/1"
                                                                                                    },
                                                                                                    {
                                                                                                      "text": "1"
                                                                                                    }
                                                                                                  ]
                                                                                                },
                                                                                                {
                                                                                                  "text": " = "
                                                                                                },
                                                                                                {
                                                                                                  "tag": [
                                                                                                    {
                                                                                                      "info": {
                                                                                                        "p": "51"
                                                                                                      },
                                                                                                      "subexprPos": "/1/1/1/1/1/0/1/1"
                                                                                                    },
                                                                                                    {
                                                                                                      "text": "«$x1»"
                                                                                                    }
                                                                                                  ]
                                                                                                }
                                                                                              ]
                                                                                            }
                                                                                          ]
                                                                                        },
                                                                                        {
                                                                                          "text": " ∧ "
                                                                                        },
                                                                                        {
                                                                                          "tag": [
                                                                                            {
                                                                                              "info": {
                                                                                                "p": "52"
                                                                                              },
                                                                                              "subexprPos": "/1/1/1/1/1/1"
                                                                                            },
                                                                                            {
                                                                                              "append": [
                                                                                                {
                                                                                                  "tag": [
                                                                                                    {
                                                                                                      "info": {
                                                                                                        "p": "53"
                                                                                                      },
                                                                                                      "subexprPos": "/1/1/1/1/1/1/0/1"
                                                                                                    },
                                                                                                    {
                                                                                                      "append": [
                                                                                                        {
                                                                                                          "tag": [
                                                                                                            {
                                                                                                              "info": {
                                                                                                                "p": "54"
                                                                                                              },
                                                                                                              "subexprPos": "/1/1/1/1/1/1/0/1/0/1"
                                                                                                            },
                                                                                                            {
                                                                                                              "text": "0"
                                                                                                            }
                                                                                                          ]
                                                                                                        },
                                                                                                        {
                                                                                                          "text": " = "
                                                                                                        },
                                                                                                        {
                                                                                                          "tag": [
                                                                                                            {
                                                                                                              "info": {
                                                                                                                "p": "55"
                                                                                                              },
                                                                                                              "subexprPos": "/1/1/1/1/1/1/0/1/1"
                                                                                                            },
                                                                                                            {
                                                                                                              "text": "«$x2»"
                                                                                                            }
                                                                                                          ]
                                                                                                        }
                                                                                                      ]
                                                                                                    }
                                                                                                  ]
                                                                                                },
                                                                                                {
                                                                                                  "text": " ∧ "
                                                                                                },
                                                                                                {
                                                                                                  "tag": [
                                                                                                    {
                                                                                                      "info": {
                                                                                                        "p": "56"
                                                                                                      },
                                                                                                      "subexprPos": "/1/1/1/1/1/1/1"
                                                                                                    },
                                                                                                    {
                                                                                                      "append": [
                                                                                                        {
                                                                                                          "tag": [
                                                                                                            {
                                                                                                              "info": {
                                                                                                                "p": "57"
                                                                                                              },
                                                                                                              "subexprPos": "/1/1/1/1/1/1/1/0/1"
                                                                                                            },
                                                                                                            {
                                                                                                              "text": "2"
                                                                                                            }
                                                                                                          ]
                                                                                                        },
                                                                                                        {
                                                                                                          "text": " = "
                                                                                                        },
                                                                                                        {
                                                                                                          "tag": [
                                                                                                            {
                                                                                                              "info": {
                                                                                                                "p": "58"
                                                                                                              },
                                                                                                              "subexprPos": "/1/1/1/1/1/1/1/1"
                                                                                                            },
                                                                                                            {
                                                                                                              "text": "«$x3»"
                                                                                                            }
                                                                                                          ]
                                                                                                        }
                                                                                                      ]
                                                                                                    }
                                                                                                  ]
                                                                                                }
                                                                                              ]
                                                                                            }
                                                                                          ]
                                                                                        }
                                                                                      ]
                                                                                    }
                                                                                  ]
                                                                                }
                                                                              ]
                                                                            }
                                                                          ]
                                                                        }
                                                                      ]
                                                                    }
                                                                  ]
                                                                }
                                                              ]
                                                            }
                                                          ]
                                                        }
                                                      },
                                                      []
                                                    ]
                                                  }
                                                ]
                                              ]
                                            }
                                          ]
                                        ]
                                      },
                                      {
                                        "element": [
                                          "tr",
                                          [],
                                          [
                                            {
                                              "element": [
                                                "td",
                                                [],
                                                [
                                                  {
                                                    "component": [
                                                      "11582378131819853457",
                                                      "default",
                                                      {
                                                        "expr": {
                                                          "p": "59"
                                                        }
                                                      },
                                                      []
                                                    ]
                                                  }
                                                ]
                                              ]
                                            },
                                            {
                                              "element": [
                                                "td",
                                                [],
                                                [
                                                  {
                                                    "component": [
                                                      "1305683135076217222",
                                                      "default",
                                                      {
                                                        "fmt": {
                                                          "tag": [
                                                            {
                                                              "info": {
                                                                "p": "60"
                                                              },
                                                              "subexprPos": "/"
                                                            },
                                                            {
                                                              "text": "2"
                                                            }
                                                          ]
                                                        }
                                                      },
                                                      []
                                                    ]
                                                  }
                                                ]
                                              ]
                                            }
                                          ]
                                        ]
                                      },
                                      {
                                        "element": [
                                          "tr",
                                          [],
                                          [
                                            {
                                              "element": [
                                                "td",
                                                [],
                                                [
                                                  {
                                                    "component": [
                                                      "11582378131819853457",
                                                      "default",
                                                      {
                                                        "expr": {
                                                          "p": "61"
                                                        }
                                                      },
                                                      []
                                                    ]
                                                  }
                                                ]
                                              ]
                                            },
                                            {
                                              "element": [
                                                "td",
                                                [],
                                                [
                                                  {
                                                    "component": [
                                                      "1305683135076217222",
                                                      "default",
                                                      {
                                                        "fmt": {
                                                          "tag": [
                                                            {
                                                              "info": {
                                                                "p": "62"
                                                              },
                                                              "subexprPos": "/"
                                                            },
                                                            {
                                                              "append": [
                                                                {
                                                                  "text": "fun "
                                                                },
                                                                {
                                                                  "tag": [
                                                                    {
                                                                      "info": {
                                                                        "p": "63"
                                                                      },
                                                                      "subexprPos": "/"
                                                                    },
                                                                    {
                                                                      "text": "«$x1»"
                                                                    }
                                                                  ]
                                                                },
                                                                {
                                                                  "text": " "
                                                                },
                                                                {
                                                                  "tag": [
                                                                    {
                                                                      "info": {
                                                                        "p": "64"
                                                                      },
                                                                      "subexprPos": "/"
                                                                    },
                                                                    {
                                                                      "text": "«$x2»"
                                                                    }
                                                                  ]
                                                                },
                                                                {
                                                                  "text": " =>\n  "
                                                                },
                                                                {
                                                                  "tag": [
                                                                    {
                                                                      "info": {
                                                                        "p": "65"
                                                                      },
                                                                      "subexprPos": "/1/1"
                                                                    },
                                                                    {
                                                                      "append": [
                                                                        {
                                                                          "tag": [
                                                                            {
                                                                              "info": {
                                                                                "p": "66"
                                                                              },
                                                                              "subexprPos": "/1/1/0/1"
                                                                            },
                                                                            {
                                                                              "append": [
                                                                                {
                                                                                  "tag": [
                                                                                    {
                                                                                      "info": {
                                                                                        "p": "67"
                                                                                      },
                                                                                      "subexprPos": "/1/1/0/1/0/1"
                                                                                    },
                                                                                    {
                                                                                      "append": [
                                                                                        {
                                                                                          "tag": [
                                                                                            {
                                                                                              "info": {
                                                                                                "p": "68"
                                                                                              },
                                                                                              "subexprPos": "/1/1/0/1/0/1/0/1"
                                                                                            },
                                                                                            {
                                                                                              "text": "0"
                                                                                            }
                                                                                          ]
                                                                                        },
                                                                                        {
                                                                                          "text": " = "
                                                                                        },
                                                                                        {
                                                                                          "tag": [
                                                                                            {
                                                                                              "info": {
                                                                                                "p": "69"
                                                                                              },
                                                                                              "subexprPos": "/1/1/0/1/0/1/1"
                                                                                            },
                                                                                            {
                                                                                              "text": "«$x1»"
                                                                                            }
                                                                                          ]
                                                                                        }
                                                                                      ]
                                                                                    }
                                                                                  ]
                                                                                },
                                                                                {
                                                                                  "text": " ∧ "
                                                                                },
                                                                                {
                                                                                  "tag": [
                                                                                    {
                                                                                      "info": {
                                                                                        "p": "70"
                                                                                      },
                                                                                      "subexprPos": "/1/1/0/1/1"
                                                                                    },
                                                                                    {
                                                                                      "append": [
                                                                                        {
                                                                                          "tag": [
                                                                                            {
                                                                                              "info": {
                                                                                                "p": "71"
                                                                                              },
                                                                                              "subexprPos": "/1/1/0/1/1/0/1"
                                                                                            },
                                                                                            {
                                                                                              "text": "2"
                                                                                            }
                                                                                          ]
                                                                                        },
                                                                                        {
                                                                                          "text": " = "
                                                                                        },
                                                                                        {
                                                                                          "tag": [
                                                                                            {
                                                                                              "info": {
                                                                                                "p": "72"
                                                                                              },
                                                                                              "subexprPos": "/1/1/0/1/1/1"
                                                                                            },
                                                                                            {
                                                                                              "text": "«$x2»"
                                                                                            }
                                                                                          ]
                                                                                        }
                                                                                      ]
                                                                                    }
                                                                                  ]
                                                                                }
                                                                              ]
                                                                            }
                                                                          ]
                                                                        },
                                                                        {
                                                                          "text": " ∨\n    "
                                                                        },
                                                                        {
                                                                          "tag": [
                                                                            {
                                                                              "info": {
                                                                                "p": "73"
                                                                              },
                                                                              "subexprPos": "/1/1/1"
                                                                            },
                                                                            {
                                                                              "append": [
                                                                                {
                                                                                  "tag": [
                                                                                    {
                                                                                      "info": {
                                                                                        "p": "74"
                                                                                      },
                                                                                      "subexprPos": "/1/1/1/0/1"
                                                                                    },
                                                                                    {
                                                                                      "append": [
                                                                                        {
                                                                                          "tag": [
                                                                                            {
                                                                                              "info": {
                                                                                                "p": "75"
                                                                                              },
                                                                                              "subexprPos": "/1/1/1/0/1/0/1"
                                                                                            },
                                                                                            {
                                                                                              "append": [
                                                                                                {
                                                                                                  "tag": [
                                                                                                    {
                                                                                                      "info": {
                                                                                                        "p": "76"
                                                                                                      },
                                                                                                      "subexprPos": "/1/1/1/0/1/0/1/0/1"
                                                                                                    },
                                                                                                    {
                                                                                                      "text": "2"
                                                                                                    }
                                                                                                  ]
                                                                                                },
                                                                                                {
                                                                                                  "text": " = "
                                                                                                },
                                                                                                {
                                                                                                  "tag": [
                                                                                                    {
                                                                                                      "info": {
                                                                                                        "p": "77"
                                                                                                      },
                                                                                                      "subexprPos": "/1/1/1/0/1/0/1/1"
                                                                                                    },
                                                                                                    {
                                                                                                      "text": "«$x1»"
                                                                                                    }
                                                                                                  ]
                                                                                                }
                                                                                              ]
                                                                                            }
                                                                                          ]
                                                                                        },
                                                                                        {
                                                                                          "text": " ∧ "
                                                                                        },
                                                                                        {
                                                                                          "tag": [
                                                                                            {
                                                                                              "info": {
                                                                                                "p": "78"
                                                                                              },
                                                                                              "subexprPos": "/1/1/1/0/1/1"
                                                                                            },
                                                                                            {
                                                                                              "append": [
                                                                                                {
                                                                                                  "tag": [
                                                                                                    {
                                                                                                      "info": {
                                                                                                        "p": "79"
                                                                                                      },
                                                                                                      "subexprPos": "/1/1/1/0/1/1/0/1"
                                                                                                    },
                                                                                                    {
                                                                                                      "text": "1"
                                                                                                    }
                                                                                                  ]
                                                                                                },
                                                                                                {
                                                                                                  "text": " = "
                                                                                                },
                                                                                                {
                                                                                                  "tag": [
                                                                                                    {
                                                                                                      "info": {
                                                                                                        "p": "80"
                                                                                                      },
                                                                                                      "subexprPos": "/1/1/1/0/1/1/1"
                                                                                                    },
                                                                                                    {
                                                                                                      "text": "«$x2»"
                                                                                                    }
                                                                                                  ]
                                                                                                }
                                                                                              ]
                                                                                            }
                                                                                          ]
                                                                                        }
                                                                                      ]
                                                                                    }
                                                                                  ]
                                                                                },
                                                                                {
                                                                                  "text": " ∨\n      "
                                                                                },
                                                                                {
                                                                                  "tag": [
                                                                                    {
                                                                                      "info": {
                                                                                        "p": "81"
                                                                                      },
                                                                                      "subexprPos": "/1/1/1/1"
                                                                                    },
                                                                                    {
                                                                                      "append": [
                                                                                        {
                                                                                          "tag": [
                                                                                            {
                                                                                              "info": {
                                                                                                "p": "82"
                                                                                              },
                                                                                              "subexprPos": "/1/1/1/1/0/1"
                                                                                            },
                                                                                            {
                                                                                              "append": [
                                                                                                {
                                                                                                  "tag": [
                                                                                                    {
                                                                                                      "info": {
                                                                                                        "p": "83"
                                                                                                      },
                                                                                                      "subexprPos": "/1/1/1/1/0/1/0/1"
                                                                                                    },
                                                                                                    {
                                                                                                      "append": [
                                                                                                        {
                                                                                                          "tag": [
                                                                                                            {
                                                                                                              "info": {
                                                                                                                "p": "84"
                                                                                                              },
                                                                                                              "subexprPos": "/1/1/1/1/0/1/0/1/0/1"
                                                                                                            },
                                                                                                            {
                                                                                                              "text": "0"
                                                                                                            }
                                                                                                          ]
                                                                                                        },
                                                                                                        {
                                                                                                          "text": " = "
                                                                                                        },
                                                                                                        {
                                                                                                          "tag": [
                                                                                                            {
                                                                                                              "info": {
                                                                                                                "p": "85"
                                                                                                              },
                                                                                                              "subexprPos": "/1/1/1/1/0/1/0/1/1"
                                                                                                            },
                                                                                                            {
                                                                                                              "text": "«$x1»"
                                                                                                            }
                                                                                                          ]
                                                                                                        }
                                                                                                      ]
                                                                                                    }
                                                                                                  ]
                                                                                                },
                                                                                                {
                                                                                                  "text": " ∧ "
                                                                                                },
                                                                                                {
                                                                                                  "tag": [
                                                                                                    {
                                                                                                      "info": {
                                                                                                        "p": "86"
                                                                                                      },
                                                                                                      "subexprPos": "/1/1/1/1/0/1/1"
                                                                                                    },
                                                                                                    {
                                                                                                      "append": [
                                                                                                        {
                                                                                                          "tag": [
                                                                                                            {
                                                                                                              "info": {
                                                                                                                "p": "87"
                                                                                                              },
                                                                                                              "subexprPos": "/1/1/1/1/0/1/1/0/1"
                                                                                                            },
                                                                                                            {
                                                                                                              "text": "0"
                                                                                                            }
                                                                                                          ]
                                                                                                        },
                                                                                                        {
                                                                                                          "text": " = "
                                                                                                        },
                                                                                                        {
                                                                                                          "tag": [
                                                                                                            {
                                                                                                              "info": {
                                                                                                                "p": "88"
                                                                                                              },
                                                                                                              "subexprPos": "/1/1/1/1/0/1/1/1"
                                                                                                            },
                                                                                                            {
                                                                                                              "text": "«$x2»"
                                                                                                            }
                                                                                                          ]
                                                                                                        }
                                                                                                      ]
                                                                                                    }
                                                                                                  ]
                                                                                                }
                                                                                              ]
                                                                                            }
                                                                                          ]
                                                                                        },
                                                                                        {
                                                                                          "text": " ∨ "
                                                                                        },
                                                                                        {
                                                                                          "tag": [
                                                                                            {
                                                                                              "info": {
                                                                                                "p": "89"
                                                                                              },
                                                                                              "subexprPos": "/1/1/1/1/1"
                                                                                            },
                                                                                            {
                                                                                              "append": [
                                                                                                {
                                                                                                  "tag": [
                                                                                                    {
                                                                                                      "info": {
                                                                                                        "p": "90"
                                                                                                      },
                                                                                                      "subexprPos": "/1/1/1/1/1/0/1"
                                                                                                    },
                                                                                                    {
                                                                                                      "append": [
                                                                                                        {
                                                                                                          "tag": [
                                                                                                            {
                                                                                                              "info": {
                                                                                                                "p": "91"
                                                                                                              },
                                                                                                              "subexprPos": "/1/1/1/1/1/0/1/0/1"
                                                                                                            },
                                                                                                            {
                                                                                                              "append": [
                                                                                                                {
                                                                                                                  "tag": [
                                                                                                                    {
                                                                                                                      "info": {
                                                                                                                        "p": "92"
                                                                                                                      },
                                                                                                                      "subexprPos": "/1/1/1/1/1/0/1/0/1/0/1"
                                                                                                                    },
                                                                                                                    {
                                                                                                                      "text": "2"
                                                                                                                    }
                                                                                                                  ]
                                                                                                                },
                                                                                                                {
                                                                                                                  "text": " = "
                                                                                                                },
                                                                                                                {
                                                                                                                  "tag": [
                                                                                                                    {
                                                                                                                      "info": {
                                                                                                                        "p": "93"
                                                                                                                      },
                                                                                                                      "subexprPos": "/1/1/1/1/1/0/1/0/1/1"
                                                                                                                    },
                                                                                                                    {
                                                                                                                      "text": "«$x1»"
                                                                                                                    }
                                                                                                                  ]
                                                                                                                }
                                                                                                              ]
                                                                                                            }
                                                                                                          ]
                                                                                                        },
                                                                                                        {
                                                                                                          "text": " ∧ "
                                                                                                        },
                                                                                                        {
                                                                                                          "tag": [
                                                                                                            {
                                                                                                              "info": {
                                                                                                                "p": "94"
                                                                                                              },
                                                                                                              "subexprPos": "/1/1/1/1/1/0/1/1"
                                                                                                            },
                                                                                                            {
                                                                                                              "append": [
                                                                                                                {
                                                                                                                  "tag": [
                                                                                                                    {
                                                                                                                      "info": {
                                                                                                                        "p": "95"
                                                                                                                      },
                                                                                                                      "subexprPos": "/1/1/1/1/1/0/1/1/0/1"
                                                                                                                    },
                                                                                                                    {
                                                                                                                      "text": "2"
                                                                                                                    }
                                                                                                                  ]
                                                                                                                },
                                                                                                                {
                                                                                                                  "text": " = "
                                                                                                                },
                                                                                                                {
                                                                                                                  "tag": [
                                                                                                                    {
                                                                                                                      "info": {
                                                                                                                        "p": "96"
                                                                                                                      },
                                                                                                                      "subexprPos": "/1/1/1/1/1/0/1/1/1"
                                                                                                                    },
                                                                                                                    {
                                                                                                                      "text": "«$x2»"
                                                                                                                    }
                                                                                                                  ]
                                                                                                                }
                                                                                                              ]
                                                                                                            }
                                                                                                          ]
                                                                                                        }
                                                                                                      ]
                                                                                                    }
                                                                                                  ]
                                                                                                },
                                                                                                {
                                                                                                  "text": " ∨ "
                                                                                                },
                                                                                                {
                                                                                                  "tag": [
                                                                                                    {
                                                                                                      "info": {
                                                                                                        "p": "97"
                                                                                                      },
                                                                                                      "subexprPos": "/1/1/1/1/1/1"
                                                                                                    },
                                                                                                    {
                                                                                                      "append": [
                                                                                                        {
                                                                                                          "tag": [
                                                                                                            {
                                                                                                              "info": {
                                                                                                                "p": "98"
                                                                                                              },
                                                                                                              "subexprPos": "/1/1/1/1/1/1/0/1"
                                                                                                            },
                                                                                                            {
                                                                                                              "append": [
                                                                                                                {
                                                                                                                  "tag": [
                                                                                                                    {
                                                                                                                      "info": {
                                                                                                                        "p": "99"
                                                                                                                      },
                                                                                                                      "subexprPos": "/1/1/1/1/1/1/0/1/0/1"
                                                                                                                    },
                                                                                                                    {
                                                                                                                      "append": [
                                                                                                                        {
                                                                                                                          "tag": [
                                                                                                                            {
                                                                                                                              "info": {
                                                                                                                                "p": "100"
                                                                                                                              },
                                                                                                                              "subexprPos": "/1/1/1/1/1/1/0/1/0/1/0/1"
                                                                                                                            },
                                                                                                                            {
                                                                                                                              "text": "0"
                                                                                                                            }
                                                                                                                          ]
                                                                                                                        },
                                                                                                                        {
                                                                                                                          "text": " = "
                                                                                                                        },
                                                                                                                        {
                                                                                                                          "tag": [
                                                                                                                            {
                                                                                                                              "info": {
                                                                                                                                "p": "101"
                                                                                                                              },
                                                                                                                              "subexprPos": "/1/1/1/1/1/1/0/1/0/1/1"
                                                                                                                            },
                                                                                                                            {
                                                                                                                              "text": "«$x1»"
                                                                                                                            }
                                                                                                                          ]
                                                                                                                        }
                                                                                                                      ]
                                                                                                                    }
                                                                                                                  ]
                                                                                                                },
                                                                                                                {
                                                                                                                  "text": " ∧ "
                                                                                                                },
                                                                                                                {
                                                                                                                  "tag": [
                                                                                                                    {
                                                                                                                      "info": {
                                                                                                                        "p": "102"
                                                                                                                      },
                                                                                                                      "subexprPos": "/1/1/1/1/1/1/0/1/1"
                                                                                                                    },
                                                                                                                    {
                                                                                                                      "append": [
                                                                                                                        {
                                                                                                                          "tag": [
                                                                                                                            {
                                                                                                                              "info": {
                                                                                                                                "p": "103"
                                                                                                                              },
                                                                                                                              "subexprPos": "/1/1/1/1/1/1/0/1/1/0/1"
                                                                                                                            },
                                                                                                                            {
                                                                                                                              "text": "1"
                                                                                                                            }
                                                                                                                          ]
                                                                                                                        },
                                                                                                                        {
                                                                                                                          "text": " = "
                                                                                                                        },
                                                                                                                        {
                                                                                                                          "tag": [
                                                                                                                            {
                                                                                                                              "info": {
                                                                                                                                "p": "104"
                                                                                                                              },
                                                                                                                              "subexprPos": "/1/1/1/1/1/1/0/1/1/1"
                                                                                                                            },
                                                                                                                            {
                                                                                                                              "text": "«$x2»"
                                                                                                                            }
                                                                                                                          ]
                                                                                                                        }
                                                                                                                      ]
                                                                                                                    }
                                                                                                                  ]
                                                                                                                }
                                                                                                              ]
                                                                                                            }
                                                                                                          ]
                                                                                                        },
                                                                                                        {
                                                                                                          "text": " ∨ "
                                                                                                        },
                                                                                                        {
                                                                                                          "tag": [
                                                                                                            {
                                                                                                              "info": {
                                                                                                                "p": "105"
                                                                                                              },
                                                                                                              "subexprPos": "/1/1/1/1/1/1/1"
                                                                                                            },
                                                                                                            {
                                                                                                              "append": [
                                                                                                                {
                                                                                                                  "tag": [
                                                                                                                    {
                                                                                                                      "info": {
                                                                                                                        "p": "106"
                                                                                                                      },
                                                                                                                      "subexprPos": "/1/1/1/1/1/1/1/0/1"
                                                                                                                    },
                                                                                                                    {
                                                                                                                      "append": [
                                                                                                                        {
                                                                                                                          "tag": [
                                                                                                                            {
                                                                                                                              "info": {
                                                                                                                                "p": "107"
                                                                                                                              },
                                                                                                                              "subexprPos": "/1/1/1/1/1/1/1/0/1/0/1"
                                                                                                                            },
                                                                                                                            {
                                                                                                                              "text": "1"
                                                                                                                            }
                                                                                                                          ]
                                                                                                                        },
                                                                                                                        {
                                                                                                                          "text": " = "
                                                                                                                        },
                                                                                                                        {
                                                                                                                          "tag": [
                                                                                                                            {
                                                                                                                              "info": {
                                                                                                                                "p": "108"
                                                                                                                              },
                                                                                                                              "subexprPos": "/1/1/1/1/1/1/1/0/1/1"
                                                                                                                            },
                                                                                                                            {
                                                                                                                              "text": "«$x1»"
                                                                                                                            }
                                                                                                                          ]
                                                                                                                        }
                                                                                                                      ]
                                                                                                                    }
                                                                                                                  ]
                                                                                                                },
                                                                                                                {
                                                                                                                  "text": " ∧ "
                                                                                                                },
                                                                                                                {
                                                                                                                  "tag": [
                                                                                                                    {
                                                                                                                      "info": {
                                                                                                                        "p": "109"
                                                                                                                      },
                                                                                                                      "subexprPos": "/1/1/1/1/1/1/1/1"
                                                                                                                    },
                                                                                                                    {
                                                                                                                      "append": [
                                                                                                                        {
                                                                                                                          "tag": [
                                                                                                                            {
                                                                                                                              "info": {
                                                                                                                                "p": "110"
                                                                                                                              },
                                                                                                                              "subexprPos": "/1/1/1/1/1/1/1/1/0/1"
                                                                                                                            },
                                                                                                                            {
                                                                                                                              "text": "1"
                                                                                                                            }
                                                                                                                          ]
                                                                                                                        },
                                                                                                                        {
                                                                                                                          "text": " = "
                                                                                                                        },
                                                                                                                        {
                                                                                                                          "tag": [
                                                                                                                            {
                                                                                                                              "info": {
                                                                                                                                "p": "111"
                                                                                                                              },
                                                                                                                              "subexprPos": "/1/1/1/1/1/1/1/1/1"
                                                                                                                            },
                                                                                                                            {
                                                                                                                              "text": "«$x2»"
                                                                                                                            }
                                                                                                                          ]
                                                                                                                        }
                                                                                                                      ]
                                                                                                                    }
                                                                                                                  ]
                                                                                                                }
                                                                                                              ]
                                                                                                            }
                                                                                                          ]
                                                                                                        }
                                                                                                      ]
                                                                                                    }
                                                                                                  ]
                                                                                                }
                                                                                              ]
                                                                                            }
                                                                                          ]
                                                                                        }
                                                                                      ]
                                                                                    }
                                                                                  ]
                                                                                }
                                                                              ]
                                                                            }
                                                                          ]
                                                                        }
                                                                      ]
                                                                    }
                                                                  ]
                                                                }
                                                              ]
                                                            }
                                                          ]
                                                        }
                                                      },
                                                      []
                                                    ]
                                                  }
                                                ]
                                              ]
                                            }
                                          ]
                                        ]
                                      },
                                      {
                                        "element": [
                                          "tr",
                                          [],
                                          [
                                            {
                                              "element": [
                                                "td",
                                                [],
                                                [
                                                  {
                                                    "component": [
                                                      "11582378131819853457",
                                                      "default",
                                                      {
                                                        "expr": {
                                                          "p": "112"
                                                        }
                                                      },
                                                      []
                                                    ]
                                                  }
                                                ]
                                              ]
                                            },
                                            {
                                              "element": [
                                                "td",
                                                [],
                                                [
                                                  {
                                                    "component": [
                                                      "1305683135076217222",
                                                      "default",
                                                      {
                                                        "fmt": {
                                                          "tag": [
                                                            {
                                                              "info": {
                                                                "p": "113"
                                                              },
                                                              "subexprPos": "/"
                                                            },
                                                            {
                                                              "append": [
                                                                {
                                                                  "text": "fun "
                                                                },
                                                                {
                                                                  "tag": [
                                                                    {
                                                                      "info": {
                                                                        "p": "114"
                                                                      },
                                                                      "subexprPos": "/"
                                                                    },
                                                                    {
                                                                      "text": "«$x1»"
                                                                    }
                                                                  ]
                                                                },
                                                                {
                                                                  "text": " => "
                                                                },
                                                                {
                                                                  "tag": [
                                                                    {
                                                                      "info": {
                                                                        "p": "115"
                                                                      },
                                                                      "subexprPos": "/1"
                                                                    },
                                                                    {
                                                                      "text": "False"
                                                                    }
                                                                  ]
                                                                }
                                                              ]
                                                            }
                                                          ]
                                                        }
                                                      },
                                                      []
                                                    ]
                                                  }
                                                ]
                                              ]
                                            }
                                          ]
                                        ]
                                      },
                                      {
                                        "element": [
                                          "tr",
                                          [],
                                          [
                                            {
                                              "element": [
                                                "td",
                                                [],
                                                [
                                                  {
                                                    "component": [
                                                      "11582378131819853457",
                                                      "default",
                                                      {
                                                        "expr": {
                                                          "p": "116"
                                                        }
                                                      },
                                                      []
                                                    ]
                                                  }
                                                ]
                                              ]
                                            },
                                            {
                                              "element": [
                                                "td",
                                                [],
                                                [
                                                  {
                                                    "component": [
                                                      "1305683135076217222",
                                                      "default",
                                                      {
                                                        "fmt": {
                                                          "tag": [
                                                            {
                                                              "info": {
                                                                "p": "117"
                                                              },
                                                              "subexprPos": "/"
                                                            },
                                                            {
                                                              "text": "False"
                                                            }
                                                          ]
                                                        }
                                                      },
                                                      []
                                                    ]
                                                  }
                                                ]
                                              ]
                                            }
                                          ]
                                        ]
                                      }
                                    ]
                                  ]
                                }
                              ]
                            ]
                          }
                        ]
                      ]
                    },
                    "model": {
                      "sorts": 1,
                      "values": 8
                    }
                  }
                ],
                "kind": "sat"
              },
              "status": "proven",
              "time": 267
            },
            "status": {
              "finished": {
                "res": {
                  "data": {
                    "counterexamples": [
                      {
                        "html": {
                          "element": [
                            "div",
                            [
                              [
                                "className",
                                "font-code"
                              ]
                            ],
                            [
                              {
                                "element": [
                                  "table",
                                  [],
                                  [
                                    {
                                      "element": [
                                        "thead",
                                        [],
                                        [
                                          {
                                            "element": [
                                              "tr",
                                              [],
                                              [
                                                {
                                                  "element": [
                                                    "th",
                                                    [
                                                      [
                                                        "className",
                                                        "counterexample-column-header"
                                                      ]
                                                    ],
                                                    [
                                                      {
                                                        "text": "Sort"
                                                      }
                                                    ]
                                                  ]
                                                },
                                                {
                                                  "element": [
                                                    "th",
                                                    [
                                                      [
                                                        "className",
                                                        "counterexample-column-header"
                                                      ]
                                                    ],
                                                    [
                                                      {
                                                        "text": "Cardinality"
                                                      }
                                                    ]
                                                  ]
                                                }
                                              ]
                                            ]
                                          }
                                        ]
                                      ]
                                    },
                                    {
                                      "element": [
                                        "tbody",
                                        [],
                                        [
                                          {
                                            "element": [
                                              "tr",
                                              [],
                                              [
                                                {
                                                  "element": [
                                                    "td",
                                                    [],
                                                    [
                                                      {
                                                        "component": [
                                                          "11582378131819853457",
                                                          "default",
                                                          {
                                                            "expr": {
                                                              "p": "1"
                                                            }
                                                          },
                                                          []
                                                        ]
                                                      }
                                                    ]
                                                  ]
                                                },
                                                {
                                                  "element": [
                                                    "td",
                                                    [],
                                                    [
                                                      {
                                                        "component": [
                                                          "1305683135076217222",
                                                          "default",
                                                          {
                                                            "fmt": {
                                                              "tag": [
                                                                {
                                                                  "info": {
                                                                    "p": "2"
                                                                  },
                                                                  "subexprPos": "/"
                                                                },
                                                                {
                                                                  "append": [
                                                                    {
                                                                      "text": "Fin "
                                                                    },
                                                                    {
                                                                      "tag": [
                                                                        {
                                                                          "info": {
                                                                            "p": "3"
                                                                          },
                                                                          "subexprPos": "/1"
                                                                        },
                                                                        {
                                                                          "text": "3"
                                                                        }
                                                                      ]
                                                                    }
                                                                  ]
                                                                }
                                                              ]
                                                            }
                                                          },
                                                          []
                                                        ]
                                                      }
                                                    ]
                                                  ]
                                                }
                                              ]
                                            ]
                                          }
                                        ]
                                      ]
                                    },
                                    {
                                      "element": [
                                        "thead",
                                        [],
                                        [
                                          {
                                            "element": [
                                              "tr",
                                              [],
                                              [
                                                {
                                                  "element": [
                                                    "th",
                                                    [
                                                      [
                                                        "className",
                                                        "counterexample-column-header"
                                                      ]
                                                    ],
                                                    [
                                                      {
                                                        "text": "Constant"
                                                      }
                                                    ]
                                                  ]
                                                },
                                                {
                                                  "element": [
                                                    "th",
                                                    [
                                                      [
                                                        "className",
                                                        "counterexample-column-header"
                                                      ]
                                                    ],
                                                    [
                                                      {
                                                        "text": "Value"
                                                      }
                                                    ]
                                                  ]
                                                }
                                              ]
                                            ]
                                          }
                                        ]
                                      ]
                                    },
                                    {
                                      "element": [
                                        "tbody",
                                        [],
                                        [
                                          {
                                            "element": [
                                              "tr",
                                              [],
                                              [
                                                {
                                                  "element": [
                                                    "td",
                                                    [],
                                                    [
                                                      {
                                                        "component": [
                                                          "11582378131819853457",
                                                          "default",
                                                          {
                                                            "expr": {
                                                              "p": "4"
                                                            }
                                                          },
                                                          []
                                                        ]
                                                      }
                                                    ]
                                                  ]
                                                },
                                                {
                                                  "element": [
                                                    "td",
                                                    [],
                                                    [
                                                      {
                                                        "component": [
                                                          "1305683135076217222",
                                                          "default",
                                                          {
                                                            "fmt": {
                                                              "tag": [
                                                                {
                                                                  "info": {
                                                                    "p": "5"
                                                                  },
                                                                  "subexprPos": "/"
                                                                },
                                                                {
                                                                  "text": "0"
                                                                }
                                                              ]
                                                            }
                                                          },
                                                          []
                                                        ]
                                                      }
                                                    ]
                                                  ]
                                                }
                                              ]
                                            ]
                                          },
                                          {
                                            "element": [
                                              "tr",
                                              [],
                                              [
                                                {
                                                  "element": [
                                                    "td",
                                                    [],
                                                    [
                                                      {
                                                        "component": [
                                                          "11582378131819853457",
                                                          "default",
                                                          {
                                                            "expr": {
                                                              "p": "6"
                                                            }
                                                          },
                                                          []
                                                        ]
                                                      }
                                                    ]
                                                  ]
                                                },
                                                {
                                                  "element": [
                                                    "td",
                                                    [],
                                                    [
                                                      {
                                                        "component": [
                                                          "1305683135076217222",
                                                          "default",
                                                          {
                                                            "fmt": {
                                                              "tag": [
                                                                {
                                                                  "info": {
                                                                    "p": "7"
                                                                  },
                                                                  "subexprPos": "/"
                                                                },
                                                                {
                                                                  "text": "2"
                                                                }
                                                              ]
                                                            }
                                                          },
                                                          []
                                                        ]
                                                      }
                                                    ]
                                                  ]
                                                }
                                              ]
                                            ]
                                          },
                                          {
                                            "element": [
                                              "tr",
                                              [],
                                              [
                                                {
                                                  "element": [
                                                    "td",
                                                    [],
                                                    [
                                                      {
                                                        "component": [
                                                          "11582378131819853457",
                                                          "default",
                                                          {
                                                            "expr": {
                                                              "p": "8"
                                                            }
                                                          },
                                                          []
                                                        ]
                                                      }
                                                    ]
                                                  ]
                                                },
                                                {
                                                  "element": [
                                                    "td",
                                                    [],
                                                    [
                                                      {
                                                        "component": [
                                                          "1305683135076217222",
                                                          "default",
                                                          {
                                                            "fmt": {
                                                              "tag": [
                                                                {
                                                                  "info": {
                                                                    "p": "9"
                                                                  },
                                                                  "subexprPos": "/"
                                                                },
                                                                {
                                                                  "append": [
                                                                    {
                                                                      "text": "fun "
                                                                    },
                                                                    {
                                                                      "tag": [
                                                                        {
                                                                          "info": {
                                                                            "p": "10"
                                                                          },
                                                                          "subexprPos": "/"
                                                                        },
                                                                        {
                                                                          "text": "«$x1»"
                                                                        }
                                                                      ]
                                                                    },
                                                                    {
                                                                      "text": " "
                                                                    },
                                                                    {
                                                                      "tag": [
                                                                        {
                                                                          "info": {
                                                                            "p": "11"
                                                                          },
                                                                          "subexprPos": "/"
                                                                        },
                                                                        {
                                                                          "text": "«$x2»"
                                                                        }
                                                                      ]
                                                                    },
                                                                    {
                                                                      "text": " => "
                                                                    },
                                                                    {
                                                                      "tag": [
                                                                        {
                                                                          "info": {
                                                                            "p": "12"
                                                                          },
                                                                          "subexprPos": "/1/1"
                                                                        },
                                                                        {
                                                                          "append": [
                                                                            {
                                                                              "tag": [
                                                                                {
                                                                                  "info": {
                                                                                    "p": "13"
                                                                                  },
                                                                                  "subexprPos": "/1/1/0/1"
                                                                                },
                                                                                {
                                                                                  "append": [
                                                                                    {
                                                                                      "tag": [
                                                                                        {
                                                                                          "info": {
                                                                                            "p": "14"
                                                                                          },
                                                                                          "subexprPos": "/1/1/0/1/0/1"
                                                                                        },
                                                                                        {
                                                                                          "text": "2"
                                                                                        }
                                                                                      ]
                                                                                    },
                                                                                    {
                                                                                      "text": " = "
                                                                                    },
                                                                                    {
                                                                                      "tag": [
                                                                                        {
                                                                                          "info": {
                                                                                            "p": "15"
                                                                                          },
                                                                                          "subexprPos": "/1/1/0/1/1"
                                                                                        },
                                                                                        {
                                                                                          "text": "«$x1»"
                                                                                        }
                                                                                      ]
                                                                                    }
                                                                                  ]
                                                                                }
                                                                              ]
                                                                            },
                                                                            {
                                                                              "text": " ∧ "
                                                                            },
                                                                            {
                                                                              "tag": [
                                                                                {
                                                                                  "info": {
                                                                                    "p": "16"
                                                                                  },
                                                                                  "subexprPos": "/1/1/1"
                                                                                },
                                                                                {
                                                                                  "append": [
                                                                                    {
                                                                                      "tag": [
                                                                                        {
                                                                                          "info": {
                                                                                            "p": "17"
                                                                                          },
                                                                                          "subexprPos": "/1/1/1/0/1"
                                                                                        },
                                                                                        {
                                                                                          "text": "0"
                                                                                        }
                                                                                      ]
                                                                                    },
                                                                                    {
                                                                                      "text": " = "
                                                                                    },
                                                                                    {
                                                                                      "tag": [
                                                                                        {
                                                                                          "info": {
                                                                                            "p": "18"
                                                                                          },
                                                                                          "subexprPos": "/1/1/1/1"
                                                                                        },
                                                                                        {
                                                                                          "text": "«$x2»"
                                                                                        }
                                                                                      ]
                                                                                    }
                                                                                  ]
                                                                                }
                                                                              ]
                                                                            }
                                                                          ]
                                                                        }
                                                                      ]
                                                                    }
                                                                  ]
                                                                }
                                                              ]
                                                            }
                                                          },
                                                          []
                                                        ]
                                                      }
                                                    ]
                                                  ]
                                                }
                                              ]
                                            ]
                                          },
                                          {
                                            "element": [
                                              "tr",
                                              [],
                                              [
                                                {
                                                  "element": [
                                                    "td",
                                                    [],
                                                    [
                                                      {
                                                        "component": [
                                                          "11582378131819853457",
                                                          "default",
                                                          {
                                                            "expr": {
                                                              "p": "19"
                                                            }
                                                          },
                                                          []
                                                        ]
                                                      }
                                                    ]
                                                  ]
                                                },
                                                {
                                                  "element": [
                                                    "td",
                                                    [],
                                                    [
                                                      {
                                                        "component": [
                                                          "1305683135076217222",
                                                          "default",
                                                          {
                                                            "fmt": {
                                                              "tag": [
                                                                {
                                                                  "info": {
                                                                    "p": "20"
                                                                  },
                                                                  "subexprPos": "/"
                                                                },
                                                                {
                                                                  "append": [
                                                                    {
                                                                      "text": "fun "
                                                                    },
                                                                    {
                                                                      "tag": [
                                                                        {
                                                                          "info": {
                                                                            "p": "21"
                                                                          },
                                                                          "subexprPos": "/"
                                                                        },
                                                                        {
                                                                          "text": "«$x1»"
                                                                        }
                                                                      ]
                                                                    },
                                                                    {
                                                                      "text": " "
                                                                    },
                                                                    {
                                                                      "tag": [
                                                                        {
                                                                          "info": {
                                                                            "p": "22"
                                                                          },
                                                                          "subexprPos": "/"
                                                                        },
                                                                        {
                                                                          "text": "«$x2»"
                                                                        }
                                                                      ]
                                                                    },
                                                                    {
                                                                      "text": " "
                                                                    },
                                                                    {
                                                                      "tag": [
                                                                        {
                                                                          "info": {
                                                                            "p": "23"
                                                                          },
                                                                          "subexprPos": "/0"
                                                                        },
                                                                        {
                                                                          "text": "«$x3»"
                                                                        }
                                                                      ]
                                                                    },
                                                                    {
                                                                      "text": " =>\n  "
                                                                    },
                                                                    {
                                                                      "tag": [
                                                                        {
                                                                          "info": {
                                                                            "p": "24"
                                                                          },
                                                                          "subexprPos": "/1/1/1"
                                                                        },
                                                                        {
                                                                          "append": [
                                                                            {
                                                                              "tag": [
                                                                                {
                                                                                  "info": {
                                                                                    "p": "25"
                                                                                  },
                                                                                  "subexprPos": "/1/1/1/0/1"
                                                                                },
                                                                                {
                                                                                  "append": [
                                                                                    {
                                                                                      "tag": [
                                                                                        {
                                                                                          "info": {
                                                                                            "p": "26"
                                                                                          },
                                                                                          "subexprPos": "/1/1/1/0/1/0/1"
                                                                                        },
                                                                                        {
                                                                                          "append": [
                                                                                            {
                                                                                              "tag": [
                                                                                                {
                                                                                                  "info": {
                                                                                                    "p": "27"
                                                                                                  },
                                                                                                  "subexprPos": "/1/1/1/0/1/0/1/0/1"
                                                                                                },
                                                                                                {
                                                                                                  "text": "0"
                                                                                                }
                                                                                              ]
                                                                                            },
                                                                                            {
                                                                                              "text": " = "
                                                                                            },
                                                                                            {
                                                                                              "tag": [
                                                                                                {
                                                                                                  "info": {
                                                                                                    "p": "28"
                                                                                                  },
                                                                                                  "subexprPos": "/1/1/1/0/1/0/1/1"
                                                                                                },
                                                                                                {
                                                                                                  "text": "«$x1»"
                                                                                                }
                                                                                              ]
                                                                                            }
                                                                                          ]
                                                                                        }
                                                                                      ]
                                                                                    },
                                                                                    {
                                                                                      "text": " ∧ "
                                                                                    },
                                                                                    {
                                                                                      "tag": [
                                                                                        {
                                                                                          "info": {
                                                                                            "p": "29"
                                                                                          },
                                                                                          "subexprPos": "/1/1/1/0/1/1"
                                                                                        },
                                                                                        {
                                                                                          "append": [
                                                                                            {
                                                                                              "tag": [
                                                                                                {
                                                                                                  "info": {
                                                                                                    "p": "30"
                                                                                                  },
                                                                                                  "subexprPos": "/1/1/1/0/1/1/0/1"
                                                                                                },
                                                                                                {
                                                                                                  "append": [
                                                                                                    {
                                                                                                      "tag": [
                                                                                                        {
                                                                                                          "info": {
                                                                                                            "p": "31"
                                                                                                          },
                                                                                                          "subexprPos": "/1/1/1/0/1/1/0/1/0/1"
                                                                                                        },
                                                                                                        {
                                                                                                          "text": "2"
                                                                                                        }
                                                                                                      ]
                                                                                                    },
                                                                                                    {
                                                                                                      "text": " = "
                                                                                                    },
                                                                                                    {
                                                                                                      "tag": [
                                                                                                        {
                                                                                                          "info": {
                                                                                                            "p": "32"
                                                                                                          },
                                                                                                          "subexprPos": "/1/1/1/0/1/1/0/1/1"
                                                                                                        },
                                                                                                        {
                                                                                                          "text": "«$x2»"
                                                                                                        }
                                                                                                      ]
                                                                                                    }
                                                                                                  ]
                                                                                                }
                                                                                              ]
                                                                                            },
                                                                                            {
                                                                                              "text": " ∧ "
                                                                                            },
                                                                                            {
                                                                                              "tag": [
                                                                                                {
                                                                                                  "info": {
                                                                                                    "p": "33"
                                                                                                  },
                                                                                                  "subexprPos": "/1/1/1/0/1/1/1"
                                                                                                },
                                                                                                {
                                                                                                  "append": [
                                                                                                    {
                                                                                                      "tag": [
                                                                                                        {
                                                                                                          "info": {
                                                                                                            "p": "34"
                                                                                                          },
                                                                                                          "subexprPos": "/1/1/1/0/1/1/1/0/1"
                                                                                                        },
                                                                                                        {
                                                                                                          "text": "1"
                                                                                                        }
                                                                                                      ]
                                                                                                    },
                                                                                                    {
                                                                                                      "text": " = "
                                                                                                    },
                                                                                                    {
                                                                                                      "tag": [
                                                                                                        {
                                                                                                          "info": {
                                                                                                            "p": "35"
                                                                                                          },
                                                                                                          "subexprPos": "/1/1/1/0/1/1/1/1"
                                                                                                        },
                                                                                                        {
                                                                                                          "text": "«$x3»"
                                                                                                        }
                                                                                                      ]
                                                                                                    }
                                                                                                  ]
                                                                                                }
                                                                                              ]
                                                                                            }
                                                                                          ]
                                                                                        }
                                                                                      ]
                                                                                    }
                                                                                  ]
                                                                                }
                                                                              ]
                                                                            },
                                                                            {
                                                                              "text": " ∨ "
                                                                            },
                                                                            {
                                                                              "tag": [
                                                                                {
                                                                                  "info": {
                                                                                    "p": "36"
                                                                                  },
                                                                                  "subexprPos": "/1/1/1/1"
                                                                                },
                                                                                {
                                                                                  "append": [
                                                                                    {
                                                                                      "tag": [
                                                                                        {
                                                                                          "info": {
                                                                                            "p": "37"
                                                                                          },
                                                                                          "subexprPos": "/1/1/1/1/0/1"
                                                                                        },
                                                                                        {
                                                                                          "append": [
                                                                                            {
                                                                                              "tag": [
                                                                                                {
                                                                                                  "info": {
                                                                                                    "p": "38"
                                                                                                  },
                                                                                                  "subexprPos": "/1/1/1/1/0/1/0/1"
                                                                                                },
                                                                                                {
                                                                                                  "append": [
                                                                                                    {
                                                                                                      "tag": [
                                                                                                        {
                                                                                                          "info": {
                                                                                                            "p": "39"
                                                                                                          },
                                                                                                          "subexprPos": "/1/1/1/1/0/1/0/1/0/1"
                                                                                                        },
                                                                                                        {
                                                                                                          "text": "2"
                                                                                                        }
                                                                                                      ]
                                                                                                    },
                                                                                                    {
                                                                                                      "text": " = "
                                                                                                    },
                                                                                                    {
                                                                                                      "tag": [
                                                                                                        {
                                                                                                          "info": {
                                                                                                            "p": "40"
                                                                                                          },
                                                                                                          "subexprPos": "/1/1/1/1/0/1/0/1/1"
                                                                                                        },
                                                                                                        {
                                                                                                          "text": "«$x1»"
                                                                                                        }
                                                                                                      ]
                                                                                                    }
                                                                                                  ]
                                                                                                }
                                                                                              ]
                                                                                            },
                                                                                            {
                                                                                              "text": " ∧ "
                                                                                            },
                                                                                            {
                                                                                              "tag": [
                                                                                                {
                                                                                                  "info": {
                                                                                                    "p": "41"
                                                                                                  },
                                                                                                  "subexprPos": "/1/1/1/1/0/1/1"
                                                                                                },
                                                                                                {
                                                                                                  "append": [
                                                                                                    {
                                                                                                      "tag": [
                                                                                                        {
                                                                                                          "info": {
                                                                                                            "p": "42"
                                                                                                          },
                                                                                                          "subexprPos": "/1/1/1/1/0/1/1/0/1"
                                                                                                        },
                                                                                                        {
                                                                                                          "append": [
                                                                                                            {
                                                                                                              "tag": [
                                                                                                                {
                                                                                                                  "info": {
                                                                                                                    "p": "43"
                                                                                                                  },
                                                                                                                  "subexprPos": "/1/1/1/1/0/1/1/0/1/0/1"
                                                                                                                },
                                                                                                                {
                                                                                                                  "text": "1"
                                                                                                                }
                                                                                                              ]
                                                                                                            },
                                                                                                            {
                                                                                                              "text": " = "
                                                                                                            },
                                                                                                            {
                                                                                                              "tag": [
                                                                                                                {
                                                                                                                  "info": {
                                                                                                                    "p": "44"
                                                                                                                  },
                                                                                                                  "subexprPos": "/1/1/1/1/0/1/1/0/1/1"
                                                                                                                },
                                                                                                                {
                                                                                                                  "text": "«$x2»"
                                                                                                                }
                                                                                                              ]
                                                                                                            }
                                                                                                          ]
                                                                                                        }
                                                                                                      ]
                                                                                                    },
                                                                                                    {
                                                                                                      "text": " ∧ "
                                                                                                    },
                                                                                                    {
                                                                                                      "tag": [
                                                                                                        {
                                                                                                          "info": {
                                                                                                            "p": "45"
                                                                                                          },
                                                                                                          "subexprPos": "/1/1/1/1/0/1/1/1"
                                                                                                        },
                                                                                                        {
                                                                                                          "append": [
                                                                                                            {
                                                                                                              "tag": [
                                                                                                                {
                                                                                                                  "info": {
                                                                                                                    "p": "46"
                                                                                                                  },
                                                                                                                  "subexprPos": "/1/1/1/1/0/1/1/1/0/1"
                                                                                                                },
                                                                                                                {
                                                                                                                  "text": "0"
                                                                                                                }
                                                                                                              ]
                                                                                                            },
                                                                                                            {
                                                                                                              "text": " = "
                                                                                                            },
                                                                                                            {
                                                                                                              "tag": [
                                                                                                                {
                                                                                                                  "info": {
                                                                                                                    "p": "47"
                                                                                                                  },
                                                                                                                  "subexprPos": "/1/1/1/1/0/1/1/1/1"
                                                                                                                },
                                                                                                                {
                                                                                                                  "text": "«$x3»"
                                                                                                                }
                                                                                                              ]
                                                                                                            }
                                                                                                          ]
                                                                                                        }
                                                                                                      ]
                                                                                                    }
                                                                                                  ]
                                                                                                }
                                                                                              ]
                                                                                            }
                                                                                          ]
                                                                                        }
                                                                                      ]
                                                                                    },
                                                                                    {
                                                                                      "text": " ∨ "
                                                                                    },
                                                                                    {
                                                                                      "tag": [
                                                                                        {
                                                                                          "info": {
                                                                                            "p": "48"
                                                                                          },
                                                                                          "subexprPos": "/1/1/1/1/1"
                                                                                        },
                                                                                        {
                                                                                          "append": [
                                                                                            {
                                                                                              "tag": [
                                                                                                {
                                                                                                  "info": {
                                                                                                    "p": "49"
                                                                                                  },
                                                                                                  "subexprPos": "/1/1/1/1/1/0/1"
                                                                                                },
                                                                                                {
                                                                                                  "append": [
                                                                                                    {
                                                                                                      "tag": [
                                                                                                        {
                                                                                                          "info": {
                                                                                                            "p": "50"
                                                                                                          },
                                                                                                          "subexprPos": "/1/1/1/1/1/0/1/0/1"
                                                                                                        },
                                                                                                        {
                                                                                                          "text": "1"
                                                                                                        }
                                                                                                      ]
                                                                                                    },
                                                                                                    {
                                                                                                      "text": " = "
                                                                                                    },
                                                                                                    {
                                                                                                      "tag": [
                                                                                                        {
                                                                                                          "info": {
                                                                                                            "p": "51"
                                                                                                          },
                                                                                                          "subexprPos": "/1/1/1/1/1/0/1/1"
                                                                                                        },
                                                                                                        {
                                                                                                          "text": "«$x1»"
                                                                                                        }
                                                                                                      ]
                                                                                                    }
                                                                                                  ]
                                                                                                }
                                                                                              ]
                                                                                            },
                                                                                            {
                                                                                              "text": " ∧ "
                                                                                            },
                                                                                            {
                                                                                              "tag": [
                                                                                                {
                                                                                                  "info": {
                                                                                                    "p": "52"
                                                                                                  },
                                                                                                  "subexprPos": "/1/1/1/1/1/1"
                                                                                                },
                                                                                                {
                                                                                                  "append": [
                                                                                                    {
                                                                                                      "tag": [
                                                                                                        {
                                                                                                          "info": {
                                                                                                            "p": "53"
                                                                                                          },
                                                                                                          "subexprPos": "/1/1/1/1/1/1/0/1"
                                                                                                        },
                                                                                                        {
                                                                                                          "append": [
                                                                                                            {
                                                                                                              "tag": [
                                                                                                                {
                                                                                                                  "info": {
                                                                                                                    "p": "54"
                                                                                                                  },
                                                                                                                  "subexprPos": "/1/1/1/1/1/1/0/1/0/1"
                                                                                                                },
                                                                                                                {
                                                                                                                  "text": "0"
                                                                                                                }
                                                                                                              ]
                                                                                                            },
                                                                                                            {
                                                                                                              "text": " = "
                                                                                                            },
                                                                                                            {
                                                                                                              "tag": [
                                                                                                                {
                                                                                                                  "info": {
                                                                                                                    "p": "55"
                                                                                                                  },
                                                                                                                  "subexprPos": "/1/1/1/1/1/1/0/1/1"
                                                                                                                },
                                                                                                                {
                                                                                                                  "text": "«$x2»"
                                                                                                                }
                                                                                                              ]
                                                                                                            }
                                                                                                          ]
                                                                                                        }
                                                                                                      ]
                                                                                                    },
                                                                                                    {
                                                                                                      "text": " ∧ "
                                                                                                    },
                                                                                                    {
                                                                                                      "tag": [
                                                                                                        {
                                                                                                          "info": {
                                                                                                            "p": "56"
                                                                                                          },
                                                                                                          "subexprPos": "/1/1/1/1/1/1/1"
                                                                                                        },
                                                                                                        {
                                                                                                          "append": [
                                                                                                            {
                                                                                                              "tag": [
                                                                                                                {
                                                                                                                  "info": {
                                                                                                                    "p": "57"
                                                                                                                  },
                                                                                                                  "subexprPos": "/1/1/1/1/1/1/1/0/1"
                                                                                                                },
                                                                                                                {
                                                                                                                  "text": "2"
                                                                                                                }
                                                                                                              ]
                                                                                                            },
                                                                                                            {
                                                                                                              "text": " = "
                                                                                                            },
                                                                                                            {
                                                                                                              "tag": [
                                                                                                                {
                                                                                                                  "info": {
                                                                                                                    "p": "58"
                                                                                                                  },
                                                                                                                  "subexprPos": "/1/1/1/1/1/1/1/1"
                                                                                                                },
                                                                                                                {
                                                                                                                  "text": "«$x3»"
                                                                                                                }
                                                                                                              ]
                                                                                                            }
                                                                                                          ]
                                                                                                        }
                                                                                                      ]
                                                                                                    }
                                                                                                  ]
                                                                                                }
                                                                                              ]
                                                                                            }
                                                                                          ]
                                                                                        }
                                                                                      ]
                                                                                    }
                                                                                  ]
                                                                                }
                                                                              ]
                                                                            }
                                                                          ]
                                                                        }
                                                                      ]
                                                                    }
                                                                  ]
                                                                }
                                                              ]
                                                            }
                                                          },
                                                          []
                                                        ]
                                                      }
                                                    ]
                                                  ]
                                                }
                                              ]
                                            ]
                                          },
                                          {
                                            "element": [
                                              "tr",
                                              [],
                                              [
                                                {
                                                  "element": [
                                                    "td",
                                                    [],
                                                    [
                                                      {
                                                        "component": [
                                                          "11582378131819853457",
                                                          "default",
                                                          {
                                                            "expr": {
                                                              "p": "59"
                                                            }
                                                          },
                                                          []
                                                        ]
                                                      }
                                                    ]
                                                  ]
                                                },
                                                {
                                                  "element": [
                                                    "td",
                                                    [],
                                                    [
                                                      {
                                                        "component": [
                                                          "1305683135076217222",
                                                          "default",
                                                          {
                                                            "fmt": {
                                                              "tag": [
                                                                {
                                                                  "info": {
                                                                    "p": "60"
                                                                  },
                                                                  "subexprPos": "/"
                                                                },
                                                                {
                                                                  "text": "2"
                                                                }
                                                              ]
                                                            }
                                                          },
                                                          []
                                                        ]
                                                      }
                                                    ]
                                                  ]
                                                }
                                              ]
                                            ]
                                          },
                                          {
                                            "element": [
                                              "tr",
                                              [],
                                              [
                                                {
                                                  "element": [
                                                    "td",
                                                    [],
                                                    [
                                                      {
                                                        "component": [
                                                          "11582378131819853457",
                                                          "default",
                                                          {
                                                            "expr": {
                                                              "p": "61"
                                                            }
                                                          },
                                                          []
                                                        ]
                                                      }
                                                    ]
                                                  ]
                                                },
                                                {
                                                  "element": [
                                                    "td",
                                                    [],
                                                    [
                                                      {
                                                        "component": [
                                                          "1305683135076217222",
                                                          "default",
                                                          {
                                                            "fmt": {
                                                              "tag": [
                                                                {
                                                                  "info": {
                                                                    "p": "62"
                                                                  },
                                                                  "subexprPos": "/"
                                                                },
                                                                {
                                                                  "append": [
                                                                    {
                                                                      "text": "fun "
                                                                    },
                                                                    {
                                                                      "tag": [
                                                                        {
                                                                          "info": {
                                                                            "p": "63"
                                                                          },
                                                                          "subexprPos": "/"
                                                                        },
                                                                        {
                                                                          "text": "«$x1»"
                                                                        }
                                                                      ]
                                                                    },
                                                                    {
                                                                      "text": " "
                                                                    },
                                                                    {
                                                                      "tag": [
                                                                        {
                                                                          "info": {
                                                                            "p": "64"
                                                                          },
                                                                          "subexprPos": "/"
                                                                        },
                                                                        {
                                                                          "text": "«$x2»"
                                                                        }
                                                                      ]
                                                                    },
                                                                    {
                                                                      "text": " =>\n  "
                                                                    },
                                                                    {
                                                                      "tag": [
                                                                        {
                                                                          "info": {
                                                                            "p": "65"
                                                                          },
                                                                          "subexprPos": "/1/1"
                                                                        },
                                                                        {
                                                                          "append": [
                                                                            {
                                                                              "tag": [
                                                                                {
                                                                                  "info": {
                                                                                    "p": "66"
                                                                                  },
                                                                                  "subexprPos": "/1/1/0/1"
                                                                                },
                                                                                {
                                                                                  "append": [
                                                                                    {
                                                                                      "tag": [
                                                                                        {
                                                                                          "info": {
                                                                                            "p": "67"
                                                                                          },
                                                                                          "subexprPos": "/1/1/0/1/0/1"
                                                                                        },
                                                                                        {
                                                                                          "append": [
                                                                                            {
                                                                                              "tag": [
                                                                                                {
                                                                                                  "info": {
                                                                                                    "p": "68"
                                                                                                  },
                                                                                                  "subexprPos": "/1/1/0/1/0/1/0/1"
                                                                                                },
                                                                                                {
                                                                                                  "text": "0"
                                                                                                }
                                                                                              ]
                                                                                            },
                                                                                            {
                                                                                              "text": " = "
                                                                                            },
                                                                                            {
                                                                                              "tag": [
                                                                                                {
                                                                                                  "info": {
                                                                                                    "p": "69"
                                                                                                  },
                                                                                                  "subexprPos": "/1/1/0/1/0/1/1"
                                                                                                },
                                                                                                {
                                                                                                  "text": "«$x1»"
                                                                                                }
                                                                                              ]
                                                                                            }
                                                                                          ]
                                                                                        }
                                                                                      ]
                                                                                    },
                                                                                    {
                                                                                      "text": " ∧ "
                                                                                    },
                                                                                    {
                                                                                      "tag": [
                                                                                        {
                                                                                          "info": {
                                                                                            "p": "70"
                                                                                          },
                                                                                          "subexprPos": "/1/1/0/1/1"
                                                                                        },
                                                                                        {
                                                                                          "append": [
                                                                                            {
                                                                                              "tag": [
                                                                                                {
                                                                                                  "info": {
                                                                                                    "p": "71"
                                                                                                  },
                                                                                                  "subexprPos": "/1/1/0/1/1/0/1"
                                                                                                },
                                                                                                {
                                                                                                  "text": "2"
                                                                                                }
                                                                                              ]
                                                                                            },
                                                                                            {
                                                                                              "text": " = "
                                                                                            },
                                                                                            {
                                                                                              "tag": [
                                                                                                {
                                                                                                  "info": {
                                                                                                    "p": "72"
                                                                                                  },
                                                                                                  "subexprPos": "/1/1/0/1/1/1"
                                                                                                },
                                                                                                {
                                                                                                  "text": "«$x2»"
                                                                                                }
                                                                                              ]
                                                                                            }
                                                                                          ]
                                                                                        }
                                                                                      ]
                                                                                    }
                                                                                  ]
                                                                                }
                                                                              ]
                                                                            },
                                                                            {
                                                                              "text": " ∨\n    "
                                                                            },
                                                                            {
                                                                              "tag": [
                                                                                {
                                                                                  "info": {
                                                                                    "p": "73"
                                                                                  },
                                                                                  "subexprPos": "/1/1/1"
                                                                                },
                                                                                {
                                                                                  "append": [
                                                                                    {
                                                                                      "tag": [
                                                                                        {
                                                                                          "info": {
                                                                                            "p": "74"
                                                                                          },
                                                                                          "subexprPos": "/1/1/1/0/1"
                                                                                        },
                                                                                        {
                                                                                          "append": [
                                                                                            {
                                                                                              "tag": [
                                                                                                {
                                                                                                  "info": {
                                                                                                    "p": "75"
                                                                                                  },
                                                                                                  "subexprPos": "/1/1/1/0/1/0/1"
                                                                                                },
                                                                                                {
                                                                                                  "append": [
                                                                                                    {
                                                                                                      "tag": [
                                                                                                        {
                                                                                                          "info": {
                                                                                                            "p": "76"
                                                                                                          },
                                                                                                          "subexprPos": "/1/1/1/0/1/0/1/0/1"
                                                                                                        },
                                                                                                        {
                                                                                                          "text": "2"
                                                                                                        }
                                                                                                      ]
                                                                                                    },
                                                                                                    {
                                                                                                      "text": " = "
                                                                                                    },
                                                                                                    {
                                                                                                      "tag": [
                                                                                                        {
                                                                                                          "info": {
                                                                                                            "p": "77"
                                                                                                          },
                                                                                                          "subexprPos": "/1/1/1/0/1/0/1/1"
                                                                                                        },
                                                                                                        {
                                                                                                          "text": "«$x1»"
                                                                                                        }
                                                                                                      ]
                                                                                                    }
                                                                                                  ]
                                                                                                }
                                                                                              ]
                                                                                            },
                                                                                            {
                                                                                              "text": " ∧ "
                                                                                            },
                                                                                            {
                                                                                              "tag": [
                                                                                                {
                                                                                                  "info": {
                                                                                                    "p": "78"
                                                                                                  },
                                                                                                  "subexprPos": "/1/1/1/0/1/1"
                                                                                                },
                                                                                                {
                                                                                                  "append": [
                                                                                                    {
                                                                                                      "tag": [
                                                                                                        {
                                                                                                          "info": {
                                                                                                            "p": "79"
                                                                                                          },
                                                                                                          "subexprPos": "/1/1/1/0/1/1/0/1"
                                                                                                        },
                                                                                                        {
                                                                                                          "text": "1"
                                                                                                        }
                                                                                                      ]
                                                                                                    },
                                                                                                    {
                                                                                                      "text": " = "
                                                                                                    },
                                                                                                    {
                                                                                                      "tag": [
                                                                                                        {
                                                                                                          "info": {
                                                                                                            "p": "80"
                                                                                                          },
                                                                                                          "subexprPos": "/1/1/1/0/1/1/1"
                                                                                                        },
                                                                                                        {
                                                                                                          "text": "«$x2»"
                                                                                                        }
                                                                                                      ]
                                                                                                    }
                                                                                                  ]
                                                                                                }
                                                                                              ]
                                                                                            }
                                                                                          ]
                                                                                        }
                                                                                      ]
                                                                                    },
                                                                                    {
                                                                                      "text": " ∨\n      "
                                                                                    },
                                                                                    {
                                                                                      "tag": [
                                                                                        {
                                                                                          "info": {
                                                                                            "p": "81"
                                                                                          },
                                                                                          "subexprPos": "/1/1/1/1"
                                                                                        },
                                                                                        {
                                                                                          "append": [
                                                                                            {
                                                                                              "tag": [
                                                                                                {
                                                                                                  "info": {
                                                                                                    "p": "82"
                                                                                                  },
                                                                                                  "subexprPos": "/1/1/1/1/0/1"
                                                                                                },
                                                                                                {
                                                                                                  "append": [
                                                                                                    {
                                                                                                      "tag": [
                                                                                                        {
                                                                                                          "info": {
                                                                                                            "p": "83"
                                                                                                          },
                                                                                                          "subexprPos": "/1/1/1/1/0/1/0/1"
                                                                                                        },
                                                                                                        {
                                                                                                          "append": [
                                                                                                            {
                                                                                                              "tag": [
                                                                                                                {
                                                                                                                  "info": {
                                                                                                                    "p": "84"
                                                                                                                  },
                                                                                                                  "subexprPos": "/1/1/1/1/0/1/0/1/0/1"
                                                                                                                },
                                                                                                                {
                                                                                                                  "text": "0"
                                                                                                                }
                                                                                                              ]
                                                                                                            },
                                                                                                            {
                                                                                                              "text": " = "
                                                                                                            },
                                                                                                            {
                                                                                                              "tag": [
                                                                                                                {
                                                                                                                  "info": {
                                                                                                                    "p": "85"
                                                                                                                  },
                                                                                                                  "subexprPos": "/1/1/1/1/0/1/0/1/1"
                                                                                                                },
                                                                                                                {
                                                                                                                  "text": "«$x1»"
                                                                                                                }
                                                                                                              ]
                                                                                                            }
                                                                                                          ]
                                                                                                        }
                                                                                                      ]
                                                                                                    },
                                                                                                    {
                                                                                                      "text": " ∧ "
                                                                                                    },
                                                                                                    {
                                                                                                      "tag": [
                                                                                                        {
                                                                                                          "info": {
                                                                                                            "p": "86"
                                                                                                          },
                                                                                                          "subexprPos": "/1/1/1/1/0/1/1"
                                                                                                        },
                                                                                                        {
                                                                                                          "append": [
                                                                                                            {
                                                                                                              "tag": [
                                                                                                                {
                                                                                                                  "info": {
                                                                                                                    "p": "87"
                                                                                                                  },
                                                                                                                  "subexprPos": "/1/1/1/1/0/1/1/0/1"
                                                                                                                },
                                                                                                                {
                                                                                                                  "text": "0"
                                                                                                                }
                                                                                                              ]
                                                                                                            },
                                                                                                            {
                                                                                                              "text": " = "
                                                                                                            },
                                                                                                            {
                                                                                                              "tag": [
                                                                                                                {
                                                                                                                  "info": {
                                                                                                                    "p": "88"
                                                                                                                  },
                                                                                                                  "subexprPos": "/1/1/1/1/0/1/1/1"
                                                                                                                },
                                                                                                                {
                                                                                                                  "text": "«$x2»"
                                                                                                                }
                                                                                                              ]
                                                                                                            }
                                                                                                          ]
                                                                                                        }
                                                                                                      ]
                                                                                                    }
                                                                                                  ]
                                                                                                }
                                                                                              ]
                                                                                            },
                                                                                            {
                                                                                              "text": " ∨ "
                                                                                            },
                                                                                            {
                                                                                              "tag": [
                                                                                                {
                                                                                                  "info": {
                                                                                                    "p": "89"
                                                                                                  },
                                                                                                  "subexprPos": "/1/1/1/1/1"
                                                                                                },
                                                                                                {
                                                                                                  "append": [
                                                                                                    {
                                                                                                      "tag": [
                                                                                                        {
                                                                                                          "info": {
                                                                                                            "p": "90"
                                                                                                          },
                                                                                                          "subexprPos": "/1/1/1/1/1/0/1"
                                                                                                        },
                                                                                                        {
                                                                                                          "append": [
                                                                                                            {
                                                                                                              "tag": [
                                                                                                                {
                                                                                                                  "info": {
                                                                                                                    "p": "91"
                                                                                                                  },
                                                                                                                  "subexprPos": "/1/1/1/1/1/0/1/0/1"
                                                                                                                },
                                                                                                                {
                                                                                                                  "append": [
                                                                                                                    {
                                                                                                                      "tag": [
                                                                                                                        {
                                                                                                                          "info": {
                                                                                                                            "p": "92"
                                                                                                                          },
                                                                                                                          "subexprPos": "/1/1/1/1/1/0/1/0/1/0/1"
                                                                                                                        },
                                                                                                                        {
                                                                                                                          "text": "2"
                                                                                                                        }
                                                                                                                      ]
                                                                                                                    },
                                                                                                                    {
                                                                                                                      "text": " = "
                                                                                                                    },
                                                                                                                    {
                                                                                                                      "tag": [
                                                                                                                        {
                                                                                                                          "info": {
                                                                                                                            "p": "93"
                                                                                                                          },
                                                                                                                          "subexprPos": "/1/1/1/1/1/0/1/0/1/1"
                                                                                                                        },
                                                                                                                        {
                                                                                                                          "text": "«$x1»"
                                                                                                                        }
                                                                                                                      ]
                                                                                                                    }
                                                                                                                  ]
                                                                                                                }
                                                                                                              ]
                                                                                                            },
                                                                                                            {
                                                                                                              "text": " ∧ "
                                                                                                            },
                                                                                                            {
                                                                                                              "tag": [
                                                                                                                {
                                                                                                                  "info": {
                                                                                                                    "p": "94"
                                                                                                                  },
                                                                                                                  "subexprPos": "/1/1/1/1/1/0/1/1"
                                                                                                                },
                                                                                                                {
                                                                                                                  "append": [
                                                                                                                    {
                                                                                                                      "tag": [
                                                                                                                        {
                                                                                                                          "info": {
                                                                                                                            "p": "95"
                                                                                                                          },
                                                                                                                          "subexprPos": "/1/1/1/1/1/0/1/1/0/1"
                                                                                                                        },
                                                                                                                        {
                                                                                                                          "text": "2"
                                                                                                                        }
                                                                                                                      ]
                                                                                                                    },
                                                                                                                    {
                                                                                                                      "text": " = "
                                                                                                                    },
                                                                                                                    {
                                                                                                                      "tag": [
                                                                                                                        {
                                                                                                                          "info": {
                                                                                                                            "p": "96"
                                                                                                                          },
                                                                                                                          "subexprPos": "/1/1/1/1/1/0/1/1/1"
                                                                                                                        },
                                                                                                                        {
                                                                                                                          "text": "«$x2»"
                                                                                                                        }
                                                                                                                      ]
                                                                                                                    }
                                                                                                                  ]
                                                                                                                }
                                                                                                              ]
                                                                                                            }
                                                                                                          ]
                                                                                                        }
                                                                                                      ]
                                                                                                    },
                                                                                                    {
                                                                                                      "text": " ∨ "
                                                                                                    },
                                                                                                    {
                                                                                                      "tag": [
                                                                                                        {
                                                                                                          "info": {
                                                                                                            "p": "97"
                                                                                                          },
                                                                                                          "subexprPos": "/1/1/1/1/1/1"
                                                                                                        },
                                                                                                        {
                                                                                                          "append": [
                                                                                                            {
                                                                                                              "tag": [
                                                                                                                {
                                                                                                                  "info": {
                                                                                                                    "p": "98"
                                                                                                                  },
                                                                                                                  "subexprPos": "/1/1/1/1/1/1/0/1"
                                                                                                                },
                                                                                                                {
                                                                                                                  "append": [
                                                                                                                    {
                                                                                                                      "tag": [
                                                                                                                        {
                                                                                                                          "info": {
                                                                                                                            "p": "99"
                                                                                                                          },
                                                                                                                          "subexprPos": "/1/1/1/1/1/1/0/1/0/1"
                                                                                                                        },
                                                                                                                        {
                                                                                                                          "append": [
                                                                                                                            {
                                                                                                                              "tag": [
                                                                                                                                {
                                                                                                                                  "info": {
                                                                                                                                    "p": "100"
                                                                                                                                  },
                                                                                                                                  "subexprPos": "/1/1/1/1/1/1/0/1/0/1/0/1"
                                                                                                                                },
                                                                                                                                {
                                                                                                                                  "text": "0"
                                                                                                                                }
                                                                                                                              ]
                                                                                                                            },
                                                                                                                            {
                                                                                                                              "text": " = "
                                                                                                                            },
                                                                                                                            {
                                                                                                                              "tag": [
                                                                                                                                {
                                                                                                                                  "info": {
                                                                                                                                    "p": "101"
                                                                                                                                  },
                                                                                                                                  "subexprPos": "/1/1/1/1/1/1/0/1/0/1/1"
                                                                                                                                },
                                                                                                                                {
                                                                                                                                  "text": "«$x1»"
                                                                                                                                }
                                                                                                                              ]
                                                                                                                            }
                                                                                                                          ]
                                                                                                                        }
                                                                                                                      ]
                                                                                                                    },
                                                                                                                    {
                                                                                                                      "text": " ∧ "
                                                                                                                    },
                                                                                                                    {
                                                                                                                      "tag": [
                                                                                                                        {
                                                                                                                          "info": {
                                                                                                                            "p": "102"
                                                                                                                          },
                                                                                                                          "subexprPos": "/1/1/1/1/1/1/0/1/1"
                                                                                                                        },
                                                                                                                        {
                                                                                                                          "append": [
                                                                                                                            {
                                                                                                                              "tag": [
                                                                                                                                {
                                                                                                                                  "info": {
                                                                                                                                    "p": "103"
                                                                                                                                  },
                                                                                                                                  "subexprPos": "/1/1/1/1/1/1/0/1/1/0/1"
                                                                                                                                },
                                                                                                                                {
                                                                                                                                  "text": "1"
                                                                                                                                }
                                                                                                                              ]
                                                                                                                            },
                                                                                                                            {
                                                                                                                              "text": " = "
                                                                                                                            },
                                                                                                                            {
                                                                                                                              "tag": [
                                                                                                                                {
                                                                                                                                  "info": {
                                                                                                                                    "p": "104"
                                                                                                                                  },
                                                                                                                                  "subexprPos": "/1/1/1/1/1/1/0/1/1/1"
                                                                                                                                },
                                                                                                                                {
                                                                                                                                  "text": "«$x2»"
                                                                                                                                }
                                                                                                                              ]
                                                                                                                            }
                                                                                                                          ]
                                                                                                                        }
                                                                                                                      ]
                                                                                                                    }
                                                                                                                  ]
                                                                                                                }
                                                                                                              ]
                                                                                                            },
                                                                                                            {
                                                                                                              "text": " ∨ "
                                                                                                            },
                                                                                                            {
                                                                                                              "tag": [
                                                                                                                {
                                                                                                                  "info": {
                                                                                                                    "p": "105"
                                                                                                                  },
                                                                                                                  "subexprPos": "/1/1/1/1/1/1/1"
                                                                                                                },
                                                                                                                {
                                                                                                                  "append": [
                                                                                                                    {
                                                                                                                      "tag": [
                                                                                                                        {
                                                                                                                          "info": {
                                                                                                                            "p": "106"
                                                                                                                          },
                                                                                                                          "subexprPos": "/1/1/1/1/1/1/1/0/1"
                                                                                                                        },
                                                                                                                        {
                                                                                                                          "append": [
                                                                                                                            {
                                                                                                                              "tag": [
                                                                                                                                {
                                                                                                                                  "info": {
                                                                                                                                    "p": "107"
                                                                                                                                  },
                                                                                                                                  "subexprPos": "/1/1/1/1/1/1/1/0/1/0/1"
                                                                                                                                },
                                                                                                                                {
                                                                                                                                  "text": "1"
                                                                                                                                }
                                                                                                                              ]
                                                                                                                            },
                                                                                                                            {
                                                                                                                              "text": " = "
                                                                                                                            },
                                                                                                                            {
                                                                                                                              "tag": [
                                                                                                                                {
                                                                                                                                  "info": {
                                                                                                                                    "p": "108"
                                                                                                                                  },
                                                                                                                                  "subexprPos": "/1/1/1/1/1/1/1/0/1/1"
                                                                                                                                },
                                                                                                                                {
                                                                                                                                  "text": "«$x1»"
                                                                                                                                }
                                                                                                                              ]
                                                                                                                            }
                                                                                                                          ]
                                                                                                                        }
                                                                                                                      ]
                                                                                                                    },
                                                                                                                    {
                                                                                                                      "text": " ∧ "
                                                                                                                    },
                                                                                                                    {
                                                                                                                      "tag": [
                                                                                                                        {
                                                                                                                          "info": {
                                                                                                                            "p": "109"
                                                                                                                          },
                                                                                                                          "subexprPos": "/1/1/1/1/1/1/1/1"
                                                                                                                        },
                                                                                                                        {
                                                                                                                          "append": [
                                                                                                                            {
                                                                                                                              "tag": [
                                                                                                                                {
                                                                                                                                  "info": {
                                                                                                                                    "p": "110"
                                                                                                                                  },
                                                                                                                                  "subexprPos": "/1/1/1/1/1/1/1/1/0/1"
                                                                                                                                },
                                                                                                                                {
                                                                                                                                  "text": "1"
                                                                                                                                }
                                                                                                                              ]
                                                                                                                            },
                                                                                                                            {
                                                                                                                              "text": " = "
                                                                                                                            },
                                                                                                                            {
                                                                                                                              "tag": [
                                                                                                                                {
                                                                                                                                  "info": {
                                                                                                                                    "p": "111"
                                                                                                                                  },
                                                                                                                                  "subexprPos": "/1/1/1/1/1/1/1/1/1"
                                                                                                                                },
                                                                                                                                {
                                                                                                                                  "text": "«$x2»"
                                                                                                                                }
                                                                                                                              ]
                                                                                                                            }
                                                                                                                          ]
                                                                                                                        }
                                                                                                                      ]
                                                                                                                    }
                                                                                                                  ]
                                                                                                                }
                                                                                                              ]
                                                                                                            }
                                                                                                          ]
                                                                                                        }
                                                                                                      ]
                                                                                                    }
                                                                                                  ]
                                                                                                }
                                                                                              ]
                                                                                            }
                                                                                          ]
                                                                                        }
                                                                                      ]
                                                                                    }
                                                                                  ]
                                                                                }
                                                                              ]
                                                                            }
                                                                          ]
                                                                        }
                                                                      ]
                                                                    }
                                                                  ]
                                                                }
                                                              ]
                                                            }
                                                          },
                                                          []
                                                        ]
                                                      }
                                                    ]
                                                  ]
                                                }
                                              ]
                                            ]
                                          },
                                          {
                                            "element": [
                                              "tr",
                                              [],
                                              [
                                                {
                                                  "element": [
                                                    "td",
                                                    [],
                                                    [
                                                      {
                                                        "component": [
                                                          "11582378131819853457",
                                                          "default",
                                                          {
                                                            "expr": {
                                                              "p": "112"
                                                            }
                                                          },
                                                          []
                                                        ]
                                                      }
                                                    ]
                                                  ]
                                                },
                                                {
                                                  "element": [
                                                    "td",
                                                    [],
                                                    [
                                                      {
                                                        "component": [
                                                          "1305683135076217222",
                                                          "default",
                                                          {
                                                            "fmt": {
                                                              "tag": [
                                                                {
                                                                  "info": {
                                                                    "p": "113"
                                                                  },
                                                                  "subexprPos": "/"
                                                                },
                                                                {
                                                                  "append": [
                                                                    {
                                                                      "text": "fun "
                                                                    },
                                                                    {
                                                                      "tag": [
                                                                        {
                                                                          "info": {
                                                                            "p": "114"
                                                                          },
                                                                          "subexprPos": "/"
                                                                        },
                                                                        {
                                                                          "text": "«$x1»"
                                                                        }
                                                                      ]
                                                                    },
                                                                    {
                                                                      "text": " => "
                                                                    },
                                                                    {
                                                                      "tag": [
                                                                        {
                                                                          "info": {
                                                                            "p": "115"
                                                                          },
                                                                          "subexprPos": "/1"
                                                                        },
                                                                        {
                                                                          "text": "False"
                                                                        }
                                                                      ]
                                                                    }
                                                                  ]
                                                                }
                                                              ]
                                                            }
                                                          },
                                                          []
                                                        ]
                                                      }
                                                    ]
                                                  ]
                                                }
                                              ]
                                            ]
                                          },
                                          {
                                            "element": [
                                              "tr",
                                              [],
                                              [
                                                {
                                                  "element": [
                                                    "td",
                                                    [],
                                                    [
                                                      {
                                                        "component": [
                                                          "11582378131819853457",
                                                          "default",
                                                          {
                                                            "expr": {
                                                              "p": "116"
                                                            }
                                                          },
                                                          []
                                                        ]
                                                      }
                                                    ]
                                                  ]
                                                },
                                                {
                                                  "element": [
                                                    "td",
                                                    [],
                                                    [
                                                      {
                                                        "component": [
                                                          "1305683135076217222",
                                                          "default",
                                                          {
                                                            "fmt": {
                                                              "tag": [
                                                                {
                                                                  "info": {
                                                                    "p": "117"
                                                                  },
                                                                  "subexprPos": "/"
                                                                },
                                                                {
                                                                  "text": "False"
                                                                }
                                                              ]
                                                            }
                                                          },
                                                          []
                                                        ]
                                                      }
                                                    ]
                                                  ]
                                                }
                                              ]
                                            ]
                                          }
                                        ]
                                      ]
                                    }
                                  ]
                                ]
                              }
                            ]
                          ]
                        },
                        "model": {
                          "sorts": 1,
                          "values": 8
                        }
                      }
                    ],
                    "kind": "sat"
                  },
                  "status": "proven",
                  "time": 267
                }
              }
            },
            "time": 267
          }
        ],
        "successfulDischargerId": null,
        "successfulDischargerTime": null,
        "totalTime": 267
      }
    },
    {
      "alternativeFor": 19,
      "id": 20,
      "isDormant": false,
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
