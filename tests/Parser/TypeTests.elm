module Parser.TypeTests exposing (..)

import Expect
import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.Type as Type
import GraphqElm.Parser.TypeKind as TypeKind exposing (TypeKind(..))
import Test exposing (..)


all : Test
all =
    describe "typekind decoder"
        [ test "parse object definition" <|
            \() ->
                Type.RawTypeDef
                    { name = "MenuItems"
                    , kind = TypeKind.Object
                    , ofType = Nothing
                    , enumValues = Nothing
                    , fields =
                        Just
                            [ { name = "description"
                              , ofType =
                                    Type.RawTypeRef
                                        { name = Nothing
                                        , kind = TypeKind.NonNull
                                        , ofType =
                                            Just
                                                (Type.RawTypeRef
                                                    { name = Just "String"
                                                    , kind = TypeKind.Scalar
                                                    , ofType = Nothing
                                                    }
                                                )
                                        }
                              }
                            , { name = "id"
                              , ofType =
                                    Type.RawTypeRef
                                        { name = Nothing
                                        , kind = TypeKind.NonNull
                                        , ofType =
                                            Just
                                                (Type.RawTypeRef
                                                    { name = Just "ID"
                                                    , kind = TypeKind.Scalar
                                                    , ofType = Nothing
                                                    }
                                                )
                                        }
                              }
                            , { name = "nullableString"
                              , ofType =
                                    Type.RawTypeRef
                                        { name = Just "String"
                                        , kind = TypeKind.Scalar
                                        , ofType = Nothing
                                        }
                              }
                            ]
                    }
                    |> Type.parse
                    |> Expect.equal
                        (Type.TypeDefinition
                            "MenuItems"
                            (Type.ObjectType
                                [ { name = "description"
                                  , typeRef =
                                        Type.TypeReference (Type.Scalar Scalar.String)
                                            Type.NonNullable
                                  }
                                , { name = "id"
                                  , typeRef =
                                        Type.TypeReference (Type.Scalar Scalar.ID)
                                            Type.NonNullable
                                  }
                                , { name = "nullableString"
                                  , typeRef =
                                        Type.TypeReference
                                            (Type.Scalar Scalar.String)
                                            Type.Nullable
                                  }
                                ]
                            )
                        )
        , test "parse custom scalar definition" <|
            \() ->
                Type.RawTypeDef
                    { name = "Date"
                    , kind = TypeKind.Scalar
                    , ofType = Nothing
                    , fields = Nothing
                    , enumValues = Nothing
                    }
                    |> Type.parse
                    |> Expect.equal
                        (Type.TypeDefinition
                            "Date"
                            (Type.ScalarType "Date")
                        )
        ]