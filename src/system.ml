type file_type =
  [ `File | `Directory | `Link | `Block | `Char | `Fifo | `Socket ]

let file_type file =
  match (Unix.stat file).st_kind with
  | Unix.S_REG -> `File
  | Unix.S_DIR -> `Directory
  | Unix.S_LNK -> `Link
  | Unix.S_BLK -> `Block
  | Unix.S_CHR -> `Char
  | Unix.S_FIFO -> `Fifo
  | Unix.S_SOCK -> `Socket

type recurse = [ `Yes | `No | `Depth of int ]

let find_files ?(recurse = `Yes) ?(filter = fun _ -> true) path =
  let rec loop acc recurse base =
    let files = Sys.readdir base in
    Array.fold_left
      (fun acc v ->
        let fullpath = Filename.concat base v in
        let acc = if filter fullpath then fullpath :: acc else acc in
        match (Unix.stat fullpath).st_kind with
        | S_DIR -> (
            match recurse with
            | `No -> acc
            | `Depth 0 -> acc
            | `Depth n -> loop acc (`Depth (n - 1)) fullpath
            | `Yes -> loop acc recurse fullpath)
        | _ -> acc)
      acc files
  in
  loop [] recurse path
