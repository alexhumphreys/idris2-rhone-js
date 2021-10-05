module Examples.Syntax

import JS
import Control.Category
import Control.Monad.Dom
import Data.Event
import Data.MES
import Data.MSF
import Data.String
import Examples.CSS
import Text.Html as Html
import Text.CSS as CSS
import Web.Dom

click : ElemRef e (h :: t) -> MSF m DomEvent (Event ())
click (Ref _ id _) =
  when $ \case Click x => if id == x.id then Just () else Nothing
               _       => Nothing

text : MonadDom m => ElemRef t es -> MSF m String ()
text ref = arrM $ text ref

--------------------------------------------------------------------------------
--          CSS Classes
--------------------------------------------------------------------------------

inc : String
inc = "inc"

output : String
output = "output"

--------------------------------------------------------------------------------
--          CSS
--------------------------------------------------------------------------------

css : List Rule
css =
  [ class output  !!
      [ FontSize        .= Large
      , Margin          .= pt 5
      , TextAlign       .= End
      , Width           .= perc 10
      ]

  , class inc  !!
      [ Margin          .= pt 5
      , Width           .= perc 10
      ]
  ]

--------------------------------------------------------------------------------
--          View
--------------------------------------------------------------------------------

line : (lbl: String) -> List Html.Node -> Html.Node
line lbl ns = div_ [ class .= widgetLine ] $ 
                   label_ [ class .= widgetLabel ] [Text lbl] :: ns

incbtn : (lbl: String) -> Html.Node
incbtn lbl = button [Click] [classes .= [widget,btn,inc]] [Text lbl]

content : Html.Node
content =
  div_ [ class .= widgetList ]
       [ line "Increase counter:" [ incbtn "+" ]
       , line "Decrease counter:" [ incbtn "-" ]
       , line "Count:"            [ div [] [class .= output] ["0"] ]
       ]

--------------------------------------------------------------------------------
--          Controller
--------------------------------------------------------------------------------

export
ui : MonadDom m => m (MSF m DomEvent $ Event ())
ui = do
  applyCSS $ coreCSS ++ css

  [plus, minus, out] <- innerHtmlAt contentDiv content

  pure $   (1 `on` click plus) <|> (-1 `on` click minus)
       ?>> accumulateWith (+) 0
       >>> show {ty = Int32}
       ^>> text out
