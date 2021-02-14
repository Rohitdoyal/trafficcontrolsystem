`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:44:43 01/29/2021 
// Design Name: 
// Module Name:    project 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module traffic_control(GSN1,GSN2,GWE1,GWE2,RWE,RNS,SN1D1,SN1D2,SN2D1,SN2D2,WE1D1,WE1D2,WE2D1,WE2D2,CLK,RESET);

output GSN1,GSN2,GWE1,GWE2,RWE,RNS;
output [6:0]SN1D1;
output [6:0]SN1D2;
output [6:0]SN2D1;
output [6:0]SN2D2;
output [6:0]WE1D1;
output [6:0]WE1D2;
output [6:0]WE2D1;
output [6:0]WE2D2;

reg GSN1,GSN2,GWE1,GWE2,RWE,RNS;
reg [6:0]SN1D1;
reg [6:0]SN1D2;
reg [6:0]SN2D1;
reg [6:0]SN2D2;
reg [6:0]WE1D1;
reg [6:0]WE1D2;
reg [6:0]WE2D1;
reg [6:0]WE2D2;


input CLK,RESET;

reg [1:0] state;

parameter [1:0]s0 =2'b00;
parameter [1:0]s1 =2'b01;
parameter [1:0]s2 =2'b10;
parameter [1:0]s3 =2'b11;

reg[3:0] count;
reg[3:0] sn1segment1;
reg[3:0] sn1segment2;
reg[3:0] sn2segment1;
reg[3:0] sn2segment2;
reg[3:0] we1segment1;
reg[3:0] we1segment2;
reg[3:0] we2segment1;
reg[3:0] we2segment2;


task display;
input [3:0]a;
output [6:0]o;

	begin
	case(a)
	4'b0000:
	begin
	o[0]=1;o[1]=1;o[2]=1;o[3]=1;o[4]=1;o[5]=1;o[6]=0;
	end

	4'b0001:
	begin
	o[0]=0;o[1]=1;o[2]=1;o[3]=0;o[4]=0;o[5]=0;o[6]=0;
	end

	4'b0010:
	begin
	o[0]=1;o[1]=1;o[2]=0;o[3]=1;o[4]=1;o[5]=0;o[6]=1;
	end

	4'b0011:
	begin
	o[0]=1;o[1]=1;o[2]=1;o[3]=1;o[4]=0;o[5]=0;o[6]=1;
	end

	4'b0100:
	begin
	o[0]=0;o[1]=1;o[2]=1;o[3]=0;o[4]=0;o[5]=1;o[6]=1;
	end

	4'b0101:
	begin
	o[0]=1;o[1]=0;o[2]=1;o[3]=1;o[4]=0;o[5]=1;o[6]=1;
	end

	4'b0110:
	begin
	o[0]=1;o[1]=0;o[2]=1;o[3]=1;o[4]=1;o[5]=1;o[6]=1;
	end

	4'b0111:
	begin
	o[0]=1;o[1]=1;o[2]=1;o[3]=0;o[4]=0;o[5]=0;o[6]=1;
	end

	4'b1000:
	begin
	o[0]=1;o[1]=1;o[2]=1;o[3]=1;o[4]=1;o[5]=1;o[6]=1;
	end

	4'b1001:
	begin
	o[0]=1;o[1]=1;o[2]=1;o[3]=1;o[4]=0;o[5]=1;o[6]=1;
	end

	endcase
	end
endtask




always@(posedge CLK,posedge RESET)
begin
if(RESET==1)
	begin
	state=s0;
	count=4'b0000;
	
	sn2segment1=4'b0001;
	sn2segment2=4'b0101;
	
	we1segment1=4'b0011;
	we1segment2=4'b0000;
	
	we2segment1=4'b0100;
	we2segment2=4'b0101;
	end

else
begin
	if(sn1segment1!=0 && sn1segment2==0)
		begin
		sn1segment1=sn1segment1-1;
		sn1segment2=4'b1010;
		end
	
	if(sn2segment1!=0 && sn2segment2==0)
		begin
		sn2segment1=sn2segment1-1;
		sn2segment2=4'b1010;
		end
		
	if(we1segment1!=0 && we1segment2==0)
		begin
		we1segment1=we1segment1-1;
		we1segment2=4'b1010;
		end
		
	if(we2segment1!=0 && we2segment2==0)
		begin
		we2segment1=we2segment1-1;
		we2segment2=4'b1010;
		end

 case(state)
s0 :
	begin
	if(count==4'b1111)
	begin
	state = s1;
	count=4'b0000;
	sn1segment1 = 4'b0100;
	sn1segment2 = 4'b0101;
	
	sn2segment1=4'b0000;
	sn2segment2=4'b0000;
	
		
	sn1segment2=sn1segment2-4'b0001;
	we1segment2=we1segment2-4'b0001;
	we2segment2=we2segment2-4'b0001;
	
	display(sn1segment1,SN1D1);
	display(sn1segment2,SN1D2);
	
	display (sn2segment1,SN2D1);
	display (sn2segment2,SN2D2);
	
	display (we1segment1,WE1D1);
	display (we1segment2,WE1D2);
	
	display (we2segment1,WE2D1);
	display (we2segment2,WE2D2);
	
	

	
	end
	
	else
	begin
	count=count+4'b0001;
	state=s0;
	
	sn1segment1=4'b0000;
	sn1segment2=4'b0000;
	
	
	sn2segment2=sn2segment2-4'b0001;
	we1segment2=we1segment2-4'b0001;
	we2segment2=we2segment2-4'b0001;
	
	display (sn1segment1[3:0],SN1D1[6:0]);
	display (sn1segment2,SN1D2);
	
	display (sn2segment1,SN2D1);
	display (sn2segment2,SN2D2);
	
	display (we1segment1,WE1D1);
	display (we1segment2,WE1D2);
	
	display (we2segment1,WE2D1);
	display (we2segment2,WE2D2);

	end
	end
	
	
s1: 
	begin
	if(count==4'b1111)
	begin
	state=s2;
	count=4'b0000;
	sn2segment1 = 4'b0100;
	sn2segment2 = 4'b0101;

	we1segment1=4'b0000;
	we1segment2=4'b0000;
	
	sn1segment2=sn1segment2-4'b0001;
	sn2segment2=sn2segment2-4'b0001;
	we2segment2=we2segment2-4'b0001;
	
	display (sn1segment1,SN1D1);
	display (sn1segment2,SN1D2);
	
	display (sn2segment1,SN2D1);
	display (sn2segment2,SN2D2);
	
	display (we1segment1,WE1D1);
	display (we1segment2,WE1D2);
	
	display (we2segment1,WE2D1);
	display (we2segment2,WE2D2);
	

	end

	else
	begin
	count=count+1;
	state=s1;

	sn2segment1=4'b0000;
	sn2segment2=4'b0000;
	
	sn1segment2=sn1segment2-4'b0001;
	we1segment2=we1segment2-4'b0001;
	we2segment2=we2segment2-4'b0001;
	
	display (sn1segment1,SN1D1);
	display (sn1segment2,SN1D2);
	
	display (sn2segment1,SN2D1);
	display (sn2segment2,SN2D2);
	
	display (we1segment1,WE1D1);
	display (we1segment2,WE1D2);
	
	display (we2segment1,WE2D1);
	display (we2segment2,WE2D2);



	end
	end

s2:
	begin
	if(count==4'b1111)
	begin
	state =s3;
	count=4'b0000;
	we1segment1 = 4'b0100;
	we1segment2 = 4'b0101;
	
	we2segment1=4'b0000;
	we2segment2=4'b0000;
	
	sn1segment2=sn1segment2-4'b0001;
	sn2segment2=sn2segment2-4'b0001;
	we1segment2=we1segment2-4'b0001;
	
	display (sn1segment1,SN1D1);
	display (sn1segment2,SN1D2);
	
	display (sn2segment1,SN2D1);
	display (sn2segment2,SN2D2);
	
	display (we1segment1,WE1D1);
	display (we1segment2,WE1D2);
	
	display (we2segment1,WE2D1);
	display (we2segment2,WE2D2);




	end

	else
	begin
	count=count+4'b0001;
	state=s2;
	
	we1segment1=4'b0000;
	we1segment2=4'b0000;
	
	sn1segment2=sn1segment2-4'b0001;
	sn2segment2=sn2segment2-4'b0001;
	we2segment2=we2segment2-4'b0001;
	
	display (sn1segment1,SN1D1);
	display (sn1segment2,SN1D2);
	
	display (sn2segment1,SN2D1);
	display (sn2segment2,SN2D2);
	
	display (we1segment1,WE1D1);
	display (we1segment2,WE1D2);
	
	display (we2segment1,WE2D1);
	display (we2segment2,WE2D2);
	end
	end
	
s3:
	begin
	if(count==4'b1111)
	begin
	state =s0;
	count=4'b0000;
	we2segment1 = 4'b0100;
	we2segment2 = 4'b0101;
	
	sn1segment1=4'b0000;
	sn1segment2=4'b0000;
	
	sn2segment2=sn2segment2-4'b0001;
	we1segment2=we1segment2-4'b0001;
	we2segment2=we2segment2-4'b0001;
	
	display (sn1segment1,SN1D1);
	display (sn1segment2,SN1D2);
	
	display (sn2segment1,SN2D1);
	display (sn2segment2,SN2D2);
	
	display (we1segment1,WE1D1);
	display (we1segment2,WE1D2);
	
	display (we2segment1,WE2D1);
	display (we2segment2,WE2D2);
	
	
	
	end
	
	else
	begin
	count=count+4'b0001;
	state=s3;
	
	we2segment1=4'b0000;
	we2segment2=4'b0000;
	
	sn1segment2=sn1segment2-4'b0001;
	sn2segment2=sn2segment2-4'b0001;
	we1segment2=we1segment2-4'b0001;
	
	display (sn1segment1,SN1D1);
	display (sn1segment2,SN1D2);
	
	display (sn2segment1,SN2D1);
	display (sn2segment2,SN2D2);
	
	display (we1segment1,WE1D1);
	display (we1segment2,WE1D2);
	
	display (we2segment1,WE2D1);
	display (we2segment2,WE2D2);
	
	
	
	end
	end


endcase
end
end

always@(state)
begin
case(state)
s0: 
	begin
	GSN1=1;GSN2=0;GWE1=0;RNS=0;
	RWE=1;GWE2=0;
	end
	
	
s1: 
	begin
	GSN1=0;GSN2=1;GWE1=0;RNS=0;
	RWE=1;GWE2=0;
	end
	
	
s2: 
	begin
	GSN1=0;GSN2=0;GWE1=1;RNS=1;
	RWE=0;GWE2=0;
	end
	
	
s3: 
	begin
	GSN1=0;GSN2=0;GWE1=0;RNS=1;
	RWE=0;GWE2=1;
	end
	
endcase
end


endmodule

