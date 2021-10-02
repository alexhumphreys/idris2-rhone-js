module Text.CSS.ListStyleType

%default total

public export
data ListStyleType : Type where
  None                : ListStyleType
  Disc                : ListStyleType
  Circle              : ListStyleType
  Square              : ListStyleType
  Decimal             : ListStyleType
  LowerAlpha          : ListStyleType
  UpperAlpha          : ListStyleType
  LowerRoman          : ListStyleType
  UpperRoman          : ListStyleType

export
render : ListStyleType -> String
render None                = "none"
render Disc                = "disc"
render Circle              = "circle"
render Square              = "square"
render Decimal             = "decimal"
render LowerAlpha          = "lower-alpha"
render UpperAlpha          = "upper-alpha"
render LowerRoman          = "lower-roman"
render UpperRoman          = "upper-roman"
