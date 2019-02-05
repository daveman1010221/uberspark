(*
	uberSpark configuration data interface
	author: amit vasudevan (amitvasudevan@acm.org)
*)

module Usconfig =
	struct

	(* uobj manifest default filename *)
	let std_uobj_usmf_name = "UOBJ.USMF";;
	
	(* uobj collection manifest default filename *)
	let std_uobj_coll_usmf_name = "UOBJCOLL.USMF";;

	(* uobj library manifest default filename *)
	let std_uobj_lib_usmf_name = "UOBJLIB.USMF";;

	(* uobj collection info default filename *)
	let std_uobjcoll_info_filename = "uobjcoll_info_table.c";;
	let get_std_uobjcoll_info_filename () =	(std_uobjcoll_info_filename)	;;

	(* standard include directories *)
	let std_incdirs = [
										"/usr/local/uberspark/include";
										"/usr/local/uberspark/hwm/include";
										"/usr/local/uberspark/libs/include";
										"."
										];;

	let get_std_incdirs () =	(std_incdirs)	;;

	(* standard preprocessor definitions *)
	let std_defines = [ 
											"__XMHF_TARGET_CPU_X86__"; 
											"__XMHF_TARGET_CONTAINER_VMX__";
											"__XMHF_TARGET_PLATFORM_X86PC__";
											"__XMHF_TARGET_TRIAD_X86_VMX_X86PC__"
										];;

	let get_std_defines () =	(std_defines)	;;

	let std_define_asm = [
												"__ASSEMBLY__"
											];;
				
	let get_std_define_asm () =	(std_define_asm)	;;
	
				
	(* maximum platform CPUs *)
	(* TBD: this has to be synced with hw model defs *)
	let std_max_platform_cpus = 8;;
	let get_std_max_platform_cpus () =	(std_max_platform_cpus)	;;
									
	let std_max_incldevlist_entries = 6;;
	let get_std_max_incldevlist_entries () = (std_max_incldevlist_entries) ;;

	let std_max_excldevlist_entries = 6;;
	let get_std_max_excldevlist_entries () = (std_max_excldevlist_entries) ;;

	let std_max_sections = 16;;
	let get_std_max_sections () = (std_max_sections) ;;

	let std_uobjcoll_info_table_max_size = 0x2000;;
	let get_std_uobjcoll_info_table_max_size () = (std_uobjcoll_info_table_max_size) ;;

;;
								
	end