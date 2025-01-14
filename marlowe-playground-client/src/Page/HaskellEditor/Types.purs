module Page.HaskellEditor.Types where

import Prologue
import Analytics (class IsEvent, Event)
import Analytics as A
import Component.BottomPanel.Types as BottomPanel
import Component.MetadataTab.Types (MetadataAction, showConstructor)
import Data.BigInteger (BigInteger)
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Lens (Fold', Getter', Lens', _Right, has, to)
import Data.Lens.Record (prop)
import Data.Symbol (SProxy(..))
import Halogen.Monaco (KeyBindings(..))
import Halogen.Monaco as Monaco
import Language.Haskell.Interpreter (InterpreterError, InterpreterResult, _InterpreterResult)
import Marlowe.Extended.Metadata (MetadataHintInfo)
import Marlowe.Parser (parseContract)
import Marlowe.Template (IntegerTemplateType)
import Network.RemoteData (RemoteData(..), _Loading, _Success)
import StaticAnalysis.Types (AnalysisState, initAnalysisState)
import Text.Pretty (pretty)
import Types (WebData)

data Action
  = Compile
  | ChangeKeyBindings KeyBindings
  | HandleEditorMessage Monaco.Message
  | BottomPanelAction (BottomPanel.Action BottomPanelView Action)
  | SendResultToSimulator
  | InitHaskellProject MetadataHintInfo String
  | SetIntegerTemplateParam IntegerTemplateType String BigInteger
  | AnalyseContract
  | AnalyseReachabilityContract
  | AnalyseContractForCloseRefund
  | ClearAnalysisResults
  | MetadataAction MetadataAction

defaultEvent :: String -> Event
defaultEvent s = A.defaultEvent $ "Haskell." <> s

instance actionIsEvent :: IsEvent Action where
  toEvent Compile = Just $ defaultEvent "Compile"
  toEvent (ChangeKeyBindings _) = Just $ defaultEvent "ChangeKeyBindings"
  toEvent (HandleEditorMessage _) = Just $ defaultEvent "HandleEditorMessage"
  toEvent (BottomPanelAction action) = A.toEvent action
  toEvent SendResultToSimulator = Just $ defaultEvent "SendResultToSimulator"
  toEvent (InitHaskellProject _ _) = Just $ defaultEvent "InitHaskellProject"
  toEvent (SetIntegerTemplateParam _ _ _) = Just $ defaultEvent "SetIntegerTemplateParam"
  toEvent AnalyseContract = Just $ defaultEvent "AnalyseContract"
  toEvent AnalyseReachabilityContract = Just $ defaultEvent "AnalyseReachabilityContract"
  toEvent AnalyseContractForCloseRefund = Just $ defaultEvent "AnalyseContractForCloseRefund"
  toEvent ClearAnalysisResults = Just $ defaultEvent "ClearAnalysisResults"
  toEvent (MetadataAction action) = Just $ (defaultEvent "MetadataAction") { label = Just $ showConstructor action }

type State
  = { keybindings :: KeyBindings
    , compilationResult :: WebData (Either InterpreterError (InterpreterResult String))
    , bottomPanelState :: BottomPanel.State BottomPanelView
    , metadataHintInfo :: MetadataHintInfo
    , analysisState :: AnalysisState
    , editorReady :: Boolean
    }

_haskellEditorKeybindings :: Lens' State KeyBindings
_haskellEditorKeybindings = prop (SProxy :: SProxy "keybindings")

_compilationResult :: Lens' State (WebData (Either InterpreterError (InterpreterResult String)))
_compilationResult = prop (SProxy :: SProxy "compilationResult")

_metadataHintInfo :: Lens' State MetadataHintInfo
_metadataHintInfo = prop (SProxy :: SProxy "metadataHintInfo")

_analysisState :: Lens' State AnalysisState
_analysisState = prop (SProxy :: SProxy "analysisState")

_editorReady :: Lens' State Boolean
_editorReady = prop (SProxy :: SProxy "editorReady")

--- Language.Haskell.Interpreter is missing this ---
_result :: forall s a. Lens' { result :: a | s } a
_result = prop (SProxy :: SProxy "result")

_Pretty :: Getter' String String
_Pretty = to f
  where
  f ugly = case parseContract ugly of
    Right contract -> (show <<< pretty) contract
    Left _ -> ugly

_ContractString :: forall r. Monoid r => Fold' r State String
_ContractString = _compilationResult <<< _Success <<< _Right <<< _InterpreterResult <<< _result <<< _Pretty

_bottomPanelState :: Lens' State (BottomPanel.State BottomPanelView)
_bottomPanelState = prop (SProxy :: SProxy "bottomPanelState")

initialState :: State
initialState =
  { keybindings: DefaultBindings
  , compilationResult: NotAsked
  , bottomPanelState: BottomPanel.initialState MetadataView
  , metadataHintInfo: mempty
  , analysisState: initAnalysisState
  , editorReady: false
  }

isCompiling :: State -> Boolean
isCompiling = has (_compilationResult <<< _Loading)

data BottomPanelView
  = StaticAnalysisView
  | ErrorsView
  | GeneratedOutputView
  | MetadataView

derive instance eqBottomPanelView :: Eq BottomPanelView

derive instance genericBottomPanelView :: Generic BottomPanelView _

instance showBottomPanelView :: Show BottomPanelView where
  show = genericShow
