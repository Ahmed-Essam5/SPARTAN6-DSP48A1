module DSP48A1_Project_tb ();
	reg [17:0]a,b,d;
	reg [47:0]c;
	reg carryin;
	wire [35:0]m;
	wire [47:0]p;
	wire carryout,carryoutf;
	reg clk;
	reg [7:0]opmode;
	reg cea,ceb,cec,cecarryin,ced,cem,ceopmode,cep; //cecarryin for carry in/out
	reg rsta,rstb,rstc,rstcarryin,rstd,rstm,rstopmode,rstp; //same in rstcarryin
	reg [17:0]bcin; //forgot bcin
	wire [17:0]bcout;
	reg [47:0]pcin;
	wire [47:0]pcout;

	reg [47:0]p_ex;
	reg [47:0]pcout_ex;
	reg [35:0]m_ex;
	reg [17:0]bcout_ex;
	reg carryout_ex;
	reg carryoutf_ex;

	reg [3:0] iteration;

	DSP48A1_Project tb0 (a,b,d,c,carryin,m,p,carryout,carryoutf,clk,opmode,cea,ceb,cec,cecarryin,ced,cem,ceopmode,cep,rsta,rstb,rstc,rstcarryin,rstd,rstm,rstopmode,rstp,bcin,bcout,pcin,pcout);

	initial begin
		clk=0;
		forever
		#2 clk=~clk;
	end

	initial begin
//0		
		iteration=0;
		rsta=1;rstb=1;rstc=1;rstcarryin=1;rstd=1;rstm=1;rstopmode=1;rstp=1;
		cea=1;ceb=1;cec=1;cecarryin=1;ced=1;cem=1;ceopmode=1;cep=1;
		a=1;b=10;d=100;c=400;carryin=0;opmode=8'b0011_0001;bcin=5000;pcin=2500;
		p_ex=0;pcout_ex=0;m_ex=0;bcout_ex=0;carryout_ex=0;carryoutf_ex=0;
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		if ((p_ex!=p)||(pcout_ex!=pcout)||(m_ex!=m)||(bcout_ex!=bcout)||(carryout_ex!=carryout)||(carryoutf_ex!=carryoutf)) begin
			$display("error");
			$stop;
		end
//1		
		iteration=1;
		rsta=0;rstb=0;rstc=0;rstcarryin=0;rstd=0;rstm=0;rstopmode=0;rstp=0;
		cea=1;ceb=1;cec=1;cecarryin=1;ced=1;cem=1;ceopmode=1;cep=1;
		a=10;b=100;d=1000;c=4000;carryin=0;opmode=8'b0011_0001;bcin=500;pcin=250;
		p_ex=11001;pcout_ex=11001;m_ex=11000;bcout_ex=1100;carryout_ex=0;carryoutf_ex=0;
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		if ((p_ex!=p)||(pcout_ex!=pcout)||(m_ex!=m)||(bcout_ex!=bcout)||(carryout_ex!=carryout)||(carryoutf_ex!=carryoutf)) begin
			$display("error");
			$stop;
		end
//2		
		iteration=2;
		rsta=0;rstb=0;rstc=0;rstcarryin=0;rstd=0;rstm=0;rstopmode=0;rstp=0;
		cea=1;ceb=1;cec=1;cecarryin=1;ced=1;cem=1;ceopmode=1;cep=1;
		a=1;b=10;d=100;c=400;carryin=0;opmode=8'b0011_0110;bcin=5000;pcin=2500;
		p_ex=13502/*pcin+p*/;pcout_ex=13502;m_ex=110;bcout_ex=110;carryout_ex=0;carryoutf_ex=0;
		@(negedge clk);
		@(negedge clk);
		if ((p_ex!=p)||(pcout_ex!=pcout)) begin //because P will continue to add with each clock cycle and m will not reach its real value
			$display("error");
			$stop;
		end
		@(negedge clk);
		if ((m_ex!=m)||(bcout_ex!=bcout)||(carryout_ex!=carryout)||(carryoutf_ex!=carryoutf)) begin
			$display("error");
			$stop;
		end
