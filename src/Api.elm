module Api exposing (get)

import Api.Endpoint as Endpoint exposing (Endpoint)
import Http
import Json.Decode as Decode exposing (Decoder)
import RemoteData exposing (WebData)


get : Endpoint -> (WebData a -> msg) -> Decoder a -> Cmd msg
get endpoint msg decoder =
    Endpoint.request
        { endpoint = endpoint
        , expect = Http.expectJson (RemoteData.fromResult >> msg) decoder
        , method = "GET"
        , headers = []
        , body = Http.emptyBody
        , timeout = Nothing
        , tracker = Nothing
        }
