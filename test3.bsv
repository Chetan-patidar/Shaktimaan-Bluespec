package test3;
import FIFO::*;
	(* synthesize *)
	module mkTb1(Empty);
	FIFO#(int) f1 <- mkFIFO;
	FIFO#(int) f2 <- mkFIFO;
	FIFO#(int) f3 <- mkFIFO;
	FIFO#(int) f4 <- mkFIFO;
		rule r1;
			f1.enq(0);
			int v1 = f1.first;
			f1.deq();
			$display("V1 = %d",v1);
			f2.enq(v1 + 1);
		endrule

		rule r2;
			int v2 = f2.first;
			f2.deq();
			$display("V2 = %d",v2);
			f3.enq(v2 + 1);
		endrule
		
		rule r3;
			int v3 = f3.first;
			f3.deq();
			$display("V3 = %d",v3);
			f4.enq(v3 + 1);
		endrule

		rule r4;
			int v4 = f4.first;
			$display("V4 = %d",v4);
			f4.deq();
			if(v4==5)
				$finish();
		endrule
	endmodule: mkTb1

endpackage: test3