//3		
		iteration=3;
		rsta=0;rstb=0;rstc=0;rstcarryin=0;rstd=0;rstm=0;rstopmode=0;rstp=0;
		cea=1;ceb=1;cec=1;cecarryin=1;ced=1;cem=1;ceopmode=1;cep=1;
		a=500;b=120;d=1050;c=16000;carryin=0;opmode=8'b0101_1101;bcin=8000;pcin=5200;
		p_ex=481000/*c+m*/;pcout_ex=481000;m_ex=465000;bcout_ex=930/*d-b*/;carryout_ex=0;carryoutf_ex=0;
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		if ((p_ex!=p)||(pcout_ex!=pcout)||(m_ex!=m)||(bcout_ex!=bcout)||(carryout_ex!=carryout)||(carryoutf_ex!=carryoutf)) begin
			$display("error");
			$stop;
		end
//4		
		iteration=4;
		rsta=0;rstb=0;rstc=0;rstcarryin=0;rstd=0;rstm=0;rstopmode=0;rstp=0;
		cea=1;ceb=1;cec=1;cecarryin=1;ced=1;cem=1;ceopmode=1;cep=1;
		a=1;b=120;d=0;c=16000;carryin=0;opmode=8'b0110_0111;bcin=8000;pcin=5200;
		p_ex=19'b1000001010011001001/*pcin+{D:A:B}+opmode5*/;pcout_ex=19'b1000001010011001001;m_ex=120/*b*A*/;bcout_ex=120/*b*/;
		carryout_ex=0;carryoutf_ex=0;
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		if ((p_ex!=p)||(pcout_ex!=pcout)||(m_ex!=m)||(bcout_ex!=bcout)||(carryout_ex!=carryout)||(carryoutf_ex!=carryoutf)) begin
			$display("error");
			$stop;
		end
//5		
		iteration=5;
		rsta=0;rstb=0;rstc=0;rstcarryin=0;rstd=0;rstm=0;rstopmode=0;rstp=0;
		cea=1;ceb=1;cec=1;cecarryin=1;ced=1;cem=1;ceopmode=1;cep=1;
		a=500;b=120;d=1050;c=16000;carryin=0;opmode=8'b0011_0000;bcin=8000;pcin=5200;
		p_ex=1/*opcode5*/;pcout_ex=1;m_ex=585000;bcout_ex=1170/*d-b*/;carryout_ex=0;carryoutf_ex=0;
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		if ((p_ex!=p)||(pcout_ex!=pcout)||(m_ex!=m)||(bcout_ex!=bcout)||(carryout_ex!=carryout)||(carryoutf_ex!=carryoutf)) begin
			$display("error");
			$stop;
		end
//6		
		iteration=6;
		rsta=0;rstb=0;rstc=0;rstcarryin=0;rstd=0;rstm=0;rstopmode=0;rstp=0;
		cea=1;ceb=1;cec=1;cecarryin=1;ced=1;cem=1;ceopmode=1;cep=1;
		a=500;b=120;d=1050;c=16000;carryin=0;opmode=8'b0011_1010;bcin=8000;pcin=5200;
		p_ex=3/*p+p+opmode5*/;pcout_ex=3;m_ex=585000;bcout_ex=1170/*d-b*/;carryout_ex=0;carryoutf_ex=0;
		@(negedge clk);
		@(negedge clk); // no problem here because m still at the same value from the previous iteration
		if ((p_ex!=p)||(pcout_ex!=pcout)||(m_ex!=m)||(bcout_ex!=bcout)||(carryout_ex!=carryout)||(carryoutf_ex!=carryoutf)) begin
			$display("error");
			$stop;
		end
		$stop;
	end

	initial begin
		$monitor("iteration=%d,bcout=%d ,bcout_ex=%d ,m=%d ,m_ex=%d ,p=%d ,p_ex=%d ,pcout=%d ,pcout_ex=%d ,carryout=%d ,carryout_ex=%d",iteration ,bcout ,bcout_ex ,m ,m_ex ,p ,p_ex ,pcout ,pcout_ex ,carryout ,carryout_ex);
	end

endmodule