port module Ports exposing (connected, disconnect, disconnected, join, joined, selfVideoOn)


port join : String -> Cmd msg


port joined : (String -> msg) -> Sub msg


port connected : (String -> msg) -> Sub msg


port disconnect : () -> Cmd msg


port disconnected : (String -> msg) -> Sub msg


port selfVideoOn : String -> Cmd msg
