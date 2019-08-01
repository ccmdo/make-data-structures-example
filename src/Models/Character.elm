module Models.Character exposing (Character, fetch, level, name)

import Api
import Api.Endpoint as Endpoint
import Http
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (custom, required)


type Character
    = Character CharacterData


type alias CharacterData =
    { id : Int
    , level : Int
    , name : String
    }



-- INFO


level : Character -> Int
level (Character data) =
    data.level


name : Character -> String
name (Character data) =
    data.name ++ "#" ++ String.fromInt data.id



-- API


fetch : String -> (Result Http.Error Character -> msg) -> Cmd msg
fetch characterName msg =
    Api.get (Endpoint.character characterName) msg decoder


fetchAll : (Result Http.Error (List Character) -> msg) -> Cmd msg
fetchAll msg =
    Api.get Endpoint.characters msg (Decode.list decoder)



-- DECODERS


decoder : Decoder Character
decoder =
    Decode.succeed Character
        |> custom dataDecoder


dataDecoder : Decoder CharacterData
dataDecoder =
    Decode.succeed CharacterData
        |> required "id" Decode.int
        |> required "level" Decode.int
        |> required "name" Decode.string
