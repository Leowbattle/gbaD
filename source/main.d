extern (C) void doit();

enum IORAM = cast(ubyte*)0x04000000;	
enum VRAM = cast(ushort*)0x06000000;

extern (C) int main() {	
	IORAM[0] = 0x03;
	IORAM[1] = 0x04;

	VRAM[80 * 240 + 120] = 0x001f;

	doit();

	return 0;
}
