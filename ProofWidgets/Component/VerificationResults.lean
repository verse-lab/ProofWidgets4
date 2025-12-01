import Lean.Server.Rpc.Basic
import Lean.Elab.Command

import ProofWidgets.Component.Basic
import ProofWidgets.Component.HtmlDisplay

section

namespace ProofWidgets
open Lean Server

structure VerificationResultsProps where
  /-- The verification results to display, as JSON. -/
  results : Json
deriving RpcEncodable

@[widget_module]
def VerificationResultsViewer : Component VerificationResultsProps where
  javascript := include_str ".." / ".." / ".lake" / "build" / "js" / "verificationResults.js"

namespace DisplayVerificationResultsCommand

/-- Display verification results in the infoview. -/
syntax (name := displayVerificationResultsCmd) "#displayVerificationResults " term : command

open Lean Elab Command in
@[command_elab displayVerificationResultsCmd]
def elabDisplayVerificationResultsCmd : CommandElab := fun
  | stx@`(#displayVerificationResults $results) => do
    let t ← `(open ProofWidgets.Jsx in <VerificationResultsViewer results={$results} />)
    let html ← ← liftTermElabM <| ProofWidgets.HtmlCommand.evalCommandMHtml <| ← ``(HtmlEval.eval $t)
    liftCoreM <| Widget.savePanelWidgetInfo
      (hash HtmlDisplayPanel.javascript)
      (return json% { html: $(← rpcEncode html) })
      stx
  | stx => throwError "Unexpected syntax {stx}."

end DisplayVerificationResultsCommand

end ProofWidgets
