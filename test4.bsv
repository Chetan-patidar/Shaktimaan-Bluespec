package test4;

	(* synthesize *)
	module mkBoolCheck(Empty);
		Reg#(int) x <- mkReg(0);
		rule r1;
			Integer inx = 0;
			x <= x+1;
			
			Bool arr1[4];
			arr1[0] = True;
			for(Integer p =0 ;p<4;p=p+1)
				arr1[p] = True;
			inx = inx + 1;
			arr1[inx] = False;
			$display("Hello User %d %d",arr1[0],arr1[1]);
			if(x>3)
				$finish(0);
		endrule
	endmodule
endpackage: test4
