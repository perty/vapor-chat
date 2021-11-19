port module Ports exposing (connected, join, joined)


port join : String -> Cmd msg


port joined : (String -> msg) -> Sub msg


port connected : (String -> msg) -> Sub msg
