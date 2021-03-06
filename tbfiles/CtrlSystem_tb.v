`timescale 1ns/1ps
//`timescale 1ns/1ns // JUST FOR TEST !!
// Ctrlsystem测试文件
module CtrlSystem_tb;
reg sysclk;
reg L, R, U, D, E;
reg[5:0] Stop;
wire[1:0] Num; // 位号
wire LCD_Enable; // LCD使能信号
wire[3:0] LCD_Num; // LCD显示数字
wire[5:0] PU, MF, DR;

initial begin
	sysclk = 0;
	L = 0; R = 0; U = 0; D = 0; E = 0;
	Stop = 0;
	// 共6个电机：0,1,2,3,4,5
	#5000 Stop = 6'b00_0001;
	#2000 Stop = 0;         // 0标定
	#10000 Stop = 6'b00_0010;
	#2000 Stop = 0;         // 1标定
	#3000 Stop = 6'b00_0100;
	#2000 Stop = 0;         // 2标定
	#5000 Stop = 6'b00_1000;
	#2000 Stop = 0;         // 3标定
	#7000 Stop = 6'b01_0000;
	#2000 Stop = 0;         // 4标定
	#4000 Stop = 6'b10_0000;
	#2000 Stop = 0;         // 5标定

	#10000 U = 1;
	#10 U = 0; // 模拟按键抖动
	#10 U = 1;
	#10 U = 0;
	#10 U = 1;
	#1000 U = 0;			// 1号
	#10 U = 1;
	#10 U = 0;
	#10 U = 1;
	#10 U = 0;
	#1000 U = 0;			// 1号
	#10000 D = 1;
	#1000 D = 0;			// 0号
	#10000 D = 1;
	#1000 D = 0;			// 5号

	#10000 R = 1;		// 百位
	#1000 R = 0;
	#10000 R = 1;		// 十位
	#1000 R = 0;
	#10000 R = 1;		// 个位
	#1000 R = 0;
	#10000 U = 1;
	#1000 U = 0;			// 1
	#10000 L = 1;
	#1000 L = 0;			// 十位
	#10000 U = 1;
	#1000 U = 0;			// 1
	#10000 E = 1;
	#1000 E = 0;		// 设定5号电机坐标为011

	#100000 D = 1;		// 0
	#1000 D = 0;
	#10000 R = 1;		// 个位
	#1000 R = 0;
	#10000 D = 1;		// 0
	#1000 D = 0;
	#100000 D = 1;		// 9
	#1000 D = 0;
	#100000 D = 1;
	#1000 D = 0;			// 8
	#10000 E = 1;
	#1000 E = 0;		// 设定5号电机坐标为008

	#100000 R = 1;		// 电机位
	#1000 R = 0;
	#10000 U = 1;			// 0
	#1000 U = 0;
	#10000 U = 1;
	#1000 U = 0;			// 1

	#10000 L = 1;		// 个位
	#1000 L = 0;
	#10000 U = 1;			// 9
	#1000 U = 0;
	#10000 U = 1;			// 0
	#1000 U = 0;
	#10000 U = 1;			// 1
	#1000 U = 0;
	#10000 L = 1;		// 十位
	#1000 L = 0;
	#10000 U = 1;			// 1
	#1000 U = 0;
	#10000 E = 1;
	#1000 E = 0;		// 设定1号电机坐标为011
end

always #5 sysclk = ~sysclk;

CtrlSystem CSpart(.sysclk(sysclk),.Stop(Stop),.L(L),.R(R),.U(U),.D(D),.E(E),
			.Num(Num),.LCD_Enable(LCD_Enable),.LCD_Num(LCD_Num),
			.PU(PU),.MF(MF),.DR(DR));
endmodule
