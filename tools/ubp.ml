(*
	frama-c plugin for blueprint conformance
	author: amit vasudevan (amitvasudevan@acm.org)
*)
open Umfcommon

module Self = Plugin.Register
	(struct
		let name = "US blueprint conformance"
		let shortname = "ubp"
		let help = "UberSpark blueprint conformance plugin"
	end)


module Cmdopt_slabsfile = Self.String
	(struct
		let option_name = "-umf-uobjlist"
		let default = ""
		let arg_name = "uobjlist-file"
		let help = "uobj list file"
	end)

module Cmdopt_outputdir_sentinelstubs = Self.String
	(struct
		let option_name = "-umf-outdirsentinelstubs"
		let default = ""
		let arg_name = "outdirsentinelstubs"
		let help = "output directory for uobj sentinel stubs"
	end)



module Cmdopt_maxincldevlistentries = Self.String
	(struct
		let option_name = "-umf-maxincldevlistentries"
		let default = ""
		let arg_name = "max-incldevlistentries"
		let help = "total number of INCL device list entries"
	end)

module Cmdopt_maxexcldevlistentries = Self.String
	(struct
		let option_name = "-umf-maxexcldevlistentries"
		let default = ""
		let arg_name = "max-excldevlistentries"
		let help = "total number of EXCL device list entries"
	end)

module Cmdopt_maxmemoffsetentries = Self.String
	(struct
		let option_name = "-umf-maxmemoffsetentries"
		let default = ""
		let arg_name = "max-memoffsetentries"
		let help = "total number of MEMOFFSET entries"
	end)

module Cmdopt_memoffsets = Self.False
	(struct
		let option_name = "-umf-memoffsets"
		(* let default = false *)
		let help = "when on (off by default), include absolute memory offsets in MEMOFFSETS list"
	end)


(*
	**************************************************************************
	global variables
	**************************************************************************
*)

(*	command line inputs *)
let g_slabsfile = ref "";;	(* argv 0 *)
let g_outputdir_sentinelstubs = ref "";; (* argv 1 *)
(* let g_maxincldevlistentries = ref 0;; *) (* argv 2 *)
(* let g_maxexcldevlistentries = ref 0;; *) (* argv 3 *)
(* let g_maxmemoffsetentries = ref 0;; *) (* argv 4 *)
let g_memoffsets = ref false;; (*argv 5 *)

(* other global variables *)
let g_rootdir = ref "";;



let ubp_process_cmdline () =
	g_slabsfile := Cmdopt_slabsfile.get();
	g_outputdir_sentinelstubs := Cmdopt_outputdir_sentinelstubs.get();
	g_maxincldevlistentries := int_of_string (Cmdopt_maxincldevlistentries.get());
	g_maxexcldevlistentries := int_of_string (Cmdopt_maxexcldevlistentries.get());
	g_maxmemoffsetentries := int_of_string (Cmdopt_maxmemoffsetentries.get());
	if Cmdopt_memoffsets.get() then g_memoffsets := true else g_memoffsets := false;

	
	Self.result "g_slabsfile=%s\n" !g_slabsfile;
	Self.result "g_outputdir_sentinelstubs=%s\n" !g_outputdir_sentinelstubs;
	Self.result "g_maxincldevlistentries=%d\n" !g_maxincldevlistentries;
	Self.result "g_maxexcldevlistentries=%d\n" !g_maxexcldevlistentries;
	Self.result "g_maxmemoffsetentries=%d\n" !g_maxmemoffsetentries;
	Self.result "g_memoffsets=%b\n" !g_memoffsets;
	()



let ubp_outputsentinelstubs () =
	let i = ref 0 in
	
	while (!i < !g_totalslabs) do
		if (compare (Hashtbl.find slab_idtotype !i) "VfT_SLAB") = 0 then
			(* ubp_outputsentinelstubforslab !g_outputdir_sentinelstubs (Hashtbl.find slab_idtoname !i) !i *)
		;
	    i := !i + 1;
	done;
	()


	
let run () =
	Self.result "Generating blueprint conformance sentinel stubs...\n";
	ubp_process_cmdline ();

	g_rootdir := (Filename.dirname !g_slabsfile) ^ "/";
	Self.result "g_rootdir=%s\n" !g_rootdir;

	umfcommon_init !g_slabsfile !g_memoffsets !g_rootdir;
	Self.result "g_totalslabs=%d \n" !g_totalslabs;
	
	ubp_outputsentinelstubs ();
	
	Self.result "Done.\n";
	()


let () = Db.Main.extend run

