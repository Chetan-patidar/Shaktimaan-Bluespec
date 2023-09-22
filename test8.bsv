package test8;

	(* synthesize *)
	module mkcheckParameter(Empty);
	
		M2_ifc m1 <- mkM2(20);
		Reg#(int) cycle <- mkReg(0);
		rule r1;
			if(cycle>3)
				$finish(0);
			$display("Rule r1 is working");
			cycle<=cycle+1;
		endrule: r1
	endmodule: mkcheckParameter

	interface M2_ifc;

	endinterface
	(* synthesize *)
	module mkM2#(parameter int init)(M2_ifc);
		Reg#(int) r <- mkReg(init);
		rule r2;
			$display("Rule r2 is working with r value %d",r);
		endrule: r2
	endmodule: mkM2
endpackage: test8
