type kind = [ `File | `Directory | `Link | `Block | `Char | `Fifo | `Socket ]

val kind : string -> kind

type recurse = [ `Yes | `No | `Depth of int ]

val find_files :
  ?recurse:recurse -> ?filter:(string -> bool) -> string -> string list
