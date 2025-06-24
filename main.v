`timescale 1ns/1ps

module rowsignal(
  input [15:0] key,
  input [3:0] col,
  output reg [3:0] row
);
  
  always@(key or col)
    begin
      row[0] = key[0]&col[0] | key[1]&col[1] | key[2]&col[2] | key[3]&col[3];
      row[1] = key[4]&col[0] | key[5]&col[1] | key[6]&col[2] | key[7]&col[3];
      row[0] = key[8]&col[0] | key[9]&col[1] | key[10]&col[2] | key[11]&col[3];
      row[0] = key[12]&col[0] | key[13]&col[1] | key[14]&col[2] | key[15]&col[3];
    end
endmodule

module synchronizer(
  input [3:0] row,
  input clock,
  input reset,
  output reg s_row
);
  reg a_row;
  
  always@(negedge clock or posedge reset)
    begin
      if (reset)
        begin
          a_row <= 0;
          s_row <= 0;
        end
      else
        begin
           a_row <= row[0] | row[1] | row[2] | row[3];
           s_row <= a_row;
        end
    end
endmodule


module hex_keypad_scanner(
  input clock,
  input reset,
  input [3:0] row,
  input s_row,
  output reg [3:0] code,
  output valid,
  output reg [3:0] col
);
  reg [5:0] state, next_state;
  
  parameter S0 = 6'b000001, S1 = 6'b000010, S2 = 6'b000100, S3 = 6'b001000, S4 = 6'b010000, S5 = 6'b100000;
  
  assign Valid = ((state == S1) || (state == S2) || (state == S3) || (state == S4)) && row;
  
  always@(row or col)
    begin
      case({row,col})
        8'b0001_0001 : code = 0000;
        8'b0001_0010 : code = 0001;
        8'b0001_0100 : code = 0010;
        8'b0001_1000 : code = 0011;
        8'b0010_0001 : code = 0100;
        8'b0010_0010 : code = 0101;
        8'b0010_0100 : code = 0110;
        8'b0010_1000 : code = 0111;
        8'b0100_0001 : code = 1000;
        8'b0100_0010 : code = 1001;
        8'b0100_0100 : code = 1010;
        8'b0100_1000 : code = 1011;
        8'b1000_0001 : code = 1100;
        8'b1000_0010 : code = 1101;
        8'b1000_0100 : code = 1110;
        8'b1000_1000 : code = 1111;
        default : code = 0000;
      endcase
    end
        
  always@(posedge clock)
    begin
    if (reset)
      state <= S0;
    else
      state <= next_state;
    end
        
  always@(state or row or s_row)
    begin 
      next_state = state;
      col = 0;
      case(state)
        S0 : begin 
          		col = 15; 
          		if (s_row) 
                  next_state = S1;
        	 end
        S1 : begin
          		col = 1;
          		if (row)
                  next_state = S5;
          		else
                  next_state = S2;
             end
        S2 : begin
          		col = 2;
          		if (row)
                  next_state = S5;
          		else
                  next_state = S3;
        	 end
        S3 : begin
          		col = 4;
          		if (row)
                  next_state = S5;
          		else
                  next_state = S4;
        	 end
        S4 : begin
          		col = 8;
          		if (row)
                  next_state = S5;
          		else
                  next_state = S0;
        	 end
         S5 : begin
          		col = 1111;
           		if (row)
                  next_state = S5;
          		else
                  next_state = S0;
        	 end
      endcase
    end
        
endmodule
