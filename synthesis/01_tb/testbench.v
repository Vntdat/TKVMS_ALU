//`timescale 1ns/10ps

module testbench;
  reg clk, rst_n;
  reg [3:0] a, b;
  reg [2:0] op;
  reg [3:0] result;
  reg carry;

  synth_wrapper alu 	(	.clk(clk),
	  			.rst_n(rst_n),
				.a(a),
				.b(b),
				.op (op),
				.result (result),
				.carry (carry)
			);

  initial begin
    $shm_open("waves.shm"); 
    $shm_probe("AS");
  end
  //initial begin
  //   $sdf_annotate("synth_wrapper.sdf",full_adder);
  //end

  initial begin
        #0 clk=1;
     forever #5 clk=~clk;
  end


  // Test procedure
  initial begin
    #0; 
    rst_n = 0;


    // Reset pulse
    #30;
    rst_n = 1;
    stimuli(4'h3, 4'h2, 3'b000);  // add khong tran
    stimuli(4'h5, 4'hF, 3'b000);  // add co tran
    stimuli(4'hA, 4'h3, 3'b001);  // sub a > b
    stimuli(4'h3, 4'hA, 3'b001);  // sub a < b
    stimuli(4'h7, 4'h5, 3'b010);  // and
    stimuli(4'h7, 4'h5, 3'b011);  // or
    stimuli(4'h7, 4'h3, 3'b100);  // xor
    stimuli(4'h6, 4'h1, 3'b101);  // not
    stimuli(4'hF, 4'h1, 3'b110);  // shift right 1 bit
    stimuli(4'hF, 4'h2, 3'b110);  // shift right 2 bit
    stimuli(4'hF, 4'h3, 3'b110);  // shift right 3 bit
    stimuli(4'hF, 4'h4, 3'b110);  // shift right 4 bit
    stimuli(4'hF, 4'h1, 3'b111);  // shift left 1 bit
    stimuli(4'hF, 4'h2, 3'b111);  // shift left 2 bit
    stimuli(4'hF, 4'h3, 3'b111);  // shift left 3 bit
    stimuli(4'hF, 4'h4, 3'b111);  // shift left 4 bit
    #200;
    $finish;
  end

  task stimuli(input [3:0] a_in,b_in, input [2:0] op_in);
     @(posedge clk) 
     {a,b,op} = {a_in,b_in,op_in};
      #10;
  endtask

endmodule

