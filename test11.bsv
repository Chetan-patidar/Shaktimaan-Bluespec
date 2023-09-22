package test11;
import FIFO::* ;
import GetPut::*;
import ClientServer::*;
import Connectable::*;

	(* synthesize *)
	module mkTb(Empty);
		Client#(int,int) c <- mkGabbar;
		Server#(int,int) s <- mkAmazon;

		mkConnection(c,s);
	endmodule: mkTb

	module mkGabbar(Client#(int,int));
		Reg#(int) x <- mkReg(0);
		FIFO#(int) f_in <- mkFIFO;
		FIFO#(int) f_out <- mkFIFO;
		rule r1;
			$display("Client get request %d",x);
			f_out.enq (x);
			x <= x + 10;
		endrule	

		interface response = toPut(f_in);
		interface request  = toGet(f_out);
	endmodule: mkGabbar


	module mkAmazon(Server#(int,int));
		FIFO#(int) f_in <- mkFIFO;
                FIFO#(int) f_out <- mkFIFO;

		rule r2;
			let x = f_in.first;
			 $display("Server put request %d",x);
			f_in.deq;
			let y = x+1;
			//if (x == 20) y = y + 1;
			f_out.enq (y);
			$display("Server storing response for next cycle %d",y);
		endrule		
                interface request = toPut(f_in);
                interface response  = toGet(f_out);

	endmodule: mkAmazon


endpackage: test11
		
