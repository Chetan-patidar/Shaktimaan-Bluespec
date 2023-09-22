package test9;

	(* synthesize *)
	module mkcheckActionValue(Empty);
		Reg#(int) cycle <- mkReg(0);
		M2_ifc m2 <- mkM2;
		rule r1;
			$display("Rule r1 is working");
			int p <- m2.push(5);
			$display("Value of p is %d",p);
			if(cycle>3)
				$finish(0);
			cycle <= cycle +1 ;
		endrule: r1
	endmodule: mkcheckActionValue

	interface M2_ifc;
		method ActionValue#(int) push(int x);
	endinterface

	(* synthesize *)
	module mkM2(M2_ifc);
		Reg#(int) r <- mkReg(0);
		method ActionValue#(int) push(int x);
			r <= r + x;
			return r;
		endmethod
	endmodule: mkM2
endpackage: test9
			
