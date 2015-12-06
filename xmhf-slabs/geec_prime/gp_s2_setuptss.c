/*
 * @XMHF_LICENSE_HEADER_START@
 *
 * eXtensible, Modular Hypervisor Framework (XMHF)
 * Copyright (c) 2009-2012 Carnegie Mellon University
 * Copyright (c) 2010-2012 VDG Inc.
 * All Rights Reserved.
 *
 * Developed by: XMHF Team
 *               Carnegie Mellon University / CyLab
 *               VDG Inc.
 *               http://xmhf.org
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 *
 * Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in
 * the documentation and/or other materials provided with the
 * distribution.
 *
 * Neither the names of Carnegie Mellon or VDG Inc, nor the names of
 * its contributors may be used to endorse or promote products derived
 * from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
 * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
 * TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
 * THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *
 * @XMHF_LICENSE_HEADER_END@
 */

#include <xmhf.h>
#include <xmhf-debug.h>

#include <xmhfgeec.h>

#include <geec_prime.h>
#include <geec_sentinel.h>
#include <uapi_slabmempgtbl.h>
#include <xc_init.h>



//initialize TSS
//@ghost bool gp_s2_setuptss_invokehelper[MAX_PLATFORM_CPUS];
/*@
	requires \valid(xcbootinfo);
	requires (xcbootinfo->cpuinfo_numentries < MAX_PLATFORM_CPUS);
	ensures \forall integer x; 0 <= x < xcbootinfo->cpuinfo_numentries ==> (
				(xcbootinfo->cpuinfo_buffer[x].lapic_id < MAX_PLATFORM_CPUS) ==>
				(gp_s2_setuptss_invokehelper[x] == true) );
@*/
void gp_s2_setuptss(void){
	u32 i;

	//initialize TSS descriptors for all CPUs
    	/*@
		loop invariant a1: 0 <= i <= xcbootinfo->cpuinfo_numentries;
		loop invariant a2: \forall integer x; 0 <= x < i ==> (
				(xcbootinfo->cpuinfo_buffer[x].lapic_id < MAX_PLATFORM_CPUS) ==>
				(gp_s2_setuptss_invokehelper[x] == true)
						);
		loop assigns gp_s2_setuptss_invokehelper[0..(xcbootinfo->cpuinfo_numentries-1)];
		loop assigns i;
		loop variant xcbootinfo->cpuinfo_numentries - i;
	@*/
	for(i=0; i < xcbootinfo->cpuinfo_numentries; i++){

		if(xcbootinfo->cpuinfo_buffer[i].lapic_id < MAX_PLATFORM_CPUS){
			gp_s2_setuptss_settss(xcbootinfo->cpuinfo_buffer[i].lapic_id);
			//@ghost gp_s2_setuptss_invokehelper[i] = true;
		}

		/*u32 tss_idx = xcbootinfo->cpuinfo_buffer[i].lapic_id;

		memset(&__xmhfhic_x86vmx_tss[tss_idx], 0, sizeof(__xmhfhic_x86vmx_tss[tss_idx]));
		tss_t *tss= (tss_t *)__xmhfhic_x86vmx_tss[tss_idx].tss_mainblock;
		tss->esp0 = (u32) ( &__xmhfhic_x86vmx_tss_stack[tss_idx] + sizeof(__xmhfhic_x86vmx_tss_stack[0]) );
		tss->ss0 = __DS_CPL0;
		tss->iotbl_addr = (u32)&__xmhfhic_x86vmx_tss[tss_idx].tss_iobitmap - (u32)&__xmhfhic_x86vmx_tss[tss_idx].tss_mainblock;
		_XDPRINTF_("%s: tss_idx=%u, iotbl_addr=%x\n", __func__, tss_idx,
		       tss->iotbl_addr);
		*/
	}
}
