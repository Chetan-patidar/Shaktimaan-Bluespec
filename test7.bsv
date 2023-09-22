package test7;

	(* synthesize *)
	module mkCheck(Empty);
		Reg#(int) x <- mkReg(0);

		rule r1(x<2);
			int y = x+1;
			x <= x +1;
			$display("x = %d and y = %d",x,y);
		endrule: r1

		rule r2(x==2);
			$finish(0);
		endrule: r2
	endmodule: mkCheck
endpackage: test7
