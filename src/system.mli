type file_type = [ `File | `Directory | `Link | `Block | `Char | `Fifo | `Socket ]

val file_type : string -> file_type

type recurse = [ `Yes | `No | `Depth of int ]

val find_files :
  ?recurse:recurse -> ?filter:(string -> bool) -> string -> string list
