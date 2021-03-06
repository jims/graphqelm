module Graphqelm.Generator.InputObjectFile.Constructor exposing (generate)

import Graphqelm.Generator.AnnotatedArg as AnnotatedArg
import Graphqelm.Generator.Context exposing (Context)
import Graphqelm.Generator.Decoder as Decoder
import Graphqelm.Generator.InputObjectFile.Details exposing (InputObjectDetails)
import Graphqelm.Generator.Let as Let
import Graphqelm.Parser.CamelCaseName as CamelCaseName exposing (CamelCaseName)
import Graphqelm.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphqelm.Parser.Type as Type exposing (TypeDefinition(TypeDefinition))
import String.Interpolate exposing (interpolate)


generate : Context -> InputObjectDetails -> String
generate context { name, fields, hasLoop } =
    let
        optionalFields =
            fields
                |> List.filter
                    (\field ->
                        case field.typeRef of
                            Type.TypeReference referrableType isNullable ->
                                isNullable == Type.Nullable
                    )

        requiredFields =
            fields
                |> List.filter
                    (\field ->
                        case field.typeRef of
                            Type.TypeReference referrableType isNullable ->
                                isNullable == Type.NonNullable
                    )

        returnRecord =
            fields
                |> List.map
                    (\field ->
                        interpolate "{0} = {1}.{0}"
                            [ CamelCaseName.normalized field.name
                            , case field.typeRef of
                                Type.TypeReference referrableType isNullable ->
                                    case isNullable of
                                        Type.Nullable ->
                                            "optionals"

                                        Type.NonNullable ->
                                            "required"
                            ]
                    )
                |> String.join ", "

        annotation =
            AnnotatedArg.buildWithArgs
                ([ when (List.length requiredFields > 0)
                    ( interpolate "{0}RequiredFields" [ ClassCaseName.normalized name ]
                    , "required"
                    )
                 , when (List.length optionalFields > 0)
                    ( interpolate "({0}OptionalFields -> {0}OptionalFields)" [ ClassCaseName.normalized name ]
                    , "fillOptionals"
                    )
                 ]
                    |> compact
                )
                (ClassCaseName.normalized name)
                |> AnnotatedArg.toString ("build" ++ ClassCaseName.normalized name)

        letClause =
            Let.generate
                ([ when (List.length optionalFields > 0)
                    ( "optionals"
                    , interpolate """
            fillOptionals
                { {0} }"""
                        [ filledOptionalsRecord optionalFields ]
                    )
                 ]
                    |> compact
                )
    in
    interpolate
        """{0}{1}
    {2}{ {3} }

{4}
{5}
"""
        [ annotation
        , letClause
        , if hasLoop then
            ClassCaseName.normalized name
          else
            ""
        , returnRecord
        , constructorFieldsAlias (ClassCaseName.normalized name ++ "RequiredFields") context requiredFields
        , constructorFieldsAlias (ClassCaseName.normalized name ++ "OptionalFields") context optionalFields
        ]


constructorFieldsAlias : String -> Context -> List Type.Field -> String
constructorFieldsAlias nameThing context fields =
    if List.length fields > 0 then
        interpolate
            """type alias {0} =
    { {1} }"""
            [ nameThing, List.map (aliasEntry context) fields |> String.join ", " ]
    else
        ""


filledOptionalsRecord : List Type.Field -> String
filledOptionalsRecord optionalFields =
    optionalFields
        |> List.map .name
        |> List.map (\fieldName -> CamelCaseName.normalized fieldName ++ " = Absent")
        |> String.join ", "


aliasEntry : Context -> Type.Field -> String
aliasEntry { apiSubmodule } field =
    interpolate "{0} : {1}"
        [ CamelCaseName.normalized field.name
        , Decoder.generateTypeForInputObject apiSubmodule field.typeRef
        ]


when : Bool -> value -> Maybe value
when condition value =
    if condition then
        Just value
    else
        Nothing


compact : List (Maybe value) -> List value
compact =
    List.filterMap identity
