package test6;

	(* synthesize *)
	module mkStringCheck(Empty);

		function Action passString(String s);
			return action
				$display("Passed valued is ==>",s);
			endaction;
		endfunction

		Reg#(int) x <- mkReg(0);	
		rule r1;
			x <= x + 1;
			passString("Hello Gabbar you are back");
			if(x>3)
				$finish(0);
		endrule
	endmodule: mkStringCheck
endpackage: test6
