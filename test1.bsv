package test1;

	(* synthesize *)
	module mkTb(Empty);
		Reg#(int) x1 <- mkReg(8);
		Reg#(int) y1 <- mkReg(5);
		Reg#(int) cycle <- mkReg(1);
		(* descending_urgency = "second,first" *)
		rule first;
			$display("First");
			cycle <= cycle + 1;
			x1 <= y1 + 1;
		endrule: first
		
		(* descending_urgency = "second,first" *)
		rule second(cycle==1);
			$display("second");
			y1 <= x1 + 1;
			cycle <= cycle + 1;
		endrule: second

		rule third(cycle == 3);
			$display("Third");
			$finish();
		endrule: third
	endmodule: mkTb

endpackage: test1
	




