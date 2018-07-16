// 五键输入，产生电机的控制信号，初始化时标定原点。
// 需要有传感器输入限位信号Stop。
module CtrlSystem(
	input rst,
	input sysclk,
	input Left,
	input Right,
	input Up,
	input Down,
	input Enter,
	input[5:0] Stop,
	output wire[5:0] PU, // 脉冲
	output wire[5:0] MF, // 上电
	output wire[5:0] DR // 方向
	);
	wire Busy, INIT;
	wire[3:0] TValue0, TValue1, TValue2;
	wire[5:0] Motor, MotorOut, DROut, initFlag;
	wire[9:0] PulseNum;

	Input inputpart(.rst(rst),.sysclk(sysclk),.INIT(INIT),
				.Left(Left),.Right(Right),.Up(Up),.Down(Down),.Enter(Enter),
				.TValue0(TValue0),.TValue1(TValue1),.TValue2(TValue2),
				.Motor(Motor));

	Control controlpart(.rst(rst),.sysclk(sysclk),
				.initFlag(initFlag),.INIT(INIT),.Busy(Busy),
				.TValue0(TValue0),.TValue1(TValue1),.TValue2(TValue2),.Motor(Motor),
				.MotorOut(MotorOut),.PulseNum(PulseNum),.DROut(DROut));

	Pulse pulsepart(.sysclk(sysclk),.Stop(Stop),
				.Motor(MotorOut),.PulseNum(PulseNum),.DRIn(DROut),
				.initFlag(initFlag),.INIT(INIT),.Busy(Busy),
				.PU(PU),.MF(MF),.DR(DR));
	// Display模块暂缺
endmodule