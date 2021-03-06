-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Github.Object.RateLimit exposing (..)

import Github.InputObject
import Github.Interface
import Github.Object
import Github.Scalar
import Github.Union
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Internal.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Internal.Builder.Object as Object
import Graphqelm.Internal.Encode as Encode exposing (Value)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


{-| Select fields to build up a SelectionSet for this object.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.RateLimit
selection constructor =
    Object.selection constructor


{-| The point cost for the current query counting against the rate limit.
-}
cost : Field Int Github.Object.RateLimit
cost =
    Object.fieldDecoder "cost" [] Decode.int


{-| The maximum number of points the client is permitted to consume in a 60 minute window.
-}
limit : Field Int Github.Object.RateLimit
limit =
    Object.fieldDecoder "limit" [] Decode.int


{-| The maximum number of nodes this query may return
-}
nodeCount : Field Int Github.Object.RateLimit
nodeCount =
    Object.fieldDecoder "nodeCount" [] Decode.int


{-| The number of points remaining in the current rate limit window.
-}
remaining : Field Int Github.Object.RateLimit
remaining =
    Object.fieldDecoder "remaining" [] Decode.int


{-| The time at which the current rate limit window resets in UTC epoch seconds.
-}
resetAt : Field Github.Scalar.DateTime Github.Object.RateLimit
resetAt =
    Object.fieldDecoder "resetAt" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.DateTime)
