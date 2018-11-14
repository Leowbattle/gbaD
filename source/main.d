extern (C) void doit();

extern (C) int main() {
	ubyte* IORAM = cast(ubyte*)0x04000000;	
	ushort* VRAM = cast(ushort*)0x06000000;

	IORAM[0] = 0x03;
	IORAM[1] = 0x04;

	VRAM[80 * 240 + 120] = 0x001f;

	doit();

	return 0;
}
