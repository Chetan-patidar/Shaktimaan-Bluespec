package test10;
import FIFO::* ;

	(* synthesize *)
	module mkTop(Empty);
		Server_int s <- mkAmazon;
		Client_int c <- mkGabbar;
		//connect flow of request from amazon server to Gabbar
		rule connect_request;
			let req <- c.get_request.get();
			s.put_request.put(req);
		endrule: connect_request

		rule connect_response;
		//connect flow of response from Gabbar to amazon server
			let req <- s.get_response.get();
			c.put_response.put(req);
		endrule: connect_response
	endmodule: mkTop

	interface Put_int;
		method Action put(int x);
	endinterface

	interface Get_int;
		method ActionValue#(int) get();
	endinterface




	interface Client_int;
		interface Get_int get_request;
		interface Put_int put_response;
	endinterface: Client_int

	interface Server_int;
		interface Get_int get_response;
		interface Put_int put_request;
	endinterface: Server_int

	
	module mkAmazon(Server_int);
		FIFO#(int) f_in <- mkFIFO;  //store incoming request
		FIFO#(int) f_out <- mkFIFO; //store outgoing response

		rule compute;
			let x = f_in.first;
			f_in.deq;
			let y = x+1;
			if(x==20) y = y+1;
			f_out.enq(y);
		endrule: compute

		interface Put_int put_request;
			method Action put(int x);
				$display("server put request value %d",x);
				f_in.enq(x);
			endmethod
		endinterface: put_request

		interface Get_int get_response;
			method ActionValue#(int) get();
				f_out.deq();
				$display("server get response value %d",f_out.first);
				return f_out.first;
			endmethod
		endinterface: get_response

	endmodule: mkAmazon



	
	module mkGabbar(Client_int);
		Reg#(int) x <- mkReg(0);
		FIFO#(int) f_out <- mkFIFO;  //buffer outgoing request
		FIFO#(int) f_in <- mkFIFO;   //buffer incoming response
		FIFO#(int) f_expected <- mkFIFO;

		rule r1;
			f_out.enq(x);
			x <= x + 10;
			f_expected.enq(x+1);
			//$display(" expexted value enque %d",x+1);
		endrule

		interface get_request = interface Get_int;
					method ActionValue#(int) get();
					f_out.deq; 
					$display("client get request value %d",f_out.first);
					return f_out.first;
					endmethod
					endinterface;
	
		interface Put_int put_response;
			method Action put(int y);
					$display("client put response value %d",y); 
					f_in.enq(y);
			endmethod
		endinterface

	endmodule: mkGabbar


			

endpackage: test10
