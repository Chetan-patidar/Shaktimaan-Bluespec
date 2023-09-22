package test2;
import FIFO::*;
	(* synthesize *)
	module mkModule1(Empty);
		Reg#(int) a <- mkReg(0);
		Reg#(int) cycle <- mkReg(1);
		Module2_ifc id <- mkModule2;
		rule first;
			id.fill(a);
			cycle <= cycle + 1;
		endrule: first
		
		rule second;
		let y = id.drain;
		$display("Value drained by interface %d",y);
		if(cycle>7)
			$finish();
		endrule
	endmodule: mkModule1



	interface Module2_ifc;
		method Action fill(int a);
		method ActionValue#(int) drain;
	endinterface
	(* synthesize *)
	module mkModule2(Module2_ifc);
		FIFO#(int) x1 <- mkFIFO;
		FIFO#(int) x2 <- mkFIFO;
		FIFO#(int) x3 <- mkFIFO;
		FIFO#(int) x4 <- mkFIFO;

		rule r1;
			let v1 = x1.first;
			$display("v1 = %d",v1);
			x1.deq();
			x2.enq(v1 + 1);	
		endrule: r1

		rule r2;
                        let v2 = x2.first;
                        $display("v2 = %d",v2);
                        x2.deq();
                        x3.enq(v2 + 1);
                endrule: r2

		rule r3;
                        let v3 = x3.first;
                        $display("v3 = %d",v3);
                        x3.deq();
                        x4.enq(v3 + 1);
                endrule: r3



		method Action fill(int a);
			x1.enq(a);
		endmethod

		method ActionValue#(int) drain();
			let v4 = x4.first;
			x4.deq();
			$display("V4 = %d",v4);
			return v4;
		endmethod

	endmodule: mkModule2
			
			
	
endpackage: test2
