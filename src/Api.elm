module Api exposing (get)

import Api.Endpoint as Endpoint exposing (Endpoint)
import Http
import Json.Decode as Decode exposing (Decoder)


get : Endpoint -> (Result Http.Error a -> msg) -> Decoder a -> Cmd msg
get endpoint msg decoder =
    Endpoint.request
        { endpoint = endpoint
        , expect = Http.expectJson msg decoder
        , method = "GET"
        , headers = []
        , body = Http.emptyBody
        , timeout = Nothing
        , tracker = Nothing
        }
