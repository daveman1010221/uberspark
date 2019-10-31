(****************************************************************************)
(****************************************************************************)
(* uberSpark codegen interface for uobj *)
(*	 author: amit vasudevan (amitvasudevan@acm.org) *)
(****************************************************************************)
(****************************************************************************)


(****************************************************************************)
(* types *)
(****************************************************************************)



(****************************************************************************)
(* interfaces *)
(****************************************************************************)


(*--------------------------------------------------------------------------*)
(* generate uobj binary header source *)
(*--------------------------------------------------------------------------*)
let generate_src_binhdr = 

    (* open binary header source file *)
    let oc = open_out Uberspark_config.namespace_uobj_binhdr_src_filename in
    
    (* generate prologue *)
    Printf.fprintf oc "\n/* autogenerated uberSpark uobj binary header source */";
    Printf.fprintf oc "\n/* author: amit vasudevan (amitvasudevan@acm.org) */";
    Printf.fprintf oc "\n";
    Printf.fprintf oc "\n#include <uberspark.h>";
    Printf.fprintf oc "\n#include <usbinformat.h>";
    Printf.fprintf oc "\n";
    Printf.fprintf oc "\n";

    Printf.fprintf oc "\n__attribute__(( section(\".binhdr\") )) __attribute__((aligned(4096))) usbinformat_uobj_hdr_t uobj_hdr = {";

    (* generate common header *)
    (* hdr *)
    Printf.fprintf oc "\n\t{"; 
    (*magic*)
    Printf.fprintf oc "\n\t\tUSBINFORMAT_HDR_MAGIC_UOBJ,"; 
    (*num_sections*)
    Printf.fprintf oc "\n\t\t0x%08xUL," (Hashtbl.length self#get_d_sections_hashtbl);
    (*page_size*)
    Printf.fprintf oc "\n\t\t0x%08xUL," Uberspark_config.config_settings.binary_page_size; 
    (*aligned_at*)
    Printf.fprintf oc "\n\t\t0x%08xUL," Uberspark_config.config_settings.binary_page_size; 
    (*pad_to*)
    Printf.fprintf oc "\n\t\t0x%08xUL," Uberspark_config.config_settings.binary_page_size; 
    (*size*)
    Printf.fprintf oc "\n\t\t0x%08xULL," (self#get_d_size); 
    Printf.fprintf oc "\n\t},"; 
    (* load_addr *)
    Printf.fprintf oc "\n\t0x%08xULL," (self#get_d_load_addr); 
    (* load_size *)
    Printf.fprintf oc "\n\t0x%08xULL," (self#get_d_size); 
    
    (* generate uobj section defs *)
    Printf.fprintf oc "\n\t{"; 
    
    Hashtbl.iter (fun key (section_info:Defs.Basedefs.section_info_t) ->  
        Printf.fprintf oc "\n\t\t{"; 
        (* type *)
        Printf.fprintf oc "\n\t\t\t0x%08xUL," (section_info.usbinformat.f_type); 
        (* prot *)
        Printf.fprintf oc "\n\t\t\t0x%08xUL," (section_info.usbinformat.f_prot); 
        (* size *)
        Printf.fprintf oc "\n\t\t\t0x%016xULL," (section_info.usbinformat.f_size); 
        (* aligned_at *)
        Printf.fprintf oc "\n\t\t\t0x%08xUL," (section_info.usbinformat.f_aligned_at); 
        (* pad_to *)
        Printf.fprintf oc "\n\t\t\t0x%08xUL," (section_info.usbinformat.f_pad_to); 
        (* addr_start *)
        Printf.fprintf oc "\n\t\t\t0x%016xULL," (section_info.usbinformat.f_addr_start); 
        (* addr_file *)
        Printf.fprintf oc "\n\t\t\t0x%016xULL," (section_info.usbinformat.f_addr_file); 
        (* reserved *)
        Printf.fprintf oc "\n\t\t\t0ULL"; 
        Printf.fprintf oc "\n\t\t},"; 
    ) self#get_d_sections_hashtbl;
    
    Printf.fprintf oc "\n\t},"; 

    (* generate epilogue *)
    Printf.fprintf oc "\n};";
    Printf.fprintf oc "\n";
    Printf.fprintf oc "\n";

    close_out oc;

    ()
;;



(*--------------------------------------------------------------------------*)
(* generate uobj publicmethods info  *)
(*--------------------------------------------------------------------------*)
let generate_src_publicmethods_info = 

    (* open public methods info source file *)
    let oc = open_out Uberspark_config.namespace_uobj_publicmethods_info_src_filename in
    
    (* generate prologue *)
    Printf.fprintf oc "\n/* autogenerated uberSpark uobj public methods info source */";
    Printf.fprintf oc "\n/* author: amit vasudevan (amitvasudevan@acm.org) */";
    Printf.fprintf oc "\n";
    Printf.fprintf oc "\n#include <uberspark.h>";
    Printf.fprintf oc "\n#include <usbinformat.h>";
    Printf.fprintf oc "\n";
    Printf.fprintf oc "\n";

    Printf.fprintf oc "\n__attribute__(( section(\".pminfo\") )) __attribute__((aligned(4096))) usbinformat_uobj_publicmethod_info_t uobj_pminfo = {";

    (*num_publicmethods*)
    Printf.fprintf oc "\n\t\t0x%08xUL," (Hashtbl.length self#get_d_publicmethods_hashtbl);
    
    (* generate uobj public methods defs *)
    Printf.fprintf oc "\n\t{"; 
    
    Hashtbl.iter (fun key (pm_info:Uberspark_manifest.Uobj.uobj_publicmethods_t) ->  
        Printf.fprintf oc "\n\t\t{"; 
        (* name *)
        Printf.fprintf oc "\n\t\t\t\"%s\"," (pm_info.f_name); 
        (* vaddr *)
        Printf.fprintf oc "\n\t\t\t&%s," (pm_info.f_name); 
        Printf.fprintf oc "\n\t\t},"; 
    ) self#get_d_publicmethods_hashtbl;
    
    Printf.fprintf oc "\n\t},"; 

    (* generate epilogue *)
    Printf.fprintf oc "\n};";
    Printf.fprintf oc "\n";
    Printf.fprintf oc "\n";

    close_out oc;

    ()
;;



(*--------------------------------------------------------------------------*)
(* generate uobj intrauobjcoll-callees info  *)
(*--------------------------------------------------------------------------*)
let generate_src_intrauobjcoll_callees_info = 

    (* open public methods info source file *)
    let oc = open_out Uberspark_config.namespace_uobj_intrauobjcoll_callees_info_src_filename in
    
    (* generate prologue *)
    Printf.fprintf oc "\n/* autogenerated uberSpark uobj intrauobjcoll callees info source */";
    Printf.fprintf oc "\n/* author: amit vasudevan (amitvasudevan@acm.org) */";
    Printf.fprintf oc "\n";
    Printf.fprintf oc "\n#include <uberspark.h>";
    Printf.fprintf oc "\n#include <usbinformat.h>";
    Printf.fprintf oc "\n";
    Printf.fprintf oc "\n";

    Printf.fprintf oc "\n__attribute__(( section(\".intrauobjcollcalleesinfo\") )) __attribute__((aligned(4096))) usbinformat_uobj_intrauobjcoll_callees_info_t uobj_intrauobjcoll_callees = {";

    (*num_intrauobjcoll_callees*)
    let num_intrauobjcoll_callees = ref 0 in
    Hashtbl.iter (fun key value  ->
        num_intrauobjcoll_callees := !num_intrauobjcoll_callees + (List.length value);
    ) self#get_d_intrauobjcoll_callees_hashtbl;
    Printf.fprintf oc "\n\t\t0x%08xUL," !num_intrauobjcoll_callees;
    
    (* generate uobj public methods defs *)
    Printf.fprintf oc "\n\t{"; 

    let slt_ordinal = ref 0 in
    Hashtbl.iter (fun key value ->  
        List.iter (fun pm_name -> 
            Printf.fprintf oc "\n\t\t{"; 
            
            (* uobj_ns *)
            Printf.fprintf oc "\n\t\t\t\"%s\"," key; 
            (* pm_name *)
            Printf.fprintf oc "\n\t\t\t\"%s\"," pm_name; 
            (* slt_ordinal *)
            Printf.fprintf oc "\n\t\t0x%08xUL," !slt_ordinal;
            
            Printf.fprintf oc "\n\t\t},"; 
            slt_ordinal := !slt_ordinal + 1;
        ) value;
    ) self#get_d_intrauobjcoll_callees_hashtbl;
    
    Printf.fprintf oc "\n\t},"; 

    (* generate epilogue *)
    Printf.fprintf oc "\n};";
    Printf.fprintf oc "\n";
    Printf.fprintf oc "\n";

    close_out oc;

    ()
;;



(*--------------------------------------------------------------------------*)
(* generate uobj interuobjcoll-callees info  *)
(*--------------------------------------------------------------------------*)
let generate_src_interuobjcoll_callees_info = 

    (* open interuobjcoll callees info source file *)
    let oc = open_out Uberspark_config.namespace_uobj_interuobjcoll_callees_info_src_filename in
    
    (* generate prologue *)
    Printf.fprintf oc "\n/* autogenerated uberSpark uobj interuobjcoll callees info source */";
    Printf.fprintf oc "\n/* author: amit vasudevan (amitvasudevan@acm.org) */";
    Printf.fprintf oc "\n";
    Printf.fprintf oc "\n#include <uberspark.h>";
    Printf.fprintf oc "\n#include <usbinformat.h>";
    Printf.fprintf oc "\n";
    Printf.fprintf oc "\n";

    Printf.fprintf oc "\n__attribute__(( section(\".interuobjcollcalleesinfo\") )) __attribute__((aligned(4096))) usbinformat_uobj_interuobjcoll_callees_info_t uobj_interuobjcoll_callees = {";

    (*num_interuobjcoll_callees*)
    let num_interuobjcoll_callees = ref 0 in
    Hashtbl.iter (fun key value  ->
        num_interuobjcoll_callees := !num_interuobjcoll_callees + (List.length value);
    ) self#get_d_interuobjcoll_callees_hashtbl;
    Printf.fprintf oc "\n\t\t0x%08xUL," !num_interuobjcoll_callees;
    
    (* generate interuobjcoll callee defs *)
    Printf.fprintf oc "\n\t{"; 

    let slt_ordinal = ref 0 in
    Hashtbl.iter (fun key value ->  
        List.iter (fun pm_name -> 
            Printf.fprintf oc "\n\t\t{"; 
            
            (* uobj_ns *)
            Printf.fprintf oc "\n\t\t\t\"%s\"," key; 
            (* pm_name *)
            Printf.fprintf oc "\n\t\t\t\"%s\"," pm_name; 
            (* slt_ordinal *)
            Printf.fprintf oc "\n\t\t0x%08xUL," !slt_ordinal;
            
            Printf.fprintf oc "\n\t\t},"; 
            slt_ordinal := !slt_ordinal + 1;
        ) value;
    ) self#get_d_interuobjcoll_callees_hashtbl;
    
    Printf.fprintf oc "\n\t},"; 

    (* generate epilogue *)
    Printf.fprintf oc "\n};";
    Printf.fprintf oc "\n";
    Printf.fprintf oc "\n";

    close_out oc;
    ()
;;



(*--------------------------------------------------------------------------*)
(* generate sentinel linkage table *)
(*--------------------------------------------------------------------------*)
let generate_slt	
    (fn_list: string list)
    (output_section_name_code : string)
    (output_section_name_data : string)
    (output_filename : string)
    : bool	= 
        let retval = ref false in
        
        Uberspark_logger.log ~lvl:Uberspark_logger.Debug "fn_list length=%u" (List.length fn_list);
        let oc = open_out output_filename in
            Printf.fprintf oc "\n/* --- this file is autogenerated --- */";
            Printf.fprintf oc "\n/* uberSpark sentinel linkage table */";
            Printf.fprintf oc "\n/* author: amit vasudevan (amitvasudevan@acm.org) */";
            Printf.fprintf oc "\n";
            Printf.fprintf oc "\n";
            Printf.fprintf oc "\n/* --- trampoline data follows --- */";
            Printf.fprintf oc "\n.section %s" output_section_name_data;
            Printf.fprintf oc "\n.global uobjslt_trampolinedata";
            Printf.fprintf oc "\nuobjslt_trampolinedata:";
            let tdata_0 = Str.global_replace (Str.regexp "TOTAL_TRAMPOLINES") "2" (self#get_d_slt_trampolinedata) in
            let tdata = Str.global_replace (Str.regexp "SIZEOF_TRAMPOLINE_ENTRY") "4" tdata_0 in
            Printf.fprintf oc "\n%s" (tdata);
            Printf.fprintf oc "\n";
            Printf.fprintf oc "\n";
            Printf.fprintf oc "\n/* --- trampoline code follows --- */";
            Printf.fprintf oc "\n";
            Printf.fprintf oc "\n";


            for index=0 to (List.length fn_list - 1) do 
                Printf.fprintf oc "\n";
                Printf.fprintf oc "\n.section %s" output_section_name_code;
                Printf.fprintf oc "\n.global %s" (List.nth fn_list index);
                Printf.fprintf oc "\n%s:" (List.nth fn_list index);
                let tcode = Str.global_replace (Str.regexp "TRAMPOLINE_FN_INDEX") (string_of_int index) (self#get_d_slt_trampolinecode) in
                Printf.fprintf oc "\n%s" tcode;

                Printf.fprintf oc "\n";
            done;

        close_out oc;	

        retval := true;
        (!retval)
;;



(*--------------------------------------------------------------------------*)
(* generate uobj linker script *)
(*--------------------------------------------------------------------------*)
let generate_linker_script 
    (binary_origin : int)
    (binary_size : int)
    (sections_hashtbl : (int, Defs.Basedefs.section_info_t) Hashtbl.t) 
    : unit   =

    let oc = open_out Uberspark_config.namespace_uobj_linkerscript_filename in
        Printf.fprintf oc "\n/* autogenerated uberSpark uobj linker script */";
        Printf.fprintf oc "\n/* author: amit vasudevan (amitvasudevan@acm.org) */";
        Printf.fprintf oc "\n";
        Printf.fprintf oc "\n";
        Printf.fprintf oc "\nOUTPUT_ARCH(\"i386\")";
        Printf.fprintf oc "\n";
        Printf.fprintf oc "\n";

        Printf.fprintf oc "\nMEMORY";
        Printf.fprintf oc "\n{";

        let keys = List.sort compare (self#hashtbl_keys sections_hashtbl) in				
        List.iter (fun key ->
                let x = Hashtbl.find sections_hashtbl key in
                (* new section memory *)
                Printf.fprintf oc "\n %s (%s) : ORIGIN = 0x%08x, LENGTH = 0x%08x"
                    ("mem_" ^ x.f_name)
                    ( "rw" ^ "ail") (x.usbinformat.f_addr_start) (x.usbinformat.f_size);
                ()
        ) keys ;

        Printf.fprintf oc "\n}";
        Printf.fprintf oc "\n";
    
            
        Printf.fprintf oc "\nSECTIONS";
        Printf.fprintf oc "\n{";
        Printf.fprintf oc "\n";

        let keys = List.sort compare (self#hashtbl_keys sections_hashtbl) in				

        let i = ref 0 in 			
        while (!i < List.length keys) do
            let key = (List.nth keys !i) in
            let x = Hashtbl.find sections_hashtbl key in
                (* new section *)
                if(!i == (List.length keys) - 1 ) then 
                    begin
                        Printf.fprintf oc "\n %s : {" x.f_name;
                        Printf.fprintf oc "\n	%s_START_ADDR = .;" x.f_name;
                        List.iter (fun subsection ->
                                    Printf.fprintf oc "\n *(%s)" subsection;
                        ) x.f_subsection_list;
                        Printf.fprintf oc "\n . = ORIGIN(%s) + LENGTH(%s) - 1;" ("mem_" ^ x.f_name) ("mem_" ^ x.f_name);
                        Printf.fprintf oc "\n BYTE(0xAA)";
                        Printf.fprintf oc "\n	%s_END_ADDR = .;" x.f_name;
                        Printf.fprintf oc "\n	} >%s =0x9090" ("mem_" ^ x.f_name);
                        Printf.fprintf oc "\n";
                    end
                else
                    begin
                        Printf.fprintf oc "\n %s : {" x.f_name;
                        Printf.fprintf oc "\n	%s_START_ADDR = .;" x.f_name;
                        List.iter (fun subsection ->
                                    Printf.fprintf oc "\n *(%s)" subsection;
                        ) x.f_subsection_list;
                        Printf.fprintf oc "\n . = ORIGIN(%s) + LENGTH(%s) - 1;" ("mem_" ^ x.f_name) ("mem_" ^ x.f_name);
                        Printf.fprintf oc "\n BYTE(0xAA)";
                        Printf.fprintf oc "\n	%s_END_ADDR = .;" x.f_name;
                        Printf.fprintf oc "\n	} >%s =0x9090" ("mem_" ^ x.f_name);
                        Printf.fprintf oc "\n";
                    end
                ;
        
            i := !i + 1;
        done;
                    
        Printf.fprintf oc "\n";
        Printf.fprintf oc "\n	/* this is to cause the link to fail if there is";
        Printf.fprintf oc "\n	* anything we didn't explicitly place.";
        Printf.fprintf oc "\n	* when this does cause link to fail, temporarily comment";
        Printf.fprintf oc "\n	* this part out to see what sections end up in the output";
        Printf.fprintf oc "\n	* which are not handled above, and handle them.";
        Printf.fprintf oc "\n	*/";
        Printf.fprintf oc "\n	/DISCARD/ : {";
        Printf.fprintf oc "\n	*(*)";
        Printf.fprintf oc "\n	}";
        Printf.fprintf oc "\n}";
        Printf.fprintf oc "\n";
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
        close_out oc;
        ()
;;
		
