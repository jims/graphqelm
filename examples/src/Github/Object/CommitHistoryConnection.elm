-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Github.Object.CommitHistoryConnection exposing (..)

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
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.CommitHistoryConnection
selection constructor =
    Object.selection constructor


edges : SelectionSet decodesTo Github.Object.CommitEdge -> Field (Maybe (List (Maybe decodesTo))) Github.Object.CommitHistoryConnection
edges object =
    Object.selectionField "edges" [] object (identity >> Decode.nullable >> Decode.list >> Decode.nullable)


{-| A list of nodes.
-}
nodes : SelectionSet decodesTo Github.Object.Commit -> Field (Maybe (List (Maybe decodesTo))) Github.Object.CommitHistoryConnection
nodes object =
    Object.selectionField "nodes" [] object (identity >> Decode.nullable >> Decode.list >> Decode.nullable)


{-| Information to aid in pagination.
-}
pageInfo : SelectionSet decodesTo Github.Object.PageInfo -> Field decodesTo Github.Object.CommitHistoryConnection
pageInfo object =
    Object.selectionField "pageInfo" [] object identity


{-| Identifies the total count of items in the connection.
-}
totalCount : Field Int Github.Object.CommitHistoryConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
