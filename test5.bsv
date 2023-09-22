package test5;
	
	(* synthesize *)
	module mkPrint(Empty);
		Reg#(int) x <- mkReg(0);
		rule r1;
			x <= x +1 ;
			for(Integer p=1;p<=10;p = p+1)
				$display("Hello print %d",fromInteger(p));
			if(x>2)
				$finish(0);
		endrule: r1
	endmodule: mkPrint
endpackage: test5
