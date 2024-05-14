type recurse = [ `Yes | `No | `Depth of int ]

let rec filter_files ?(recurse = `Yes) ~filter path =
  let files = Sys.readdir path in
  Array.fold_left
    (fun acc v ->
      let file = Filename.concat path v in
      let acc = if filter file then file :: acc else acc in
      if not (Sys.is_directory file) then acc
      else
        match recurse with
        | `No -> acc
        | `Depth 0 -> acc
        | `Depth n -> filter_files ~recurse:(`Depth (n - 1)) ~filter file @ acc
        | `Yes -> filter_files ~recurse ~filter file @ acc)
    [] files
