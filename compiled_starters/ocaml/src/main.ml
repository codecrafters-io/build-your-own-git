let () =
  (* You can use print statements as follows for debugging, they'll be visible when running tests. *)
  Printf.eprintf "Logs from your program will appear here!\n";

  (* TODO: Uncomment the code below to pass the first stage *)
  (* let command = Sys.argv.(1) in *)
  (* if command = "init" then ( *)
  (*   Unix.mkdir ".git" 0o755; *)
  (*   Unix.mkdir ".git/objects" 0o755; *)
  (*   Unix.mkdir ".git/refs" 0o755; *)
  (*   let oc = open_out ".git/HEAD" in *)
  (*   output_string oc "ref: refs/heads/main\n"; *)
  (*   close_out oc; *)
  (*   print_endline "Initialized git directory") *)
  (* else *)
  (*   failwith (Printf.sprintf "Unknown command %s" command) *)
